import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    isVisible = true;

    constructor() {
        super();
        console.log('Parent Constructor');
    }

    connectedCallback() {
        console.log('Parent Connected callback');
    }

    renderedCallback() {
        console.log('Parent Rendered callback');

        const childComp = this.template.querySelector('c-child-component');

        if (childComp) {
            childComp.name = 'Passing input from Parent';
            console.log('Calling child component from parent');
        }
    }
    errorCallback() {
        console.log('Error callback from parent component - child');
    }


    displayClick() {
        this.isVisible = !this.isVisible;
    }


}