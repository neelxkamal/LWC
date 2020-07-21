/*
* @author : Neel Kamal
* @Date : 06/14/20
* @Description : This class will handle the functionality related to Lead conversion.
*/
public without sharing class LeadConvController  {
	//Method getLeadConvInfo return data from Lead by grouping on owner Name.
	@AuraEnabled(cacheable=true)
	public static List<AggregateResult> getLeadConvInfo(Date fromDate, Date toDate) {
		//Add 1 day added because date form will be YYY-MM-DDT00:00:00. Means if User want to see data between 01/06 to 14/06
		// the date will be like 2020-06-01T00:00:00 and 2020-06-14T00:00:00. So data will not be fetheched for today except midnight. 
		//toDate should be 2020-06-14T23:59:59.   
		toDate = toDate.addDays(1);
		System.debug(fromDate);
		System.debug(toDate);
		List<AggregateResult> leadList = [select Owner.name ownerName, count(ID) totalLead, count(ConvertedOpportunityId) totalOpp, max(ConvertedOpportunity.CreatedDate) maxCreatedDateOpp, SUM(ConvertedOpportunity.Amount) totalVal  from lead 
		where CreatedDate >=: fromDate and CreatedDate <=: toDate group by  Owner.name];

		return leadList;
	}

	
}