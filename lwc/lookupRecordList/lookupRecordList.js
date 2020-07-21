import { LightningElement, api } from 'lwc';

export default class LookupRecordList extends LightningElement {
    @api record;
    @api fieldname;
    @api iconname;

	connectedCallback() {
		console.log('lookupRecordList===='+this.record);
	}
    handleSelect(event){
        event.preventDefault();
        const selectedRecord = new CustomEvent(
            "select",
            {
                detail : this.record.Id
            }
        );
        /* eslint-disable no-console */
        //console.log( this.record.Id);
        /* fire the event to be handled on the Parent Component */
        this.dispatchEvent(selectedRecord);
    }
}