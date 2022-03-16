@RestResource(urlMapping='/case/*/close') // Expose service to off-platform callers
global with sharing class CaseCloseResource {
    @HttpPost
    global void static implementCloseCases(String closeReason) {
        // Parse context
        RestRequest req = RestContext.request;
        String[] uriParts = req.requestURI.split('/');
        Id caseId = uriParts[2];
        // Call the service
        CaseService.closeCases(
        new Set<Id> { caseId }, closeReason);  
    }
}