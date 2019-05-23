function [DT, AlllastIRCR,LT,LastlickCR,FirstlickHit,IRTm,IRNm,LickTm,LickNm]=find_IR_licks(cur_t,chosen_trials,TD)
ntrcolors={'y','r','b','m','g','k','c'};
thresh=0.001;
score=cur_t.score(chosen_trials);
level=cur_t.level(chosen_trials);
IRtime=cur_t.IR(chosen_trials);
IRMat=zeros(size(IRtime,1),10000);

tL=IRtime;
    for bb=1:length(tL)
        Df=abs(tL{bb});
        Df=Df(Df<9999);
        
        if mod(length(Df),2)
            Df=[Df;10000]; 
        end
        for dd=1:length(Df)/2
      IRMat(bb,Df(2*dd-1)+1:Df(2*dd))=1;
        end
          if ~isempty(tL{bb})
          lastIR(bb)=abs(min(tL{bb}));
          if tL{bb}(end)>0
             lastIR(bb)=TD;
          end
                    else
   lastIR(bb)=nan;   
          end
          
end
    lastIR(lastIR==0)=TD;  
    %plot last IR signal in CR trials
clear Me
        AlllastIRCR=nanmedian(lastIR(score==3));
       
    IRMat2=IRMat(:,1:TD);
    targeT=[score==0];
    nontargeT=[score==3];
    Tm=nanmean(IRMat2(targeT,:));
        Ts=nanstd(IRMat2(targeT,:));
    Nm=nanmean(IRMat2(nontargeT,:));
    Ns=nanstd(IRMat2(nontargeT,:));
   IRTm=Tm;
   IRNm=Nm;
     for nn=1:size(IRMat2,2)
    [emp,pvals(nn)]=ttest2(IRMat2(targeT,nn),IRMat2(nontargeT,nn),'Tail','right');
end
%plot(pvals,'k')
%DT=200+find(pvals(201:end-3)<thresh&pvals(202:end-2)<thresh&pvals(203:end-1)<thresh&pvals(204:end)<thresh,1,'first');
DT=find(pvals(1:end-3)<thresh&pvals(2:end-2)<thresh&pvals(3:end-1)<thresh&pvals(4:end)<thresh,1,'first');

% figure
% hold all
% shadedErrorBar(1:length(Tm),smooth(Tm,1),Ts./sqrt(sum(targeT)),{'Color','k','MarkerFaceColor','k','linestyle','-'},1)
%        shadedErrorBar(1:length(Nm),smooth(Nm,1),Ns./sqrt(sum(nontargeT)),{'Color','k','MarkerFaceColor','k','linestyle',':'},1)
% % shadedErrorBar(1:length(Tm),smooth(Tm,1),Ts./1,{'Color','k','MarkerFaceColor','k','linestyle','-'},1)
% %         shadedErrorBar(1:length(Nm),smooth(Nm,1),Ns./1,{'Color','k','MarkerFaceColor','k','linestyle',':'},1)
% 
%         %xlim([0 4000])
%      ylim([0 1])
 if ~isempty(DT)
% plot(DT,0,'*','color','k','markersize',12)
 else
     DT=nan;
 end
% plot(AlllastIRCR,0,'*','color','m','markersize',12)

       
       
%  Licks       
clear IRtime
clear IRtimeTemp

IRtime=cur_t.Lick(chosen_trials);
LickMat=zeros(size(IRtime,1),10000);

