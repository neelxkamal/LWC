public without sharing class LeadTriggerHandler  {
      public void OnBeforeInsert(List<Lead> leads) {
            
      }

      public void OnAfterInsert(List<Lead> leads) {
            converLeads(leads);
      }

      public void OnAfterUpdate(Map<Id, Lead>oldMap, Map<Id, Lead>newMap) {
            updateConvertedOpportunity(newMap.values());
      }

      private void converLeads(List<Lead> leads){
        System.debug('**************convert Lead**********');
        LeadStatus CLeadStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true Limit 1];
        List<Database.LeadConvert> MassLeadconvert = new List<Database.LeadConvert> ();
        for (lead currlead : leads) {
            if(!currlead.IsConverted && currlead.Rating.equals('Hot')){
                Database.LeadConvert Leadconvert = new Database.LeadConvert();
                Leadconvert.setLeadId(currlead.id);
                Leadconvert.setConvertedStatus(CLeadStatus.MasterLabel);
                //Leadconvert.setDoNotCreateOpportunity(TRUE); //Remove this line if you want to create an opportunity from Lead Conversion 
                MassLeadconvert.add(Leadconvert);
            }
        }

        if (!MassLeadconvert.isEmpty()) {
            List<Database.LeadConvertResult> lcr = Database.convertLead(MassLeadconvert);
        }
      }

      private void updateConvertedOpportunity(List<Lead> leads) {
            List<ID> oppIdList = new List<ID>();
            for(Lead ld : leads) {
                if(ld.IsConverted) {
                    oppIdList.add(ld.ConvertedOpportunityId);
                }
            }
            List<Opportunity> oppList = new List<Opportunity>();
            if(oppIdList.size() > 0) {
                Integer i=1;
                for(Opportunity opp : [Select Id, Amount from Opportunity where ID IN :  oppIdList]) {
                    opp.Amount = 60000 * i;

                    oppList.add(opp);
                    i++  ;
                }

                update oppList;
            }
            
            
      }
}