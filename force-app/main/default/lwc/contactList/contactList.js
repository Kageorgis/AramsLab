import { LightningElement, api, wire } from 'lwc';
import { reduceErrors } from 'c/ldsUtils';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import getContacts from '@salesforce/apex/ContactController.getContacts';

const columns = [
    { label: 'First Name', fieldName: FIRSTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Last Name', fieldName: LASTNAME_FIELD.fieldApiName, type: 'text' },
    { label: 'Email', fieldName: EMAIL_FIELD.fieldApiName, type: 'text' },
];

export default class BasicDatatable extends LightningElement {
    data = [];
    columns = columns;

    @wire(getContacts)
    contacts;

    get errors() {
        return (this.contacts.error) ?
            reduceErrors(this.contacts.error) : [];
    }

    // eslint-disable-next-line @lwc/lwc/no-async-await
    // async connectedCallback() {
    //     const data = await fetchDataHelper({ amountOfRecords: 100 });
    //     this.data = data;
    // }
}