function [hit, miss,fa,cr,tr,ntr,newcorrect,correct]=find_ratios4(bining,Score) 

 hit=[];
fa=[];
miss=[];
cr=[];
U=unique(bining);
 for h=1:length(U)
 %target(da)=sum(lastlevel(:,1)==dayslevel(da) & (lastlevel(:,2)==1 | lastlevel(:,3)==1));
 hit(h)=sum(bining(:,1)==U(h) & Score==0);
 miss(h)=sum(bining(:,1)==U(h) & Score==2);
 fa(h)=sum(bining(:,1)==U(h) & Score==1);
  cr(h)=sum(bining(:,1)==U(h) & Score==3);

tr(h)=hit(h)/(hit(h)+ miss(h));
ntr(h)=fa(h)/(fa(h)+ cr(h));
newcorrect(h)=(hit(h)+cr(h))/(hit(h)+cr(h)+fa(h)+ miss(h));
 end
 correct=[];
 %correct=(tr+(1-ntr))/2;
 
end