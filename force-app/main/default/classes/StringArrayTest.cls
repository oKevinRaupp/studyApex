public with sharing class StringArrayTest {

    public static List<String> generateStringArray(Integer intKevin) {
        List<String> lstString = new List<String>();

        for (Integer i = 0; i < intKevin; i++) {
            lstString.add('Test ' + i.toString());
            System.debug(lstString[i]);
        }

        return lstString;

    }
}