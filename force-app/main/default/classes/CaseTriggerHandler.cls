public class CaseTriggerHandler extends TriggerHandler{
    
    private Map<Id, Case>newCaseMap;
    
    public CaseTriggerHandler(){
        this.newCaseMap = (Map<Id, Case>) Trigger.newMap;
    }
    
    
    public override void beforeInsert(){
        for(Case c : (List<Case>) Trigger.new) {
            
        }
    }

}