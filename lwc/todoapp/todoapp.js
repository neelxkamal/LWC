import { LightningElement, track } from 'lwc';

export default class Todoapp extends LightningElement {
    @track itemName = "Milk";

    updateItemName() {
        this.itemName = "updated item name in todoapp";
    }
}