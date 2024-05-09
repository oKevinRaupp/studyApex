@isTest
public class TestRestrictContactByName {
    @isTest static void TestRestrictContactByName_test1(){
        Contact con=new Contact(FirstName='Deepu',LastName='INVALIDNAME');
        insert con;
    }
}