public with sharing class FirstClass {

    public static void doFetch() {

        Http htp = new Http();

        try {

            HttpRequest request = new HttpRequest();

            request.setEndpoint(
                'callout:External_System/services/data/v65.0/sobjects/Account/001g700000fdOkSAAU'
            );

            request.setMethod('GET');
            request.setHeader('Content-Type', 'application/json');

            HttpResponse response = htp.send(request);

            System.debug('Status Code: ' + response.getStatusCode());

            if (response.getStatusCode() == 200) {

                System.debug('Response Body: ' + response.getBody());

            } else {

                System.debug('Error Response: ' + response.getBody());
            }

        } catch (Exception e) {

            System.debug('Error: ' + e.getMessage());
        }
    }
}