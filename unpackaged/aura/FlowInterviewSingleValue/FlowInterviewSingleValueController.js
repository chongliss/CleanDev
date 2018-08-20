({
    init:function(component, event, helper){
        console.log(component.get("v.recordId"));
    },
    doInit : function (component, event, helper) {        
        var flow = component.find("CloneOppLineItems_Clean");                
        var theOpp = component.get("v.simpleRecord");
        var oppId = theOpp.ClonedFromOpportunity__c == null ? '' : theOpp.ClonedFromOpportunity__c;
        var newId = theOpp.Id;
        
        var inputVariables = [
            {
                name : "OppId",
                type : "String",
                value: oppId
            },
            {
                name : "NewOppId",
                type : "String",
                value: newId
            }
        ];
        flow.startFlow("CloneOppLineItems_Clean", inputVariables);              
    },
    handleFlowChange: function(component, event, helper){
        if(event.getParam("status") === "FINISHED") {
            var theOpp = component.get("v.simpleRecord");
            var newId = theOpp.Id;
            var urlEvent = $A.get("e.force:navigateToSObject");
            urlEvent.setParams({
                "recordId": newId,
                "isredirect": "true"
            });
            urlEvent.fire();
        }
    }
})