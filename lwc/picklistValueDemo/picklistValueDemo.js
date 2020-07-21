import { LightningElement, track, wire} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import Type_FIELD from '@salesforce/schema/Account.Type';

export default class PicklistValuesDemo extends LightningElement {
    @track value;
	@track cvalue;
	@track customPicklist;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: Type_FIELD})
    TypePicklistValues;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD})
    IndustryPicklistValues;

	 constructor() {
        super();
		this.customPicklist = [{"label":"Green","value":"Green"},{"label":"Yellow","value":"Yellow"},{"label":"Red","value":"Red"}];
		//let picklistData = {'values':[{'value':'green','value':'Red', 'value':'Yellow'}]};
		//this.customPicklist = picklistData;
		console.log(JSON.stringify(this.customPicklist));
		console.log(JSON.stringify(this.IndustryPicklistValues));
	}
	 connectedCallback() {
		
	 }

    handleChange(event) {
        this.value = event.detail.value;
		let custEvent = new CustomEvent('popoverdisplay', {detail : {'selectedValue':this.value}});
		this.dispatchEvent(custEvent);
		console.log(JSON.stringify(this.IndustryPicklistValues));
    }


}