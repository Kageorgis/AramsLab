public with sharing class dataFetcher {
    @AuraEnabled(cacheable=true)
    public static List<SetupAuditTrail> getAuditLog() {

        return [
            SELECT CreatedBy.Name, Action, Section, Display, CreatedDate
            FROM SetupAuditTrail 
            ORDER BY CreatedDate desc
        ];

    }
}