import { LightningElement, api } from 'lwc';

// const columns = [
//     { label: 'Name', fieldName: 'Name' },
//     { label: 'Website', fieldName: 'website', type: 'url' },
//     { label: 'Phone', fieldName: 'phone', type: 'phone' },
//     { label: 'Balance', fieldName: 'amount', type: 'currency' },
//     { label: 'Price', fieldName: 'closeAt', type: 'date' },
// ];

export default class BasicDatatable extends LightningElement {
    data = [];
    columns = columns;

    // Ensure changes are reactive when product is updated
        product;

    // Private var to track @api productId
     _productId = undefined;

    set productId(value) {
        this._productId = value;
        this.product = bikes.find(bike => bike.fields.Id.value === value);
    }
    
    // getter for productId
    @api get productId(){
        return this._productId;
    }

}