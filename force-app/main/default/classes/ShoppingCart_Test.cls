@isTest
private class ShoppingCart_Test {
    
    static testMethod void getCompanyNameTest() {
       
       IPaymentSystem debit = new DebitCardPaymentSystem();
        
       ShoppingCart cart = new ShoppingCart(debit);
        
       cart.getCompanyName();
        
       system.assertEquals('DrumLine', cart.getCompanyName(), 'they are not equal');
        
    }
    
    static testMethod void noArgConstructorTest(){
       ShoppingCart cart = new ShoppingCart();
    	system.assertEquals(Null, cart.getName());
    }
    
    /* TESTING IS DONE DIRECTLY ON THE IMPLEMENTATION
    @isTest static void processPaymentTest(){
       IPaymentSystem debit = new DebitCardPaymentSystem();
        
       ShoppingCart cart = new ShoppingCart(debit);
        
       Boolean result = cart.processPayment();
        
       system.assertEquals(true, result, 'NO');
        
    }
*/
    
    
}