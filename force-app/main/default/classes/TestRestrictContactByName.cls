@isTest
private class TestRestrictContactByName {
    
    // All test methods have access to a fresh instance of the data created in the test Setup method.
    // The processing in each test method is not persisted.
    @testSetup static void testSetup(){
        Contact cont = new Contact(LastName = 'INVALIDNAME');
    }
    
    @isTest static void testInvalidContName(){
        
        Contact cont = new Contact(LastName = 'INVALIDNAME');
        List <Contact> contList = RandomContactFactory.generateRandomContacts(6, 'Smith');
        
        
        
            Test.startTest();
        
            try
            {
                insert cont;
            }
            catch(Exception DML)
            {
            	String expectedMessage = 'The Last Name "'+ cont.LastName+'" is not allowed for DML';
            	System.assertEquals(expectedMessage, DML.getDmlMessage(0));
            }
        
        	Test.stopTest(); 
        
    }

}