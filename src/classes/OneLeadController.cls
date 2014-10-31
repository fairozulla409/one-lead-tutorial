public class OneLeadController {
    
    @AuraEnabled
    public static Id createLead(Lead theLead) {
        insert theLead;
        return theLead.Id;
    }
}