public class Place {
    @AuraEnabled @InvocableVariable public String placename;
    @AuraEnabled @InvocableVariable public String longitude;
    @AuraEnabled @InvocableVariable public String postcode;
    @AuraEnabled @InvocableVariable public String latitude;
    
    public Place() {} // Needed for unit test code coverage
}