trigger OrderTrigger on Order (before insert, after insert) {
    if (Trigger.isBefore && Trigger.isInsert){
        system.debug('Inside Before Insert');
        OrderTriggerHandler.setDefaultValues(Trigger.new);
    }
    if (Trigger.isAfter && Trigger.isInsert){
        system.debug('Inside After Insert');
        OrderTriggerHandler.createOrderItems(Trigger.new);
    }
}