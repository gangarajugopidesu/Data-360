public class ContactHandler {
    public static void doUpdate(List<Contact> newList, List<Contact> oldList) {
        //System.debug('Handler');
        Set<Id> accountIds = new Set<Id>();
        if(newList!=null){
            for(Contact con : newList){
                if(con.accountId!=null){
                    accountIds.add(con.accountId);
                }
            }
        }
        if(oldList!=null){
            for(Contact con : oldList){
                if(con.accountId!=null){
                    accountIds.add(con.accountId);
                }
            }
        }

        List<Account> accRecords = [SELECT ID, Total_Contacts__c, (SELECT ID FROM CONTACTS) FROM ACCOUNT WHERE ID IN : accountIds];
        if(!accRecords.isEmpty()){
             for(Account acc : accRecords){
            acc.Total_Contacts__c = acc.contacts.size();
        }
        }
       
        update accRecords;
    }
}