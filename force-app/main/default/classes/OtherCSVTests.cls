@isTest
private class OtherCSVTests {

    @TestSetup
    static void setup(){
        List<SObject> records = Test.loadData(Account.sObjectType, 'otherAccountData');
    }

    @isTest
    static void testLoadOtherAccountsFromStaticResource() {
        Test.startTest();
        Integer expectedAccount = 15;
        Integer actualAccountCount = [SELECT Count() FROM Account];
        System.assertEquals(expectedAccount, actualAccountCount);
        Test.stopTest();
    }
}