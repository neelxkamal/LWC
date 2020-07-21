public class IndianCity {
    @AuraEnabled @InvocableVariable public String city;
    @AuraEnabled @InvocableVariable public String state;
    @AuraEnabled @InvocableVariable public String district;
    
    public IndianCity() {} // Needed for unit test code coverage
}