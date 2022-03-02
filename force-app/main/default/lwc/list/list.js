import { LightningElement, wire, track, api } from 'lwc';
import getCurrProducts from '@salesforce/apex/shoppingCartController.getCurrProducts';


export default class List extends LightningElement {

    @api prod;

    @wire(getCurrProducts)wiredData
    ({error,data}) {

        if (data) {
            console.log(data);
            this.prod = data;
        } else if (error) {
            this.error = error;
        }
    }

    // Passes the this.product.Id event it caught from clicking Add to cart
    handleTileClick(evt) {
        // This component emits the selected product to its parent via productselected event
        const event = new CustomEvent('productselected', {
            detail: evt.detail
        });
        // Fire the event from c-list
        this.dispatchEvent(event);
    }
}