Lightning-to-Lead tutorial
==========================

Simple tutorial for Lightning on the Salesforce1 Platform that teaches a few core concepts:

* Using standard Lightning text input components
* Using a standard Lightning button component to "submit" a form
* Calling an Apex method asynchronously, passing an sObject parameter and handling a return value

This tutorial serves as a primer for the more complex Expenses app tutorial in the [Lightning Components Developer's Guide](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/qs_intro.htm).

### Before you begin

Complete the [prerequisites](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/qs_aotp_prereq.htm) described in the Lightning Components Developer's Guide.

### Create the oneLead application bundle

1. Open the **Developer Console**
2. Click **File** > New > Lightning Application
3. For **Name**, enter "oneLead"

In Lightning, **components** are the building blocks. An **application** is really just a special component that has a unique URL through which it can be opened and used.

To make life easier for developers and to foster good coding practices, Lightning components are all created as **[bundles](https://developer.salesforce.com/docs/atlas.en-us.lightning.meta/lightning/components_bundle.htm)**.

If you're familiar with Visualforce, think of a Lightning application as the equivalent of a Visualforce page. The .app file is where all of the Lightning markup is written, similarly to how all Visualforce markup is written in a .page file.

### Hello, Lightning-to-Lead!

Write the following code inside the `aura:application` element within oneLead.app.

```aura
<h1>Lightning-to-Lead</h1>
```

Save the markup, and then click **Preview** or **Update Preview** in the right sidebar of the Developer Console to make sure your app runs.

### Add input elements to the app

Let's add a few input elements for visual effect on the page, without worrying about binding the inputs to anything just yet. Basically, just create a bunch of `ui:inputText`, `ui:inputEmail` and `ui:inputPhone` elements for whatever fields you want to fill in when creating a new lead. Below is a sample of how each element should look in your application markup.

```aura
<ui:inputText aura:id="lastName"
              label="Last Name"
              required="true"/>
```

If you're wondering about `aura:id`, you should know that for this tutorial we technically don't need to use the attribute. What's important to know about the attribute is that you need to specify an `aura:id` if you ever want to interact with the element programmatically. `aura:id` must be unique within the scope of the component being edited (e.g., oneLead.app in our case), similar to how the `id` attribute works in Visualforce.

### Add a button to the app

Finish off the visual work by adding a **Submit** button after all of the input fields.

```aura
<ui:button label="Submit" press="{!c.save}"/>
```

Notice the `press` attribute, which holds a special Lightning expression that ties the button to a Lightning component _controller action_. Whenever you see the prefix `c.` in Lightning, think "controller". So in your mind, `c.save` naturally should conjure up an association with the application (_not_ Apex) controller's `save` action.

Great, but let's not take the `save` action for granted! The action's not going to define itself; we've got to define the action as a next step.

### Define the `save` action

1. In the Developer Console, with oneLead.app opened up, click **CONTROLLER** in the right sidebar. This should automatically cause a new tab to appear in the console titled, "oneLeadController.js".
2. Taking note of the sample action that's automatically generated for you, replace the name of the action with the word **save**, which we specified in the `ui:button`'s `press` attribute.

For kicks and giggles, and as a checkpoint for you to make sure that your button's connected to the controller action, use `alert()` inside the action to display a message when someone clicks the Submit button.

```javascript
save : function(component, event, helper) {
    alert('save action invoked');
}
```

### Bind inputs to a new sObject instance

Let's put the input elements to work! Knowing that our end goal is to fill in the data for a new Lead record, it would make sense to set up a shell of the Lead record and simply have the input elements fill in the Lead fields directly.

The first step is to create a place where values can be stored, and with Lightning those places are defined in a component using `aura:attribute` tags.

```aura
<aura:application>
    <aura:attribute name="lead" type="Lead"
                    default="{
                        'sobjectType': 'Lead',
                        'FirstName': 'John',
                        'LastName': 'Doe',
                        'Company': 'Doe Industries, LLC'
                    }"/>
...
```

It's important to note that **you must explicitly define default values** for all fields to which you are going to bind inputs. Otherwise you'll get [null pointer errors](http://salesforce.stackexchange.com/questions/54821/elegant-initialization-of-lightning-auraattribute).

Then, with the sObject variable effectively defined, now you can bind your inputs by simply adding a `value` attribute to each `ui:inputText` (or equivalent).

```aura
<aura:inputText aura:id="lastName"
                label="Last Name"
                value="{!v.lead.LastName}"
                required="true"/>
```

Note the use of the "v." prefix when addressing the newly defined `lead` aura:attribute in the Lightning expression. Think of "v." as being a prefix that refers to things in the "view", meaning that they're things that are _not_ defined in the controller.

### Reference the aura:attribute in the Lightning controller

To reference the attribute in the Lightning controller, all you need to do is invoke the `get(String)` instance method for the component. Update the `save` action to display the lead's Last Name.

```javascript
save : function(component, event, helper) {
    var theLead = component.get("v.lead");
    alert(theLead.LastName);
}
```

Again, note the use of the "v." prefix to grab the lead aura:attribute that was defined in the _view_. Try updating the preview for your app, and you should now get an alert pop-up that tells the Last Name entered for the lead.

### Create an Apex controller to perform DML operations

Similarly to Visualforce, Lightning is able to leverage Apex to quickly connect your app to your data in Salesforce. All you have to do is expose methods in an Apex **controller** class as Lightning actions by using the `@AuraEnabled` annotation. Let's define the `createLead` action that we'll use to actually create the Lead record within Salesforce.

Create a new Apex class called OneLeadController that just has the single `createLead()` method shown below.

```apex
public class OneLeadController {

    @AuraEnabled
    public static Id createLead(Lead theLead) {
        insert theLead;
        return theLead.Id;
    }
}
```

As you can see, all this action does is insert the Lead record into the database, and then return the Lead ID of the new record as confirmation that the DML operation succeeded. But before we can actually use this action we need to associate this new controller with the Lightning app, by specifying the `controller` attribute in our aura:application tag.

```aura
<aura:application controller="OneLeadController">
...
```

Let's take a second to talk about this _second_ controller that we've now added to the mix. Remember that we already have a Lightning controller, defined completely in JavaScript? Well, it's probably more helpful for you to think of the Lightning controller and the Apex controller as _one_ controller, created by merging the two together. While you don't need to worry about the black magic that makes this work, you _should_ remember that because the two controllers are merged together, **the action names share the same namespace**. If you define an action called `createTask` in your Lightning controller, and you define an action called `createTask` in your Apex controller, Salesforce will not scream at you, but your app _will not work_ as expected.

