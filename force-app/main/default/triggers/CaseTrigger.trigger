trigger CaseTrigger on Case (before insert) {
    // Run an instance of the Case Trigger Handler
    new CaseTriggerHandler.run();
    

}