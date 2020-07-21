import {LightningElement, api, track, wire} from 'lwc';
import saveForm from '@salesforce/apex/createFormMultipleObject.save';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';


export default class CreateMultipleObjectForm extends LightningElement {
	firstName = 'fdfdf';
	lastName = 'hjgjjh';
   // @api firstName;
	//@api lastName;
	@track formData={
		firstName : this.firstName,
		lastName : this.lastName
	};
	 @track value;

	@wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    objectInfo;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: TYPE_FIELD})
    TypePicklistValues;

    @wire(getPicklistValues, { recordTypeId: '$objectInfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD})
    IndustryPicklistValues;

    handleChange(event) {
        this.value = event.detail.value;
    }

	get recordTypeId1() {
		   console.log(' this.picklistValues----' + JSON.stringify( this.picklistValues));
		  var recordtypeinfo = this.contactInfo.data.recordTypeInfos;
		  var uiCombobox = [];
		  console.log("recordtype" + recordtypeinfo);
		  for(var eachRecordtype in  recordtypeinfo)//this is to match structure of lightning combo box
		  {
			if(recordtypeinfo.hasOwnProperty(eachRecordtype))
			uiCombobox.push({ label: recordtypeinfo[eachRecordtype].name, value: recordtypeinfo[eachRecordtype].name })
		  }
		  console.log('uiCombobox' + JSON.stringify(uiCombobox));
		return uiCombobox;
	}


	handleFirstName(event) {
		//alert(event.target.value);
		this.formData.firstName =  event.target.value;
		console.log(this.formData.firstName);
	}
	handleLastName(event) {
		this.formData.lastName = event.target.value;
		console.log(this.formData.lastName);
	}
	saveFormData(event) {
		//alert('1');
		console.log('this.formData----'+JSON.stringify(this.formData));
		saveForm({moWrapper:this.formData}).then(res =>{ 
			console.log(res);
		}).catch(err => console.log(err));
	}
	
}