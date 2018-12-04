public class MyTestController {
    public list<Membership_Payment_Category__mdt> frepeat{get; set;}
    public list<Membership_Fee__mdt> Srepeat{get; set;}
    public String x{get; set;}
    public Integer i=0;
    public String Test {get; set;}
    public String Test1 {get; set;}
    public String selectedValue {get; set;}
        
    public string displayValue {get;set;}
	public string counter  {get;set;}
    public string MLabel {get;set;}
    public String ival {get; set;}
   // public string selectedValue {get;set;}
    //public list<SelectOption> SelOptions {get; set;}
   /* public List<String> SelectedPreferences {
        get{
            if(SelectedPreferences == NULL){
                
                SelectedPreferences = new List<String>();
            }
            return SelectedPreferences;
        }
        set;}*/
    public MyTestController(){
        displayValue = 'none';
        counter = '';
        frepeat = new list<Membership_Payment_Category__mdt>();
        Srepeat = new list<Membership_Fee__mdt>();
        frepeat= [select id,MasterLabel from Membership_Payment_Category__mdt order by id ASC];
        Srepeat=[select id,MasterLabel,Membership_Payment_Category__c,Membership_Payment_Type__c from Membership_Fee__mdt order by Membership_Payment_Category__c ASC];
        
       	String selVal=Apexpages.currentPage().getParameters().get('selVal');
        System.debug('Test'+selVal);
        
         String Tested=Apexpages.currentPage().getParameters().get('input1');
        	System.debug('Selected Value'+Tested);
        /*list<Membership_Payment_Category__mdt> mpc = [select id,MasterLabel from Membership_Payment_Category__mdt];
        	String MCat = mpc[0].id;
        list<Membership_Fee__mdt> mf =[select id,MasterLabel,Membership_Payment_Category__c,Membership_Payment_Type__c from Membership_Fee__mdt where Membership_Payment_Category__c=:mpc[0].id];
        	System.debug('Test'+mf);
        	//frepeat = [select id,MasterLabel from Membership_Payment_Category__mdt];
        //for(integer i=0; i< mpc.size();i++){
        
        while(i<mpc.size()){
            frepeat = [select id,MasterLabel from Membership_Payment_Category__mdt];
            String ids = mpc[i].id; 
            Srepeat=[select id,MasterLabel,Membership_Payment_Category__c,Membership_Payment_Type__c from Membership_Fee__mdt where Membership_Payment_Category__c=:ids];
             i++;
        }*/
            
             
            
       //}while(i<mpc.size());
       //for(Membership_Payment_Category__mdt mpcs: mpc){
       		
        //    String ids = mpc[i].id; 
        //x= mfs[0].Membership_Payment_Category__c;
       // Srepeat=[select id,MasterLabel,Membership_Payment_Category__c,Membership_Payment_Type__c from Membership_Fee__mdt where Membership_Payment_Category__c=:ids];
        //String MCat = mpc[0].id;
        
      
        //String fquery = 
        
        
        //frepeat = Database.query(fquery);
        	
        //String squery =
        	
        //frepeat = mpc[0].MasterLabel;
        //Srepeat = mf[0].Membership_Payment_Type__c;
       // Srepeat = Database.query(squery);
      //  }
        
    }
    public PageReference Display(){
        if(selectedValue!=null){
            System.debug('selectedValue'+selectedValue);
        }
        //String input = Apexpages.currentPage().getParameters().get('selVal');
		//System.debug('select'+input);
		return null;
        
    }
    public void receiveInput() {
       String input1=Apexpages.currentPage().getParameters().get('input1');
        system.debug('==Entered the Controller: '+ input1);
        Test = input1;
        System.debug('Value: '+Test);
    }
    /*public list<SelectOption> tester {get{
        list<SelectOption> Options = new list<SelectOption>();
        
        list<Membership_Fee__mdt> ms1 =[select Id, MasterLabel, Membership_Payment_Category__c, Membership_Payment_Type__c from Membership_Fee__mdt order by Membership_Payment_Category__c];
        set<String> cat = new set<String>();
        list<String> catlist = new list<String>();
        catlist.addAll(cat);
        for(Membership_Fee__mdt msf: ms1){
            if(cat.contains(msf.Membership_Payment_Category__c) == false){
                cat.add(msf.Membership_Payment_Category__c);
                
            }
            system.debug('Category: '+cat);
        }
        for(integer i=1; i<ms1.size(); i++){
           /* for(integer j=0; j<catlist.size();j++){
                String test1 = catlist[j];
                if(ms1[i].Membership_Payment_Category__c == catlist[j]){
                    Options.add(new SelectOption(test1,test1));
                }
            }*/
           /* if(i==0){
                String test1 = ms1[i].Membership_Payment_Category__c;
                //if(ms1[i].Membership_Payment_Category__c){
                    Options.add(new SelectOption(test1,test1));
                
                String type1= ms1[i].Membership_Payment_Type__c;
          		 Options.add(new SelectOption(type1,type1));
            }
            else{*/
            
            
            /*if((ms1[i].Membership_Payment_Category__c == ms1[i].Membership_Payment_Category__c)){
                System.debug('Cat --'+ms1[--i].Membership_Payment_Category__c);
                System.debug('Cat ++'+ms1[i].Membership_Payment_Category__c);
                String test1 = ms1[i].Membership_Payment_Category__c;
                //if(ms1[i].Membership_Payment_Category__c){
                    Options.add(new SelectOption(test1,test1));
                
                String type1= ms1[i].Membership_Payment_Type__c;
          		 Options.add(new SelectOption(type1,type1));
            }
            else{
                String type1= ms1[i].Membership_Payment_Type__c;
          		 Options.add(new SelectOption(type1,type1));
                //}
            }   
           //}
          
                
           
           }
        //if(cat.contains(ms1[0].Membership_Payment_Category__c) == true){
            
        //}
        
        system.debug('Select Options: '+Options);
        return Options;
    } set;}
    //public String[] value { get; set; }
    public List<String> SelectedPreferences {
        get{
            if(SelectedPreferences == NULL){
                
                SelectedPreferences = new List<String>();
            }
            return SelectedPreferences;
        }
        set;}
    public MyTestController() {
        /*list<Membership_Fee__mdt> lst =[select Id, MasterLabel, Membership_Payment_Category__c, Membership_Payment_Type__c from Membership_Fee__mdt];
        String lms = lst[0].Membership_Payment_Category__c;
        list<Membership_Fee__mdt> lst1 =[select Id, MasterLabel, Membership_Payment_Category__c, Membership_Payment_Type__c from Membership_Fee__mdt where Membership_Payment_Category__c = :lms];
        //value = new String[] { '1', '2' };
       // String s1 = lst[0].Membership_Payment_Type__c+lst[0].MasterLabel;
        if(lst1[0].Membership_Payment_Category__c == '18 month membership'){
            String s1 = lst1[0].Membership_Payment_Type__c+lst1[0].MasterLabel;
            tester  = new List<SelectOption> {
            new SelectOption(s1, s1),
            new SelectOption('2', '2'),
            new SelectOption('3', '3'),
            new SelectOption('4', '4')
        };
        }*/
         
        
    //}*/
    public void post()
    {
        System.Debug('The value is : ' + Test);
    }

    
}