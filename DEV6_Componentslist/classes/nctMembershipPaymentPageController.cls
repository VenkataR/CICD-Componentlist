public class nctMembershipPaymentPageController 
{
    public string twomems{get; set;}
    public boolean twomem{get; set;}
    public String isGiftAid{get; set;}
    public String firstname{get; set;}
    public String lastname{get; set;}
    public String email{get; set;}
    public String phone{get; set;}
    public String sfirstname{get; set;}
    public String slastname{get; set;}
    public String semail{get; set;}
    public String sphone{get; set;}
    public String postCode{get; set;}
    public String genderValue {get; set;}
    public String streetValue {get; set;}
    public String streetValue1 {get; set;}
    public String streetValue2 {get; set;}
    public String stateValue {get; set;}
    public String cityValue {get; set;}
    public Contact newCont {get;set;} 
    public Contact snewCont {get;set;} 
    public AccountContactRelation accntContRel{get; set;}
    public cpm__Payment_Profile__c pymtPrfl {get;set;}
    public npe03__Recurring_Donation__c recDon {get;set;}
    public gaid__Gift_Aid_Declaration__c gftAid {get;set;}
    public Booking__c corsBkng {get;set;}
    public Id feeAmount {get;set;}
    public Id selectBranch {get; set;}
    public string membershipNumber {get;set;}
    public string courseBookingNo {get;set;}
    public string redirectURL {get;set;} 
    public Id contId {get;set;}
    public Course__c cors;
    // added by MembershipFormController
    public String accountName {get; set;}
    public String sortCode {get; set;}
    public String accountNumber {get; set;}
    public string displayValue {get;set;}
    public string counter  {get;set;}
    public string SelValues {get;set;}
    public Membership_Type__mdt membershipInfo {get;set;}
    public npe03__Recurring_Donation__c reccDon {get;set;}
    public Map<String, List<Membership_Type__mdt>> membershipTypeMap{get;set;}
    public list<Account> branchs {get; set;}
    public list<Account> nearestBranchs {get; set;}
    public Id branchRecordTypeId {get; set;}
    public list<Account> latlonPostcode {get; set;}
    public String eDate {get; set;}
    public nctMembershipPaymentPageController()
    {	
        contId = ApexPages.currentPage().getParameters().get('Id');
        system.debug('*$*$**$ contId  ' + contId);
        if(contId != null)
        {
            newCont = [SELECT Id, LastName, FirstName, Email, Phone,MailingPostalCode,Prefered_First_Name__c,AccountId FROM Contact where id=:contId];
            if(newCont != null){
                firstname = newCont.Prefered_First_Name__c;
                lastname = newCont.LastName;
                email = newCont.Email;
                phone = newCont.Phone;
                postCode = newCont.MailingPostalCode;
                
            }
            /*else{
                firstname = '';
                lastname = '';
                email = '';
                phone = '';
                postCode = '';
            }*/
        }
        pymtPrfl = new cpm__Payment_Profile__c();
        recDon = new npe03__Recurring_Donation__c();
        gftAid = new gaid__Gift_Aid_Declaration__c();       
        displayValue = 'none';
        counter = '';
        accountName='';
        sortCode='';
        accountName='';  
        corsBkng = new Booking__c();             
    }
    public void receiveInput(){
        system.debug(firstname + '   *$*#@**$*$ firstname  ' + lastname + ' lastname &$#*#*# email  ' + email + '   *$*$*$ phone ' + phone);
        //boolean chkbox = Apexpages.currentPage().getParameters().get('chkbox')=='true';
        //System.debug('chkbox'+chkbox);
        //twomems = chkbox;
        System.debug('Twomems :'+twomems);
        if(twomems == 'true')
        {   
            membershipTypeMap = MembershipUtilties.getMembershipTypeMap('joint');            
        }
        else 
        {
            System.debug('twomems '+twomems);
            membershipTypeMap = MembershipUtilties.getMembershipTypeMap('Individual');
            System.debug('membershipTypeMap '+membershipTypeMap);
        }
        // Yet to define the custom metadata, once done the logic can be updated and modified accordingly, hence commenting
        
       /* if(ContactId != null && ContactId != '')
        {
            accntContRel =[SELECT Id,Roles FROM AccountContactRelation where contact.id=:ContactId];
            if(accntContRel.id != null){
                if(accntContRel.Roles == 'Volunteer'){
                    membershipTypeMap = MembershipUtilties.getMembershipTypeMap('Volunteer');
                }
                else if(accntContRel.Roles == 'Practitioner'){
                    membershipTypeMap = MembershipUtilties.getMembershipTypeMap('Practitioner');
                }
                
            }
            else{
                System.debug('accntContRel id is null: '+accntContRel);
                System.debug('twomems '+twomems);
                membershipTypeMap = MembershipUtilties.getMembershipTypeMap('joint');
                System.debug('membershipTypeMap '+membershipTypeMap);
            }
        }*/
    }
    public PageReference ContactInfo()
    {
        feeAmount = Apexpages.currentPage().getParameters().get('seltdName');
        PageReference redirecContUrl;
        system.debug('*$*$*$  feeAmount   ' + feeAmount);
        membershipInfo = [SELECT Id, MasterLabel, Eligible_for_Gift_Aid__c,Installment_Amount__c, 
                                                No_of_Installments__c,Payment_Type__c,  Payment_Method__c, Recursive__c, 
                                                Total_Amount__c, Contact_Type__c,  Membership__c  FROM  Membership_Type__mdt 
                                                where Id =:feeAmount];
        System.debug('Membership##### '+membershipInfo);
        if(membershipInfo != null)
        {
            if(membershipInfo.Payment_Method__c == 'Credit/Debit Card')
            {
               	redirecContUrl = PaymentHubCallout();
            }
        }  
        return redirecContUrl;
    }
  
    public void nctBranchs(){
        String units = 'mi';
        postCode = Apexpages.currentPage().getParameters().get('postVal');
        System.debug('postCode: '+postCode);
        branchRecordTypeId = Schema.SObjectType.Account.getRecordTypeInfosByName().get('Branch').getRecordTypeId();
        branchs =[SELECT Name, Id, RecordTypeId FROM Account where RecordTypeId =:branchRecordTypeId order by Name ASC];
        latlonPostcode =[SELECT Id, BillingPostalCode, BillingLatitude, BillingLongitude FROM Account where BillingPostalCode = :postCode and BillingLatitude != null and BillingLongitude != null limit 1];
        if(latlonPostcode.size()>0){
            Decimal lattitude = latlonPostcode[0].BillingLatitude;
        	Decimal longitude = latlonPostcode[0].BillingLongitude; 
 
            //nearestBranchs =[SELECT Id,Name FROM Account where DISTANCE(BillingAddress, GEOLOCATION(lattitude ,longitude), mi) < 30];
            
            String queryString = 'SELECT Id, Name '+
                'FROM Account where (DISTANCE(BillingAddress ,GEOLOCATION('+lattitude+','+longitude+'), \'mi\')< 30) and BillingPostalCode=:postCode order by Name limit 10';
              
            System.Debug('>>>> the value of queryString is ' + queryString);
            try{
                nearestBranchs = database.query(queryString);
            }
            catch(exception e){
                System.debug('Error: 153 : '+e);
            }    
              
     
    	}
        
    }
    public void PaymentSave()
    {
        system.debug(firstname + '   *$*#@**$*$ firstname  ' + lastname + ' lastname &$#*#*# email  ' + email + '   *$*$*$ phone ' + phone);
        //system.debug(accountNumber + '   *$*#@**$*$ accountName  ' + accountName + '  &$#*#*#  ' + sortCode + '   *$*$*$ newCont ' + newCont.Id);
		Date expDate = Date.valueOf(eDate);
        if(newCont == null)
        {
            newCont = new Contact();
            newCont.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Parent').getRecordTypeId();
            newCont.Prefered_First_Name__c = firstname;
            newCont.LastName = lastname;
            newCont.Email = email;
            newCont.Phone = phone;
            newCont.MailingPostalCode = postCode;
            newCont.Expected_Due_Date__c = expDate; 	
            newCont.Branch__c = selectBranch; 
            newCont.Gender__c = genderValue;
            newCont.MailingStreet = streetValue+''+streetValue2+''+streetValue2;
            newCont.MailingState = stateValue;
            newCont.MailingCity = cityValue;
            insert newCont;
        }
        if(twomems == 'true' && sfirstname != null || sfirstname != '')
        {
            snewCont = new Contact();
            snewCont.RecordTypeId = Schema.SObjectType.Contact.getRecordTypeInfosByName().get('Companion').getRecordTypeId();
            snewCont.Prefered_First_Name__c = sfirstname;
            snewCont.LastName = slastname;
            snewCont.Email = semail;
            snewCont.Phone = sphone;
            snewCont.Parent_Contact__c = newCont.id;
            snewCont.MailingPostalCode = postCode;
            snewCont.Expected_Due_Date__c = expDate; 	
            snewCont.Branch__c = selectBranch;
            snewCont.MailingStreet = streetValue+''+streetValue2+''+streetValue2;
            snewCont.MailingState = stateValue;
            snewCont.MailingCity = cityValue;
            insert snewCont;
        } 
        /*else{
            System.debug('newCont error: '+newCont);
        }*/
        
        if(newCont != null)
        {
            system.debug(' *$*$*$* Contact Account Id   ' + newCont.AccountId);
            pymtPrfl.RecordTypeId = Schema.SObjectType.cpm__Payment_Profile__c.getRecordTypeInfosByName().get('Bank Account').getRecordTypeId();
            pymtPrfl.cpm__Contact__c = newCont.Id; 
            if(accountNumber != '' && accountNumber != null)
            {
                pymtPrfl.Account_Number__c = decimal.valueOf(accountNumber);
            }            
            pymtPrfl.cpm__Account__c = newCont.AccountId;
            pymtPrfl.cpm__Bank_Account__c = '';
            pymtPrfl.cpm__Holder_Name__c = accountName;
            pymtPrfl.paybacs__Sort_Code__c = sortCode;
            insert pymtPrfl; 
        	System.debug('Gift Aid Check box: '+isGiftAid);
            if(isGiftAid == 'true')
            {
                gftAid.gaid__Contact__c= newCont.Id;
                //gftAid.Name = 'New Gift Aid' + system.now();
                gftAid.Method__c = 'Online';
                gftAid.gaid__Type__c = 'Single';
                gftAid.Declaration_Number__c = 56443323;
                gftAid.gaid__Active__c = true;
                insert gftAid;            
            } 
            recDon.Name = membershipInfo.Contact_Type__c + ' ' + membershipInfo.Membership__c;
            recDon.npe03__Amount__c = 60;
            recDon.npe03__Contact__c = newCont.Id;
            recDon.CARE_Payment_Frequency__c = 'Monthly';
            recDon.Direct_Debit_Key__c = 432321323;
            recDon.First_Contact_Key__c = 12233342;
            recDon.Recurring_Donations_Key__c = 75664543;
            recDon.First_Contact__c = newCont.Id;
            recDon.npe03__Installment_Period__c = 'Monthly';
            recDon.npsp4hub__Payment_Method__c = 'Direct Debit';
            recDon.npsp4hub__Payment_Processor__c = 'PaymentHub-BACS';
            recDon.npsp4hub__Target__c = 'BACS Standard 18';
            recDon.Membership_Status__c = 'Confirmed';
            recDon.npsp4hub__Payment_Profile__c = pymtPrfl.Id;
            Insert recDon; 
       }
    }
    
    public void thankYouSec()
    {        
        system.debug('RECCURRING DONATION   ' + recDon.Id);
        if(recDon.Id != null)
        {
            reccDon = [select Id, Membership_Number__c from npe03__Recurring_Donation__c where Id =: recDon.Id];
            system.debug('RECCURRING DONATION record  ' + reccDon);
            if(reccDon != null)
            {
                membershipNumber = reccDon.Membership_Number__c;
                system.debug('membershipNumber  ' + membershipNumber);
            }
        }        
    }
    public PageReference PaymentHubCallout()
    {
        decimal instlmntAmt; 
        if(membershipInfo != null)
        {
           instlmntAmt = membershipInfo.Installment_Amount__c; 
        }
        
        string responseContent;
        
        HttpRequest tokenRequest = new HttpRequest();
        HttpResponse tokenResponse = new HttpResponse();
        Http tokenHttp = new Http();
        
        tokenRequest.setEndpoint('https://test.salesforce.com/services/oauth2/token?client_id=3MVG95AcBeaB55lVpFY_Rw8rGI.KUCG9dcqi1zRxbXuXhdoYYpgHOQUg01kQrJyfp_yYqnT6F.aEXC1U7n06J&client_secret=5804933462634405366&grant_type=password&username=payment.api@nct.org.uk.preuat&password=payment123rl3GtuRGUj15A1W6ysGuUAT3N');
  
        tokenRequest.setMethod('POST'); 
        tokenRequest.setTimeout(120000);    
        tokenResponse = tokenHttp.send(tokenRequest);

        AcessTokenResponseVo accessTokenVo = (AcessTokenResponseVo) JSON.deserialize(tokenResponse.getBody(),AcessTokenResponseVo.class);

        
        PaymentRequestVo paymentReq = new PaymentRequestVo();
        paymentReq.SuccessURL='https://preuat-mynct.cs102.force.com/nctPaymentHubSuccessMsgPage';
        paymentReq.FailureURL='https://preuat-mynct.cs102.force.com/nctPaymentHubErrorMsgPage';
        paymentReq.Origin='test';
 
        PaymentRequestVo.ContactVo cvo = new PaymentRequestVo.ContactVo();
        if(newCont != null)
        {
            cvo.Email = newCont.Email;        
        	cvo.FirstName = newCont.Prefered_First_Name__c;
        	cvo.LastName = newCont.LastName;
        }
        else if (newCont == null)
        {
            cvo.Email = email;        
        	cvo.FirstName = firstname;
        	cvo.LastName = lastname;
        }
 
        PaymentRequestVo.PayerVo payerReq = new PaymentRequestVo.PayerVo();
        payerReq.AllowDeduplication=true;
        payerReq.contact = cvo;
        payerReq.ContactUpdate ='replace';
        paymentReq.Payer = payerReq;
 
        PaymentRequestVo.PaymentVo payment = new PaymentRequestVo.PaymentVo();
        system.debug('*$*$**$*$ feeAmount  ' + instlmntAmt);        
        payment.Amount=instlmntAmt;
        paymentReq.Payment = payment;
 
        PaymentRequestVo.PaymentMethodVo paymentMethod = new PaymentRequestVo.PaymentMethodVo();
        paymentMethod.Name='CreditCard';
        paymentReq.PaymentMethod = paymentMethod;
 
        PaymentRequestVo.SourceConnectorVo sourceConnector = new PaymentRequestVo.SourceConnectorVo();
        sourceConnector.Name='PaymentHub';
        paymentReq.SourceConnector = sourceConnector;
 
        System.Debug('*$*$*$*$* JSON  =   ' + JSON.serializePretty(paymentReq));
        
        HttpRequest paymentHubRequest = new HttpRequest();
        HttpResponse paymentHubResponse = new HttpResponse();
        Http paymentHubHttp = new Http(); 
        paymentHubRequest.setEndpoint('https://cs102.salesforce.com/services/apexrest/cpm/v1.0/Payment');        
        paymentHubRequest.setHeader('Authorization','Bearer '+accessTokenVo.access_token);  
        //paymentHubRequest.setHeader('Authorization','Bearer '+ UserInfo.getSessionID()); 
        paymentHubRequest.setHeader('Content-Type','application/json; charset=UTF-8');
        paymentHubRequest.setHeader('Accept','application/json');
        paymentHubRequest.setHeader('api-token','IPy3Yvtin0aa2GPIke79Ewp24a0YSt6Daj5HJ9v9IGq2VTDYTWWkSx5jE2Pg54u02j0uHQZ3BwHfxFh8nKfXK4fiqZSQbZuXFQtQfAE926aFrwwVoOxPOJ6MiWSFpMc8b0UrOcbUD9pdcW7x8xNu3CtI5JfukTrRZqNByghsdTnWKLb79XrKpttmtHepMmVPv3QyPZYq');
        paymentHubRequest.setBody(JSON.serialize(paymentReq));
        paymentHubRequest.setMethod('POST'); 
        paymentHubRequest.setTimeout(120000);    
        paymentHubResponse = paymentHubHttp.send(paymentHubRequest);
        System.debug('*$*$*$*$*  RESPONSE =   ' + paymentHubResponse.getBody());
        responseContent = paymentHubResponse.getBody();
        system.debug('*$*$*$* responseContent ===   ' + responseContent);
        redirectURL = responseContent.subString(responseContent.IndexOf('PaymentHub')+28, responseContent.lastIndexOf('PaymentMethod')-3);
        system.debug('*$*$*$** redirectURL =   ' + redirectURL);
        //PageReference pageRefCrdDbt = new PageReference('https://ournct--preuat--c.cs102.visual.force.com/apex/phstr__stripecheckout?failureRedirectURL=https%253A%252F%252Fwww.example.com%252Ferror&id=a2b1j00000002s1AAA&successRedirectURL=https%253A%252F%252Fwww.example.com%252Fsuccess');
        redirectURL += '&nooverride=1';
        //PageReference pageRefCrdDbt = new PageReference('https://preuat-mynct.cs102.force.com/apex/phstr__stripecheckout?failureRedirectURL=https%3A%2F%2Fournct--preuat--c.cs102.visual.force.com%2Fapex%2FnctPaymentHubErrorMsgPage&id=a2b1j000000031FAAQ&successRedirectURL=https%3A%2F%2Fournct--preuat--c.cs102.visual.force.com%2Fapex%2FnctPaymentHubSuccessMsgPage');
        PageReference pageRefCrdDbt = new PageReference(redirectURL);
        pageRefCrdDbt.setRedirect(true);
        system.debug('  *$*$*$** pageRefCrdDbt =   ' + pageRefCrdDbt);
        return pageRefCrdDbt;
    }
}