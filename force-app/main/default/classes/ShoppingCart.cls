public class ShoppingCart {

    private static String companyName = 'DrumLine';
    private String Name;
    IPaymentSystem paymentSystem;
    private List <Product2> products;
    
    
    public ShoppingCart() {
        Name = null;
    }
    
    public ShoppingCart(IPaymentSystem iPaymentSystem) {
        this.paymentSystem = iPaymentSystem;
    }
    
    public ShoppingCart(List <Product2> iProducts, IPaymentSystem iPaymentSystem){
        products = iProducts;
        this.paymentSystem = iPaymentSystem;
    }
    
    
    
    public void processPayment(){
        this.paymentSystem.processPayment();
    }
    
    
    // method interface // public interface
    // 
    
    public String getCompanyName(){
        return companyName;
    }
    
    public String getName(){
        return Name;
    }

    public void setProducts(List <Product2> iProducts){
       products = iProducts;
    }
    
    
    

}