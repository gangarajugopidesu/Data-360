public with sharing class OpportunityHandler {
    public static void doUpdate(List<Opportunity> newList, List<Opportunity> oldList) {
        Set<id> accountIds = new Set<Id>();
        if(newList!=null){
            for(Opportunity opp : newList){
                if(opp.accountId!=null){
                    accountIds.add(opp.accountId);
                }
            }
        }
        if(oldList!=null){
            for(Opportunity opp : oldList){
                if(opp.accountId!=null){
                    accountIds.add(opp.accountId);
                }
            }
        }

        Map<Id, Integer> openOppMap = new Map<Id, Integer>();
        Map<Id, Integer> closedoppMap = new Map<Id, Integer>();

        List<AggregateResult> result = [SELECT AccountId, StageName, count(Id) totalCount FROM Opportunity WHERE accountId IN : accountIds GROUP BY accountId, StageName];
        Integer currentCount=0 ;
        for(AggregateResult ar : result){
            Id accId = (Id) ar.get('AccountId');
            String oppStatus = (string) ar.get('StageName');
            Integer oppCount = (Integer) ar.get('totalCount');
            if(oppStatus!='Closed/Won' || oppStatus!='Closed/Lost'){
                currentCount =openOppMap.containsKey(accId)? openOppMap.get(accId) : 0;
                openOppMap.put(accId, oppCount+currentCount);
            }else if(oppStatus=='Closed/Won' || oppStatus=='Closed/Lost'){
                currentCount =closedoppMap.containsKey(accId)?closedoppMap.get(accId) : 0;
                closedoppMap.put(accId, oppCount+currentCount);
            }
            
        }
        List<Account> updatedList = new List<Account>();
        for(Id acc : accountIds){
            Account acRec = new Account(ID = acc, open_opp_count__c = openOppMap.get(acc), closed_opp_count__c = closedoppMap.get(acc));
            updatedList.add(acRec);
        }
        if(updatedList!=null){
            update updatedList;
        }
    }
}