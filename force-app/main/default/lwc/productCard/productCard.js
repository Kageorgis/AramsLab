import { LightningElement, wire } from 'lwc';

// Ligthning Message Service and a message channel
import { NavigationMixin } from 'lightning/navigation';
import { subscribe, MessageContext } from 'lightning/messageService';
import PRODUCT_SELECTED_MESSAGE from '@salesforce/messageChannel/ProductSelected__c';

// Utils to extract field values
import { getFieldValue } from 'lightning/uiRecordApi';

// Product  Schema
import PRODUCT_OBJECT from '@salesforce/schema/Product2';
import NAME_FIELD from '@salesforce/schema/Product2.Name';
import DESCRIPTION_FIELD from '@salesforce/schema/Product2.Description';
import START_INV_FIELD from '@salesforce/schema/Product2.Starting_Inventory__c';
import CURR_INV_FIELD from '@salesforce/schema/Product2.Current_Inventory__c';

/**
 * Component to display details of a Product__c.
 */
export default class ProductCard extends NavigationMixin(LightningElement) {
    // Exposing fields to make them available in the template
    prodName = NAME_FIELD;
    prodDesc = DESCRIPTION_FIELD;
    startInv = START_INV_FIELD;
    currInv = CURR_INV_FIELD;

    // Id of Product__c to display
    recordId;

    // Product fields displayed with specific format
    productName;
    productPictureUrl;

    /** Load context for Ligthning Messaging Service */
    @wire(MessageContext) messageContext;

    /** Subscription for ProductSelected Ligthning message */
    productSelectionSubscription;

    connectedCallback() {
        // Subscribe to ProductSelected message
        this.productSelectionSubscription = subscribe(
            this.messageContext,
            PRODUCT_SELECTED_MESSAGE,
            (message) => this.handleProductSelected(message.productId)
        );
    }

    handleRecordLoaded(event) {
        const { records } = event.detail;
        const recordData = records[this.recordId];
        this.productName = getFieldValue(recordData, NAME_FIELD);
        this.productPictureUrl = getFieldValue(recordData, BIKE_ASSETS_URL);
    }

    /**
     * Handler for when a product is selected. When `this.recordId` changes, the
     * lightning-record-view-form component will detect the change and provision new data.
     */
    handleProductSelected(productId) {
        this.recordId = productId;
    }

    handleNavigateToRecord() {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: this.recordId,
                objectApiName: PRODUCT_OBJECT.objectApiName,
                actionName: 'view'
            }
        });
    }
}