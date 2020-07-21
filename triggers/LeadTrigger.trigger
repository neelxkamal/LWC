trigger LeadTrigger on Lead (before insert, before update, before delete, after insert, after update, after delete, after undelete)  {
    LeadTriggerHandler handler = new LeadTriggerHandler();

    if(Trigger.isBefore && Trigger.isInsert) {
        handler.OnBeforeInsert(Trigger.new);
    }
    else if(Trigger.isAfter && Trigger.isAfter) {
        handler.OnAfterInsert(Trigger.new);
    }
    if(Trigger.isAfter && Trigger.isUpdate) {
        handler.OnAfterUpdate(Trigger.oldMap, Trigger.newMap);
    }
    

}