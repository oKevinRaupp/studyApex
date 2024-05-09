@isTest
private class TaskUtilTests {
    
        @isTest
        static void testGetTaskPriorityNormal() {
            
            Test.startTest();
            TaskUtil.getTaskPriority('RS');
            Test.stopTest();
    
            System.assertEquals('Normal', TaskUtil.getTaskPriority('RS'));
    
        }
    
        @isTest
        static void testGetTaskPriorityHigh() {
            
            Test.startTest();
            TaskUtil.getTaskPriority('CA');
            Test.stopTest();
    
            System.assertEquals('High', TaskUtil.getTaskPriority('CA'));
    
        }
}