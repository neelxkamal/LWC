import {LightningElement} from 'lwc';
import getLeadConvInfo from '@salesforce/apex/LeadConvController.getLeadConvInfo';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
const cols = [
		{ label: 'Owner', fieldName: 'ownerName', sortable: true },
		{ label: 'Total Lead', fieldName: 'totalLead', type:'number', sortable: true, cellAttributes: { alignment: 'left' } },
		{ label: 'Total Opps.', fieldName: 'totalOpp', type:'number',sortable: true, cellAttributes: { alignment: 'left' } },		
		{ label: 'Conv Rate', fieldName: 'convRate', type:'percent', sortable: true, cellAttributes: { alignment: 'left' } },
		{ label: 'Max Created Date(Opp)', fieldName: 'maxCreatedDateOpp', type:'date', sortable: true	},
		{ label: 'Total Vale(Opp)', fieldName: 'totalVal', type:'currency', sortable: true, cellAttributes: { alignment: 'left' }}
	];

export default class LwcLeadConversionInfo extends LightningElement {
	fromDate = this.getRelativeDate(-30);
	toDate = this.getRelativeDate(0);

	data;
	columns = cols;
	defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
	showSpinner = false;
	//@wire(getLeadConvInfo, {fromDate: this.fromDate}) 

	connectedCallback() {
		this.getTableData();
	}

	getTableData() {
		this.showSpinner = true;
		getLeadConvInfo({fromDate: this.fromDate, toDate : this.toDate}).then(res=>{
			
			let convData = [] ;
			
			res.forEach(d=>{
				let temp = {...d}; //for deep cloning because res is immutable object
				if(d.totalLead && d.totalOpp) {
					temp.convRate = d.totalOpp / d.totalLead;
				}
				convData.push(temp);
			});
			this.data = convData;
			this.showSpinner = false;
		}).catch(error => {
			console.log(error);
			this.showSpinner = false;
		});

		
	}
	//return relative date on bais of number of days add/subtract to today.
	getRelativeDate(days) {
		const today = new Date().getTime();
		const ms = today + (days * 24 * 60 * 60 * 1000);
		const isoString = new Date(ms).toISOString();
		return isoString.split('T')[0];        
    }


	handleClick(evt){
		this.validateFilter();
	}

	validateFilter() {
		let msg='';
		let isValid = true;
		
		 //this.showToast('Error', 'From Date cannot be blank' , 'Error');
		
		if(!this.fromDate && !this.toDate) {
			isValid = false;
			msg = 'Start Date and End Date cannot be  blank.';
		}
		else if(!this.fromDate ) {
			isValid = false;
			msg = 'Start Date cannot be  blank.';
		}
		else if(!this.toDate ) {
			isValid = false;
			msg = 'End Date cannot be  blank.';
		}
		else {
			const frDt = this.converDate(this.fromDate);
			const toDt = this.converDate(this.toDate);
			
			const diffTime = Math.abs(toDt - frDt);
			const diffDays = Math.ceil(diffTime/(1000 * 60 * 60 * 24));
			if(frDt > toDt) {
				isValid = false;
				msg = 'Start Date cannot be  greater tha End Date.';
			}
			else if(diffDays > 31) {
				isValid = false;
				msg = 'End Date must not be more than 31 days from Start Date.';
			}
			
		}


		if(!isValid) {
			this.showToast('Error', msg , 'Error');
		}
		else {
			this.getTableData();
		}
		
	}

	//Converting String date to Date object
	converDate(dt) {
		let arr = dt.split('-');
		return new Date(arr[0], arr[1]-1, arr[2]);
	}

	handleDate(evt) {
		let dtFld = evt.target.name;
		if(dtFld === 'fromDt') {
			this.fromDate = evt.target.value;
		}
		else{
			this.toDate = evt.target.value;
		}
		
	}

	sortBy(field, reverse, primer) {
        const key = primer
            ? function(x) {
                  return primer(x[field]);
              }
            : function(x) {
                  return x[field];
              };

        return function(a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

	onHandleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.data];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.data = cloneData;
        this.sortDirection = sortDirection;
        this.sortedBy = sortedBy;
    }

	showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
}