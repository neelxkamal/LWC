with sharing public class  LocaleDateCheck implements Schedulable{
    
    public void execute(SchedulableContext sc){
    	dateLocaleCalculator();
    }
    
    public static void dateLocaleCalculator(){
        LocaleDate__c ld = LocaleDate__c.getValues('FirstDayOfWeek');
        Date startWeek = System.Date.today().toStartOfWeek(); 
        ld.date__c= String.valueOf(startWeek);
        
        update ld;
    }
}