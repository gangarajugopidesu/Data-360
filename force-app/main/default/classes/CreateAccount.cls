public class CreateAccount {
    public static void doPost(){
        Http htp = new Http();
        try{
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:Target_Org_Integration/services/data/v65.0/sobjects/Account');
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody(CreateAccount.doPrepare());
            
            HttpResponse res = new HttpResponse();
            res = htp.send(req);
            System.debug('response : '+res.getStatusCode());
            if(res.getStatusCode()==201){
                Map<String, Object> mp = (Map<String,Object>) JSON.deserializeUnTyped(res.getBody());
                System.debug('response body : '+mp);
            }
        }catch(Exception e){
            System.debug('Error in posting the account : '+e.getMessage());
        }
    }
    
    public static String doPrepare(){
        Map<String, Object> accountData = new Map<String,Object>();
            accountData.put('Name','Global Technologies');
            accountData.put('Phone','9876543210');
            accountData.put('Industry','Technology');
            accountData.put('Website','www.globaltech.com');
            accountData.put('Type','Customer');
            String jsonData = JSON.serialize(accountData);
        return jsonData;
    }

}