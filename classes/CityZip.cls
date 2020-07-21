public class CityZip {
    @AuraEnabled @InvocableVariable public String countryabbreviation;
    @AuraEnabled @InvocableVariable public List<Place> places;
    @AuraEnabled @InvocableVariable public String country;
    @AuraEnabled @InvocableVariable public String placename;
    @AuraEnabled @InvocableVariable public String state;
    @AuraEnabled @InvocableVariable public String stateabbreviation;
    
    public CityZip() {} // Needed for unit test code coverage
}