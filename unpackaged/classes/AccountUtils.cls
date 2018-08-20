public class AccountUtils{

    private static boolean alreadyFired = false;
    
    public void doTheThing(Integer i){
     i = 1;
    }
    
    public static void updatePhone(){
        Account a = (Account)Trigger.new[0];
        a.Phone = '1111111';
    }


    public static boolean hasAlreadyFired() {
        return alreadyFired;
    }
    
    public static void setAlreadyFired() {
        alreadyFired = true;
    }

    @future
    public static void updateTheAccountFax(ID a){
        Account theAccount = [SELECT Id,Fax FROM Account WHERE Id = :a];
        theAccount.Fax = '11111';
        update theAccount;
    }
    
    @future
    public static void updateChildAccountFax(List<ID> a){
    if(!hasAlreadyFired()){
        Account[] childAccounts = [SELECT Id,Fax,Parent.Fax FROM Account Where ParentId = :a];
        System.Debug('Account Info: ' + childAccounts);
        
        if (childAccounts.size() > 0) {
            for (Account c: childAccounts){
                if(c.Fax != c.Parent.Fax)
                    c.Fax = c.Parent.Fax;                
            }

            setAlreadyFired();
            //update childAccounts;
            Database.SaveResult[] result = Database.update(childAccounts);
                Integer errores = 0;
                Integer exitos = 0;
                for(Database.SaveResult sr : result)
                {
                    if(!sr.isSuccess())
                    {
                        errores++;
                        Database.Error errA = sr.getErrors()[0];
                        System.debug('Error: ' + errA.getMessage());
                    }
                    else
                    {
                        exitos++;
                    }
                }
                System.debug('Exit messages: ' + errores + ' / ' + exitos);
          }
    }    
    }
    
    public void doTheLoop(){
        List<Account> accList = [SELECT Id FROM Account WHERE Name = 'Case08122132'];
        for (Account a : [SELECT Id FROM Account WHERE Id in: accList]){
            Integer i = 0;
        }
    }    
}