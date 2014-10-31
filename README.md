oneLead.app
===========

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