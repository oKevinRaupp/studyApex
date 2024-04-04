trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {

    if(Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {

        List<Task> lstTask = new List<Task>();
        
        for(Opportunity opp : Trigger.new) {
            if (opp.StageName == 'Closed Won') {
                Task newTask = new Task(Subject='Follow Up Test Task');
                newTask.WhatId = opp.Id;
                lstTask.add(newTask);
            }
        }

        if (!lstTask.isEmpty()) {
            insert lstTask;
        }

    }

}