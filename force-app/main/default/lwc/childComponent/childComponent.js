import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api name;

    constructor() {
        super();
        console.log('Child Costructor');
    }
    connectedCallback() {
        console.log('child connected callback');
    }
    renderedCallback() {
        console.log('child rendered callback');
    }
    disconnectedCallback() {
        console.log('Disconnected callback - parent');
    }
}