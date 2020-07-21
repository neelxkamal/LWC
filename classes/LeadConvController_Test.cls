@isTest
public class LeadConvController_Test  {
	@TestSetup
	public static void leadConvDataSetup() {
		List<Lead> ldList = new List<Lead>();
		Lead ld;
		for(Integer i=0; i<5; i++) {
			ld = new Lead();
			ld.FirstName = 'Rita' + i;
			ld.LastName = 'Marron' + i;
			ld.Company = 'Blue Lotus' +1 ;
			ld.Status = 'Working - Contacted' +i;
			ld.rating = 'Hot';
			ld.IsConverted = false;

			ldList.add(ld);
		}

		insert ldList;
		LeadStatus CLeadStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true Limit 1];
		List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert>();
		for(Lead currLead : ldList) {
			Database.LeadConvert Leadconvert = new Database.LeadConvert();
			Leadconvert.setLeadId(currLead.id);
			Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
			MassLeadconvert.add(Leadconvert);	
		}
		
		if (!MassLeadconvert.isEmpty()) {
			List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
			for(Database.LeadConvertResult res:  lcr) {
				System.debug('-----------------');
				System.debug(res.getOpportunityId());
			}
		}
	}


	@isTest
	public static void getLeadConvInfoTest() {
		Test.startTest();
			Date fromDt = System.today().addDays(-2);
			Date toDt = System.today().addDays(2);
			List<AggregateResult> leadList = [select Owner.name ownerName, count(ID) totalLead, count(ConvertedOpportunityId) totalOpp, max(ConvertedOpportunity.CreatedDate) maxCreatedDateOpp, SUM(ConvertedOpportunity.Amount) totalVal  from lead group by  Owner.name ];
			
			List<AggregateResult> ctrlLeadList = LeadConvController.getLeadConvInfo(fromDt, toDt);
			for(AggregateResult ar : leadList) {
				for(AggregateResult arCtrl : ctrlLeadList) {
					if(ar.get('ownerName').equals(arCtrl.get('ownerName'))) {
						System.assertEquals(ar.get('totalLead'), arCtrl.get('totalLead'));
						System.assertEquals(ar.get('totalOpp'), arCtrl.get('totalOpp'));
					}
				} 
				
			}
		Test.stopTest();
	}
}