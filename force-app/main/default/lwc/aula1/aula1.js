import { LightningElement, api, track, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const ACCOUNT_FIELDS = [
    'Account.BillingPostalCode',
    'Account.BillingStreet',
    'Account.BillingCountry',
    'Account.BillingCity',
    'Account.BillingState',
    'Account.BillingNumber__c'
]

export default class Aula1 extends LightningElement {

    @api recordId;

    @track objTempAccount = {
        cep: '',
        logradouro: '',
        bairro: '',
        cidade: '',
        estado: '',
        numero: ''
    }

    @track disabledField = true;

    @wire(getRecord, { recordId: "$recordId", fields: ACCOUNT_FIELDS})
    accountDetails({error, data}) {
        if( data ) {
            this.objTempAccount.cep = data.fields.BillingStreet.value;
            this.objTempAccount.logradouro = data.fields.BillingStreet.value;
            this.objTempAccount.bairro = data.fields.BillingCountry.value;
            this.objTempAccount.cidade = data.fields.BillingCity.value;
            this.objTempAccount.estado = data.fields.BillingState.value;
            this.objTempAccount.numero = data.fields.BillingNumber__c.value;
        } else {
            console.debug(error);
        }
    }

    handleManualEdition(event) {
        this.disabledField = !event.target.checked;
    }

    
    handleClickSave(){

        let cepValido = this.verificarCep();

        if(!cepValido) {
            this.showErrorCep();
        } else {
            if(this.objTempAccount.cep === '' || this.objTempAccount.numero === '') {
                this.showError();
            } else {
                this.showToast();
            }
        }
    }

    showToast() {
        const event = new ShowToastEvent({
            title: 'Boa',
            message: 'É us guri.',
            variant: 'success'
        });
        this.dispatchEvent(event);
    }

    showError() {
        const event = new ShowToastEvent({
            title: 'Erro',
            message: 'Não é us guri.',
            variant: 'error'
        });
        this.dispatchEvent(event);
    }

    showErrorCep() {
        const event = new ShowToastEvent({
            title: 'Erro',
            message: 'Cep invalido.',
            variant: 'error'
        });
        this.dispatchEvent(event);
    }

    limparLabel() {
        this.objTempAccount.cep = '';
        this.objTempAccount.logradouro = '';
        this.objTempAccount.bairro = '';
        this.objTempAccount.cidade = '';
        this.objTempAccount.estado = '';
        this.objTempAccount.numero = '';
    }

    handleChange(event) {
        let fieldName = event.target.dataset.label;
        let fieldValue = event.detail.value;

        if( fieldName === 'Cep' ) {
            let fieldValueSemCaracteres = fieldValue.replace( /\D+/g, '' );

            let cepRegex = fieldValueSemCaracteres.match( /(\d{0,5})(\d{0,3})/ );
            fieldValue = cepRegex[1] + ( cepRegex[2] ? '-' + cepRegex[2] : '' );
            event.target.value = fieldValue;
            this.objTempAccount.cep = fieldValue
        }

        if (fieldName === 'Numero') {
            event.target.value = fieldValue;
            this.objTempAccount.numero = fieldValue;
        }
    }

    verificarCep() {
        if(this.objTempAccount.cep.length < 9) {
            return false;
        }
        return true;
    }
}