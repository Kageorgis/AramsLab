import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import NAME_FIELD from '@salesforce/schema/Order.Name';
import SHIP_FIELD from '@salesforce/schema/Order.ShippingAddress';
import BILL_FIELD from '@salesforce/schema/Order.BillingAddress';

export default class RecordFormCreateExample extends LightningElement {
    // objectApiName is "Account" when this component is placed on an account record page
    @api objectApiName;
    

    fields = [NAME_FIELD, SHIP_FIELD, BILL_FIELD];

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: "Account created",
            message: "Record ID: " + event.detail.id,
            variant: "success"
        });
        this.dispatchEvent(evt);
    }
}