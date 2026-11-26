trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate || Trigger.isDelete || Trigger.isUndelete){
            ContactHandler.doUpdate(Trigger.new,Trigger.old);
        }
    }
}