public class OrderTriggerHandler {
    public static void setDefaultValues(List<Order> newOrders){
        list <Order> newOrderList = new List <Order>();
        ID pbId = [SELECT id FROM Pricebook2 WHERE CreatedDate = TODAY ORDER BY createdDate DESC][0].id;
        for(Order o : newOrders){
            o.Pricebook2Id = pbId;
        }
    }
    public static String getUserInfo() {
       String currUserId;
       currUserId = userinfo.getUserId();
       return currUserId;
    }
    public static void createOrderItems(List<Order> newOrders){
         List <OrderItem> newOrderItems = new List <OrderItem>();
        
         	List<ID> entryList = new List <ID>();
         	Datetime tenMinutesBack = Datetime.now().addMinutes(-10);
        
        	// Get the Latest Pricebook entries associated with User
            for(PricebookEntry pb : [SELECT ID, Product2Id, CreatedDate FROM PricebookEntry WHERE CreatedById = :getUserInfo() AND LastModifiedDate >= :tenMinutesBack]){
                entryList.add(pb.id);
            }
            // Loop through Trigger.new (newOrders)
            for(Order currentOrder : newOrders){
                try{
                    for(Integer i=0; i < entryList.size(); i++){
                        // Add related Order Items
                       newOrderItems.add(new OrderItem(OrderId = currentOrder.id,
                                                       PricebookEntryId = entryList[i],
                                                       Quantity = 1,
                                                       UnitPrice = 0.00));
                    }
                }catch(ListException le){
                    System.debug('The following exception has occurred: ' + le.getMessage());
                }
            }
         
         try{
             insert newOrderItems;
         }catch(DmlException e){
         	System.debug('The following exception has occurred: ' + e.getMessage());
         }
     }
}