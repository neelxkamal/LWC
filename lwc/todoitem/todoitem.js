import { LightningElement, api } from 'lwc';
export default class Todoitem extends LightningElement {
    @api itemName;

    // This code won’t update itemName because:
    // 1) You can update public properties only at component construction time.
    // 2) Property values passed from owner components are read-only.
    updateItemName() {
        this.itemName = "updated item name in todoitem";
    }
}