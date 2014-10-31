({
    save : function(component, event, helper) {
        
        // Get the RawMapValue object that will
        // be passed to the Apex controller action
        // as a Lead object
        var theLead = component.get("v.lead");
        
        // Get the Action object that represents
        // the equivalent Apex controller action
        // (i.e., @AuraEnabled static method)
        var action = component.get("c.createLead");
        
        // Specify the required parameters, as defined
        // in the Apex method's signature
        action.setParams({
            "theLead": theLead
        });
        
        // Since the Apex method returns an ID value,
        // simply display the returned value in an alert
        // to confirm that the controller action
        // executed successfully
        action.setCallback(component, function(a) {
            alert(a.getReturnValue());
        });
        
        // Queue up the action to be executed asynchronously
        $A.enqueueAction(action);
    }
})