for bb=1:size(IRtime,1)
                LickMat(bb,IRtime{bb}(find(IRtime{bb}>0)))=1;
                if sum(abs(IRtime{bb}))>0 && sum(IRtime{bb})~=-1&& sum(IRtime{bb}>0)>0
                firstlick(bb)=IRtime{bb}(find(IRtime{bb}>0,1,'first'));
               lastlick(bb)= IRtime{bb}(find(IRtime{bb}>0,1,'last'));
                else
                 firstlick(bb)=nan;
               lastlick(bb)= nan;   
                end
    end
    LickMat2=LickMat(:,1:TD);
        clear lickDS
                clear lickDS2

    for tt=1:size(LickMat2,1)
        templick=LickMat2(tt,:);
                lickDS(tt,:)=smooth(double(sum(reshape(templick,20,[]))>0),3);

    end
    
    
    Tm=nanmean(lickDS(targeT,:)).*1;
        Ts=nanstd(lickDS(targeT,:));
    Nm=nanmean(lickDS(nontargeT,:)).*1;
    Ns=nanstd(lickDS(nontargeT,:));
    
    Tm1=Tm./max([Tm Nm]);
    Nm1=Nm./max([Tm Nm]);
FirstlickHit=nanmean(firstlick(targeT));
 LastlickCR=nanmean(lastlick(score==3));

%%
% figure
% hold all
% %shadedErrorBar(1:20:length(Tm)*20,Tm./max(Tm),Ts./sqrt(length(find(score==0))),{'Color','m','MarkerFaceColor','m'},1)
%         %shadedErrorBar(1:20:length(Nm)*20,Nm./max(Nm),Ns./sqrt(length(find(score==3))),{'Color','g','MarkerFaceColor','g'},1)
% %  shadedErrorBar(1:20:length(Tm)*20,Tm./max(Tm),Ts./1,{'Color','m','MarkerFaceColor','m'},1)
% %          shadedErrorBar(1:20:length(Nm)*20,Nm./max(Nm),Ns./1,{'Color','g','MarkerFaceColor','g'},1)
% 
%          shadedErrorBar(1:20:length(Tm)*20,smooth(Tm1,1),Ts./1,{'Color','k','MarkerFaceColor','k','linestyle','-'},1)
%          shadedErrorBar(1:20:length(Nm)*20,smooth(Nm1,1),Ns./1,{'Color','k','MarkerFaceColor','k','linestyle',':'},1)
% ylim([0 1])
%          
%         %  plot(1:length(Tm)*1,smooth(Tm,101)./max(smooth(Tm,101)),'linestyle','-','linewidth',2,'color','k')
% %         plot(1:length(Nm)*1,smooth(Nm,101)./max(smooth(Nm,101)),'linestyle',':','linewidth',2,'color','k')
     clear pvals
     thresh=0.001;
     for nn=1:size(lickDS,2)
    [emp pvals(nn)]=ttest2(lickDS(targeT,nn),lickDS(nontargeT,nn),'Tail','right');
    %[emp pvals(nn)]=kstest2(lickDS(score==3,nn),lickDS(score==0,nn),'Tail','larger');
     end
%plot(pvals,'k')
clear LT
%LT=30+find(pvals(31:end-33)<thresh&pvals(32:end-32)<thresh&pvals(33:end-31)<thresh&pvals(41:end-23)<thresh&pvals(51:end-13)<thresh&pvals(61:end-3)<thresh,1,'first');
LT=10+find(pvals(11:end-33)<thresh&pvals(12:end-32)<thresh&pvals(13:end-31)<thresh&pvals(21:end-23)<thresh&pvals(31:end-13)<thresh&pvals(41:end-3)<thresh,1,'first');
%LT=find(pvals(1:end-33)<thresh&pvals(2:end-32)<thresh&pvals(3:end-31)<thresh&pvals(11:end-23)<thresh,1,'first');

LT=LT*20;
%LT=600+find(pvals(601:end)<thresh,1,'first');

if isempty(LT)
    LT=nan;
end
%plot(LT,0.01,'o','color','k','markersize',12)
%plot(FirstlickHit,0,'o','color','m','markersize',12)
%plot(LastlickCR,0,'o','color','g','markersize',12)
LickTm=Tm;
LickNm=Nm;

%set(gca,'Xtick',[],'Ytick',[])
