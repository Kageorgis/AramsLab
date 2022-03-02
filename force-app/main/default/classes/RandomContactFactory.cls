public class RandomContactFactory {
    
    public static List <Contact> generateRandomContacts(Integer numOfConts, String lastName){

        List <Contact> contList = new List<Contact>();
        
        for(Integer i = 0; i < numOfConts; i++){
            contList.add(new Contact (FirstName = 'TestName' + i, LastName = lastName + i));
    	}

		system.debug(contList);        
        return contList;
    }
}