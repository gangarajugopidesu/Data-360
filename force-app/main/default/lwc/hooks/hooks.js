import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/AccountHandler.getAccounts';
import getAcc from '@salesforce/apex/AccountHandler.getAcc';

export default class Hooks extends LightningElement {


    connectedCallback() {
        console.log('inside connected callback - @gg');
        getAccounts().then(result => {
            console.log('connected callback executed-success', result);
        }).catch(error => {
            console.log('connected callback executed - error', error);
        })
    }

    @wire(getAcc) accounts({ data, error }) {
        console.log('inside wire adaptor @gg');
        if (data) {
            console.log('Wire method executed- success', data);
        } else if (error) {
            console.log('Wire mehod executed - error', error);
        }
    }
}