public class DebitCardPaymentSystem implements IPaymentSystem{
    
    public Boolean processPayment(){
        system.debug('Processing Debit card');
        return true;
    }

}