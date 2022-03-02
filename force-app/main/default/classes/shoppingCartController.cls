public with sharing class shoppingCartController {
    
        // Had to remove (cacheable = true) OR ran into too many DML statements
        @AuraEnabled
        public static void createPBentry(List <ID> prodIDs){

            List <PricebookEntry> newPBEs = new List <PricebookEntry>();
            List <Product2> updProds = new List <Product2>();
            ID pbId = [SELECT id FROM Pricebook2 WHERE CreatedDate = TODAY ORDER BY createdDate DESC][0].id;

            // Create Pricebook Entries for each product passed from JS Array
            for (Integer i=0; i < prodIds.size(); i++) {
                try{
                    newPBEs.add(new PricebookEntry (Product2id = prodIDs[i],
                                                    IsActive=true, 
                                                    Pricebook2Id=pbId, 
                                                    UseStandardPrice=false,
                                                    UnitPrice = 0.70
                    ));
                }catch(ListException le){
                    System.debug('The following exception has occurred: ' + le.getMessage());
                }
            }

            // Decrement Current Inventory for Selected Products included in Order
            for(Product2 p : [SELECT Id, Current_Inventory__c FROM Product2 WHERE Id IN : prodIDs]){
                p.Current_Inventory__c = (p.Current_Inventory__c - 1);
                updProds.add(p);
            }

            // Update current inventory on Products and Insert new Pricebook Entries
            try{
                update updProds;
                insert newPBEs;
            }catch(DmlException e){
                System.debug('The following exception has occurred: ' + e.getMessage());
            }

        }

        // Fetch most recent products from DB
        @AuraEnabled(cacheable=true)
        public static List<Product2> getCurrProducts() {
            return [
                SELECT Id, Name, CreatedDate, Price__c, Current_Inventory__c, Starting_Inventory__c, PhotoUrl__c
                FROM Product2
                WITH SECURITY_ENFORCED
                ORDER BY CreatedDate DESC
                LIMIT 10
            ];
        }
}