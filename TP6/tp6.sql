Drop synonym T;	
  
create synonym T for L3_33.T;	
 

 
update T set B=10 where B=0;	
  	
  
select	
  *	
  from	
  	
  T;	
  
update T  set A=5 where	A=3;	

---------------------------------------
select * from T;	
  
update T set A=A+1;	
  	
  
commit;	
  
	
  
select * from T;	
  
update T set A=A+1;	
  	
commit;	

-----------------

select * from T for update;	
  
update	T set A=A+1;	
   
commit;	
  
select	* from	T;	
  
select	* from	T	for	 update;	
  
	
  
commit;	

  