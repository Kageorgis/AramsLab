import { LightningElement, api, track, wire } from 'lwc';
import getAuditLog from '@salesforce/apex/dataFetcher.getAuditLog';
//import CREATEDBY_NAME from '@salesforce/schema/SetupAuditTrail.CreatedBy.Name';

const columns = [
    { label: 'Modified By', fieldName: 'CreatedBy.Name', type: 'text', initialWidth: 225, sortable: true },
    { label: 'Action', fieldName: 'Action', initialWidth: 225, sortable: true },
    { label: 'Date', fieldName: 'CreatedDate', type: 'date', initialWidth: 105, sortable: true },
    { label: 'Section', fieldName: 'Section', initialWidth: 215, sortable: true },
    { label: 'Display', fieldName: 'Display', sortable: true }
];

export default class auditLogAnalytics extends LightningElement {
    @api recordId;
    @track data;
    columns = columns;
    error;

    @wire(getAuditLog)
    Agencies({error,data}){
        if (data){

            this.data = data.map(
                data => Object.assign(
                  { "CreatedBy.Name": data.CreatedBy.Name }, data
                )
            );

            //this.data = data;
            console.log('DATA -- ', JSON.stringify(this.data));
        } else if (error) {
            this.error = error;
        }
    };

}