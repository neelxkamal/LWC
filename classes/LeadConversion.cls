public with sharing class LeadConversion  {
	@AuraEnabled(cacheable=true)
	public static List<AggregateResult> getLeadConversionInfo(Date fromDate, Date toDate) {
		System.debug(fromDate);
		System.debug(toDate);
		List<AggregateResult> leadList = [select Owner.name ownerName, count(ID) totalLead, count(ConvertedOpportunityId) totalOpp, max(ConvertedOpportunity.CreatedDate) maxCreatedDateOpp, SUM(ConvertedOpportunity.Amount) totalVal  from lead 
		where CreatedDate >=: fromDate and CreatedDate <=: toDate group by  Owner.name];

		return leadList;
	}

	
}