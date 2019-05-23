function [fra,responsivness_test,BF,CF,response_mag_BF,response_mag_allevoked,temp_mindB_level,response_mag_CF1,response_mag_CF2,response_mag_BFn,spikeinwindow,spikesin_repetiation,PSTH_CF_1att,respondW,fraW,NormfraW,FRA1,FRA2,spont_rate,fra3D,FF,winS,responsivness_test2,p]= findFRA(SortedRP,freq_num,att_num,rep,ISI,window,freqs,n,pl,plotcell)
psth=sum(SortedRP);
for tt=1:100;
    ss(tt)=sum(psth(100+tt:159+tt));
end
[l w_ind]=max(ss);
win=100+w_ind:159+w_ind;
%win=101:200;
win2=ISI+1:ISI+60;
winS=win(1);
if window==2
[width,tlead,ttrail] = fwhm(1:length(smooth(psth(101:400),11)),smooth(psth(101:400),11));
%[width,tlead,ttrail] = fwhm(1:length(new_psth),new_psth);

win=[round(tlead)+100:round(ttrail)+100];
% if n==7&& pl==3
%      win=133:143;
%  end
win2=1:length(win);
 
end

win_spont=[1:100];
spont_rate=mean(sum(SortedRP(:,win_spont),2)*10);
[h,p]=ttest(sum(SortedRP(:,win),2),sum(SortedRP(:,win2),2));


%FRA
if rep>12
    NewSortedRP=[];
    for rr= 1:freq_num*att_num
            SortedRPtemp=SortedRP((rr*rep-(rep-1)):rr*rep,:);
NewSortedRP=[NewSortedRP;SortedRPtemp(1:12,:)];
    end
        rep=12;
SortedRP=NewSortedRP;
end

respond=[];
FR_rep=[];
fra3D=[];
for rr= 1:freq_num*att_num
respond(rr)=(mean(sum(SortedRP((rr*rep-(rep-1)):rr*rep,win),2))/length(win))*1000; % normalize to Hz

spikeinwindow(rr,:)=sum(SortedRP((rr*rep-(rep-1)):rr*rep,win),2);
spikeoutwindow(rr,:)=sum(SortedRP((rr*rep-(rep-1)):rr*rep,win2),2);
FR_rep(rr,:)=(sum(SortedRP((rr*rep-(rep-1)):rr*rep,win),2)./length(win))*1000;

%[ pstimuli(rr) isrespond(rr)]=ranksum(spikeinwindow(rr,:),spikeoutwindow(rr,:));
[ pstimuli(rr) isrespond(rr)]=signrank(spikeinwindow(rr,:),spikeoutwindow(rr,:));

spikesin_repetiation(rr,:)=sum(SortedRP((rr*rep-(rep-1)):rr*rep,win),2);

respond1(rr)=(mean(sum(SortedRP((rr*rep-(rep-1)):rr*rep-rep/2,win),2))/length(win))*1000; % 1st hlf of trials
respond2(rr)=(mean(sum(SortedRP((rr*rep-(rep/2-1)):rr*rep,win),2))/length(win))*1000; % 2nd half of trials

end
isrespond=zeros(1,length(pstimuli));
isrespond(pstimuli<0.05/1)=1;
responsivness_test=reshape(isrespond,att_num,freq_num);
pstimuli(isnan(pstimuli))=1;
responsivness_test2=reshape(pstimuli,att_num,freq_num);

respond(respond<spont_rate)=spont_rate;
fra=reshape(respond,att_num,freq_num)-spont_rate;
if plotcell==1
cellfigures2(SortedRP,fra,rep,att_num,freq_num,ISI,win)

end
fra_noMinusSpont=reshape(respond,att_num,freq_num);
for rrr=1:rep
fra3D(:,:,rrr)=reshape(FR_rep(:,rrr),att_num,freq_num);
end
varFRA=nanvar(fra3D,[],3);
meanFRA=nanmean(fra3D,3);
FF=nanmean(nanmean(varFRA./(meanFRA.^2)));
FRA1=reshape(smooth(respond1,1),att_num,freq_num)./max(respond1);
FRA2=reshape(smooth(respond2,1),att_num,freq_num)./max(respond2);

%finding BF and CF 
[max_res,max_res_ind]=max(sum(fra,1));
CF=freqs(max_res_ind);%colapse on all levels
[response_mag_BF,max_resa_ind]=max(max(fra));
[response_mag_BFn,max_resa_indn]=max(max(fra_noMinusSpont));

BF=freqs(max_resa_ind);
response_mag_allevoked=nanmean(respond(isrespond==1));
temp_mindB_level=nansum(responsivness_test,2);
response_mag_CF1=fra(1,max_res_ind);
response_mag_CF2=fra(2,max_res_ind);

PSTH_CF_1att=SortedRP((max_resa_ind-1)*att_num*rep+1:(max_resa_ind-1)*att_num*rep+rep,:);
Wins={[61:80],[81:100],[101:120],[121:140],[141:160],[161:180],[181:200],[201:220],[221:240],[241:260],[261:280],[281:300],[301:320],[321:340]};

%Wins={[101:140],[141:180],[181:220],[221:260],[261:300]};
%Wins={[111:170],[171:230],[231:290]};

for ww=1:length(Wins)
for rr= 1:freq_num*att_num
respondW{ww}(rr)=(mean(sum(SortedRP((rr*rep-(rep-1)):rr*rep,Wins{ww}),2))/length(Wins{ww}))*1000; % normalize to Hz
end
fraW(:,:,ww)=reshape(respondW{ww},att_num,freq_num);%-spont_rate;
NormfraW(:,:,ww)=fraW(:,:,ww)./max(max(fraW(:,:,ww)));
end

