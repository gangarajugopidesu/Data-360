public with sharing class OrgIntegrationService {

    public static void createAccountInExternalOrg() {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        // Named Credential endpoint
        request.setEndpoint(
            'callout:Orgfarm_Named_Credential/services/data/v65.0/sobjects/Account/'
        );

        request.setMethod('POST');

        request.setHeader(
            'Content-Type',
            'application/json'
        );

        // Account data
        Map<String, Object> accountData = new Map<String, Object>();

        accountData.put('Name', 'Account From Source Org');
        accountData.put('Phone', '9876543210');
        accountData.put('Industry', 'Technology');

        request.setBody(JSON.serialize(accountData));

        try {

            HttpResponse response = http.send(request);

            System.debug('Status Code: ' + response.getStatusCode());
            System.debug('Response Body: ' + response.getBody());

            if (response.getStatusCode() == 201) {

                Map<String, Object> result =
                    (Map<String, Object>) JSON.deserializeUntyped(
                        response.getBody()
                    );

                System.debug('Account Created Successfully!');
                System.debug('External Account ID: ' + result.get('id'));

            } else {

                System.debug('Account Creation Failed!');
                System.debug('Error: ' + response.getBody());

            }

        } catch (Exception e) {

            System.debug('Exception: ' + e.getMessage());

        }
    }
    
    public static void doFetch(){
        Http htp = new Http();
        try{
            HttpRequest req = new HttpRequest();
            req.setEndpoint('callout:Orgfarm_JWT_Named_Credential/services/data/v65.0/sobjects/Account/001g700001MYhHiAAL');
            req.setMethod('GET');
            req.setHeader('content-type','aplication/json');
            
            HttpResponse res = new HttpResponse();
            res = htp.send(req);
            System.debug('Status Code : '+res.getStatusCode());
            //System.debug('Body : '+res.getBody());
            Account acc = (Account) JSON.deserialize(res.getBody(), Account.class);
            System.debug(acc);
            
        }catch(Exception e){
            System.debug('Error : '+e.getMessage());
        }
    }
}