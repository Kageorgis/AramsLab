trigger CaseTrigger on Case (before insert, after insert, before update, after update) {
    // Run an instance of the Case Trigger Handler
    new CaseTriggerHandler.run();
}