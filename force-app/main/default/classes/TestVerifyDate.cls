@isTest
public class TestVerifyDate {
    @isTest static void testDate() {
        Date d = VerifyDate.CheckDates(System.today(),System.today()+1);
        Date d1 = VerifyDate.CheckDates(System.today(),System.today()+60);    
    }
}