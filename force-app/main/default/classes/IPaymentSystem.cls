public interface IPaymentSystem {
    
    // Every class that implements IPaymentSystem must have a concrete processPayment Method
    Boolean processPayment();
}