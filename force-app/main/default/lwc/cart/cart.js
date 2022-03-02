import { LightningElement, api, track, wire} from 'lwc';
import getCurrProducts from '@salesforce/apex/shoppingCartController.getCurrProducts';
import createPBentry from '@salesforce/apex/shoppingCartController.createPBentry';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

// Import Order fields from Salesforce Schema
import EMAIL_FIELD from '@salesforce/schema/Order.Email__c';
import SHIP_FIELD from '@salesforce/schema/Order.ShippingAddress';
import BILL_FIELD from '@salesforce/schema/Order.BillingAddress';
import ACCTNAME_FIELD from '@salesforce/schema/Order.AccountId';
import EFFDATE_FIELD from '@salesforce/schema/Order.EffectiveDate';
import STATUS_FIELD from '@salesforce/schema/Order.Status';
import CVV_FIELD from '@salesforce/schema/Order.CVV__c';
import CCNUMB_FIELD from '@salesforce/schema/Order.Credit_Card_Number__c';
import EXPDATE_FIELD from '@salesforce/schema/Order.Exp_Date__c';
import CUSTNM_FIELD from '@salesforce/schema/Order.Cust_Name__c';

const shipping = 14.99;
const taxRt = 0.0725;


export default class Detail extends LightningElement {

    //START CREATE ORDER RECORD

    @api objectApiName;
    
    // Fields to display in Form
    fields = [CUSTNM_FIELD, EMAIL_FIELD, SHIP_FIELD, BILL_FIELD,CCNUMB_FIELD, CVV_FIELD,EXPDATE_FIELD,ACCTNAME_FIELD,EFFDATE_FIELD,STATUS_FIELD];

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Order created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
    // END CREATE RECORD

    // Ensure changes are reactive when product is updated
    product;

    // Private var to track @api productId
    _productId = undefined;

    @api prod;
    @track cartList = [];
    @api prodIds = [];
    @api priceList = [];
    
    viewCart;
    net;
    total;
    shipping = shipping;
    taxRt = taxRt;
    tax;
    taxDis;
    @track isModalOpen = false;

    // Fetch current products via getCurrProducts method on ShoppingCartController Class
    @wire(getCurrProducts)wiredData
    ({error,data}) {
        if (data) {
            console.log(JSON.stringify(data));
            this.prod = data;
        } else if (error) {
            this.error = error;
        }
    }

    connectedCallback(){
        this.viewCart = false;
        console.log('INIT', this.viewCart);
    }


    // Use set and get to process the value every time it's
    // requested while switching between products
    set productId(value) {

        this._productId = value;

        // // Add product to list
        if(this._productId != null){ 

            this.product = this.prod.find(p => p.Id === value);

            this.cartList.push(this.product);
            this.prodIds.push(value);
            this.priceList.push(this.product.Price__c)
            console.log(this.cartList);
        }
    }
    
    // getter for productId
    @api get productId(){
        return this._productId;
    }

    handleViewCart(){
        this.viewCart = true;

        // Calculate sum of Price
        this.net = this.priceList.reduce(function(a, b){
            return a + b;
        }, 0);

        this.tax = this.net * this.taxRt;
        this.taxDis = this.tax.toFixed(2);

        // Calculate total price Of Order
        this.total = this.shipping + this.net + this.tax;
        this.total = this.total.toFixed(2);
    }

    handleCheckout() {
        this.isModalOpen = true;

        // Call Serverside APEX Imperatively (Out of Necessity)
        createPBentry({ prodIDs: this.prodIds })
            .then(result => {
                console.log(this.result);  // Success Callback
            })
            .catch(error => {
                this.error = error;
                console.log(this.error); // Failure Callback
            });
    }

    closeCart() {
        this.viewCart = false;
    }

    closeModal() {
        this.isModalOpen = false;
    }


}