<aura:application controller="ccmt.OneLeadController">
    <aura:attribute name="lead" type="Lead"
                    default="{
                              'sobjectType': 'Lead',
                              'FirstName': 'Charles',
                              'LastName': 'Xavier',
                              'Company': 'Marvel Universe',
                              'Email': 'charles.xavier@marvel.default',
                              'Phone': '+1 (800) I-AM-X-MEN'
                             }"/>
    
  <h1>Lightning-to-Lead</h1>
    
    <ui:inputText aura:id="firstName"
                  label="First Name" value="{!v.lead.FirstName}"
                  required="false"/>
    <ui:inputText aura:id="lastName"
                  label="Last Name" value="{!v.lead.LastName}"
                  required="true"/>
    <ui:inputText aura:id="company"
                  label="Company Name" value="{!v.lead.Company}"
                  required="true"/>
    <ui:inputEmail aura:id="email"
                   label="Work Email" value="{!v.lead.Email}"
                   required="true"/>
    <ui:inputPhone aura:id="phone"
                   label="Phone" value="{!v.lead.Phone}"
                   required="false"/>
    
    <ui:button label="Submit" press="{!c.save}"/>
</aura:application>