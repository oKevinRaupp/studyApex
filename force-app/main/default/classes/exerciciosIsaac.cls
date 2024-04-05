public with sharing class exerciciosIsaac{
    public static void calcularValorParcela(Id Id){

        List<Parcela__c> lstParcelas = [SELECT Id, 
                                               DtVencimento__c, 
                                               Vencido__c, 
                                               ValorParcela__c
                                        FROM Parcela__c
                                        WHERE Id = :Id];


        if (!lstParcelas.isEmpty()){
            Parcela__c parcela = lstParcelas[0];

            System.debug('Valor atual parcela: ' + parcela.ValorParcela__c);

            if (parcela.DtVencimento__c < System.Today()){
                parcela.ValorParcela__c *= 1.10;
                update parcela;

                System.debug('Valor da parcela depois do juros de 10%: ' + parcela.ValorParcela__c);

            } else if (parcela.DtVencimento__c > System.Today()){
                parcela.ValorParcela__c *= 0.95;
                update parcela;

                System.debug('Valor da parcela depois do desconto de 5%: ' + parcela.ValorParcela__c);
            }

        }
    }

    public static void isCadastroClienteOk(Id idAccount){

        List<Account> lstAccount = [SELECT Id, 
                                           Active__c, 
                                           BillingAddress, 
                                           AccountNumber, 
                                           AnnualRevenue
                                    FROM Account
                                    WHERE Id = :idAccount];
        if (!lstAccount.isEmpty()){
            Account objAccount = lstAccount[0];
            try{
                if (objAccount.Active__c == 'No'){
                    throw new ClienteInativoException('Não é possível efetuar operações com cliente inativo! ');
                }
                if (objAccount.BillingAddress == null || objAccount.AccountNumber == null || objAccount.AnnualRevenue == null){
                    throw new CamposNaoPreenchidosException('Existem campos obrigatórios que não foram preenchidos, verifique! ');
                }
            } catch (ClienteInativoException error){
                System.debug('Mensagem: ' + error.getMessage());
            } catch (CamposNaoPreenchidosException error){
                System.debug('Mensagem: ' + error.getMessage());
            }

        }
    }

    public static void createOpportunityClientePJ(Id idAccount){


        List<Account> lstAccount = [SELECT Id, 
                                           NumeroConta__c, 
                                           Agencia_Bancaria__c, 
                                           (SELECT Id
                                            FROM Contacts)
                                    FROM Account 
                                    WHERE Id = :idAccount];

        if (!lstAccount.isEmpty()){
            Account objAccount = lstAccount[0];
            try{
                if (objAccount.NumeroConta__c == null || objAccount.Agencia_Bancaria__c == null){
                    throw new ClienteSemDadosBancariosException('Os dados bancarios não foram preenchidos corretamente, verifique!');
                }
                if (objAccount.Contacts.isEmpty()){
                    throw new ClienteSemContatosRelacionadosException('Cliente sem contatos relacionados, verifique!');
                }

                Opportunity objOpportunityToInsert = new Opportunity();
                objOpportunityToInsert.AccountId = objAccount.Id;
                objOpportunityToInsert.CloseDate = System.today().addDays(4);
                objOpportunityToInsert.Name = 'Nova opp Cliente PJ';
                objOpportunityToInsert.StageName = 'Prospecting';

                Database.SaveResult srObject = Database.insert (objOpportunityToInsert, false);

                if (srObject.isSuccess()){
                    // Operation was successful, so get the ID of the record that was processed
                    System.debug('Successfully inserted opportinity. Opportinity ID: ' + srObject.getId());
                } else{
                    // Operation failed, so get all errors
                    for (Database.Error err : srObject.getErrors()){
                        System.debug('The following error has occurred.');
                        System.debug(err.getStatusCode() + ': ' + err.getMessage());
                        System.debug('Opportinity fields that affected this error: ' + err.getFields());
                    }
                }

            } catch (ClienteSemDadosBancariosException err){
                System.debug(err.getMessage());
            } catch (ClienteSemContatosRelacionadosException err){
                System.debug(err.getMessage());
            }

        }
    }

    public static void createCaseClientPJ(Id idAccount){

        List<Account> lstAccount = [SELECT Id, 
                                           Name, 
                                           Active__c, 
                                           (SELECT Id
                                            FROM Contacts)
                                    FROM Account 
                                    WHERE id = :idAccount];


        if (!lstAccount.isEmpty()){
            Account objAccount = lstAccount[0];
            try{
                if (objAccount.Active__c == 'No'){
                    throw new ClienteInativoException('Não é possível efetuar operações com cliente inativo!');
                }
                if (objAccount.Contacts.isEmpty()){
                    throw new ClienteSemContatosRelacionadosException('Cliente sem contatos relacionados, verifique!');
                }

                createCaseClientePJ(objAccount);


            } catch (ClienteSemContatosRelacionadosException err){
                System.debug(err.getMessage());
            } catch (ClienteInativoException err){
                System.debug(err.getMessage());
            }
        }
    }

    public static void createCaseClientePJ(Account account){
        Case objNewCaseToInsert = new Case();

        objNewCaseToInsert.AccountId = account.Id;
        objNewCaseToInsert.status = 'New';
        objNewCaseToInsert.Origin = 'Web';
        objNewCaseToInsert.Subject = account.Name + ' - Sinistro';

        Database.SaveResult srObject = Database.insert (objNewCaseToInsert, false);

        if (srObject.isSuccess()){
            // Operation was successful, so get the ID of the record that was processed
            System.debug('Successfully inserted case. Case ID: ' + srObject.getId());
        } else{
            // Operation failed, so get all errors
            for (Database.Error err : srObject.getErrors()){
                System.debug('The following error has occurred.');
                System.debug(err.getStatusCode() + ': ' + err.getMessage());
                System.debug('Opportinity fields that affected this error: ' + err.getFields());
            }
        }
    }

    public class ClienteInativoException extends Exception{
    }

    public class CamposNaoPreenchidosException extends Exception{
    }

    public class ClienteSemDadosBancariosException extends Exception{
    }

    public class ClienteSemContatosRelacionadosException extends Exception{
    }

}