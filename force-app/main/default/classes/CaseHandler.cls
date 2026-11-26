public with sharing class CaseHandler {
    public static void doUpdate(List<Case> newList, List<Case> oldList) {
        Set<Id> CaseAccountIds = new Set<Id>();
        

        if(newList!=null){
            for(Case cs : newList){
                if(cs.accountId!=null){
                    CaseAccountIds.add(cs.accountId);
                }
               
            }
        }

         if(oldList!=null){
            for(Case cs : oldList){
                if(cs.accountId!=null){
                    CaseAccountIds.add(cs.accountId);
                }
            }
        }
       Map<Id, Integer> openCase = new Map<Id, Integer>();
       Map<Id, Integer> closedCases = new Map<Id, Integer>();
        List<Account> accList = new List<Account>();
       List<AggregateResult> ar = [SELECT accountId, status, count(id) totalCount FROM CASE WHERE accountId IN : CaseAccountIds Group by accountId, status];
       for(AggregateResult a : ar){
        Id accId = (Id) a.get('accountId');
        Integer cCount = (Integer) a.get('totalCount');
        String cStatus = (String) a.get('status');
        if(cStatus!='Closed'){
            Integer existinCount = openCase.containsKey(accId)?openCase.get(accId) : 0;
            openCase.put(accId, cCount+existinCount);
        }else if(cStatus=='Closed'){
            Integer existinCount = closedCases.containsKey(accId)?closedCases.get(accId) : 0;
            closedCases.put(accId, cCount+existinCount);
        }
       }
       for(Id acc : CaseAccountIds){
            Integer openCount = openCase.get(acc);
            Integer closedCount = closedCases.get(acc);
            Account accR = new Account(ID=acc, open_case_count__c = openCount, closed_case_count__c = closedCount);
            accList.add(accR);

       }
       if(accList!=null){
        update accList;
       }
    }
}