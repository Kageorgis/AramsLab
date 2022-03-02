trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
    List<Task> listTask = new  List<Task>();
    for(Opportunity opp : Trigger.New){
        if(opp.StageName=='Closed Won'){
             Task t= new Task();
            t.subject = 'Follow Up Test Task';
            t.WhatId = opp.Id;
            listTask.add(t);
        }
    }
    insert listTask;
}

/*
trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, after insert, after update) {

    List <Task> taskLstIn = new List <Task>();
    //if(Trigger.isBefore && Trigger.isInsert){
        for(Opportunity opp : Trigger.new) {
            if(opp.StageName == 'Closed Won'){
                taskLstIn.add(new Task(WhatId = opp.id,
                                     Subject = 'Follow Up Test Task'
                                     ));
            }
        }
        if(taskLstIn.size()>0){
        	insert taskLstIn;
        }
	//}
    /*
    List <Task> taskLstUp = new List <Task>();
    if(Trigger.isAfter && Trigger.isUpdate){
         for(Opportunity opp : Trigger.new) {
            if(opp.StageName == 'Closed Won'){
                taskLstUp.add(new Task(WhatId = opp.id,
                                     ActivityDate=Date.Today(),
                                     Subject = 'Follow Up Test Task',
                                     Priority = 'High',
                                     OwnerId = UserInfo.getUserId()
                                     ));
            }
        }
        if(taskLstUp.size()>0){
        	update taskLstUp;
        }
    }*/
//}