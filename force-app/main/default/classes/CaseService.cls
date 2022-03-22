public with sharing class CaseService {
    public static void closeCases(Set<Id> caseIds, String closeReason, Options config) {

        if(caseIds == null || caseIds.size() == 0)
            throw new CaseServiceException('Cases not specified.');
        if(closeReason == null)
            throw new CaseServiceException('Case Reason not specified');

        List<Case> casesToUpdate = [SELECT Status, Reason FROM Case WHERE Id in :caseIds];
        
        for (Case c : casesToUpdate){
            c.Status = 'Closed';
            c.Reason = closeReason;
        }

        // Update the database
        SavePoint sp = Database.setSavePoint();
        try {
             update casesToUpdate;
        } catch (Exception e) {
            // Rollback
            Database.rollback(sp);
            // Throw exception on to caller
            throw e;
        } 
    }
}
