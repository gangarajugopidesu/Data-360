public with sharing class AccountHandler {
    @AuraEnabled
    public static List<Account> getAccounts(){
        try {
            return [select id, name from Account LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAcc(){
        try {
            return [select id, name from Account LIMIT 10];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}