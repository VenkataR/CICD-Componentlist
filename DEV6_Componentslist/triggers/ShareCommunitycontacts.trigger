trigger ShareCommunitycontacts on User (after insert) {
    
    if(trigger.isafter && trigger.isinsert){
        profile p = [select id from profile where name='Branch Coordinator'];
        profile p1=[select id from profile where name='Volunteer PC'];
        system.debug('profiles are ready');
        list<id> ulist = new list<id>();
        for(user u: trigger.new){
            id profileid= u.profileid;
            // for Branch Co : 
            if(u.Contactid!=null && profileid==p.id){
                system.debug('Branch Co : profile'+p.id);
                ulist.add(u.id);
             // for Volunteer : 
            }else if(u.Contactid!=null && profileid==p1.id){
                system.debug('Volunteer profile'+p.id);
              ulist.add(u.id);   
            }
        }
        if(ulist.size()>0) {
             system.debug('insert contactshares : '+ulist.size());
            commnitycontactshare.contactshare(ulist);
        }
        
    }  
    
    
}