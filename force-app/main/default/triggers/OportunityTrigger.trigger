trigger OportunityTrigger on Opportunity (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            OpportunityHandler.doUpdate(Trigger.new, Trigger.old);
        }
    }
}