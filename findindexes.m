function [indexmat] = findindexes(textdata,data)

lastCol = char(textdata(:,6));

Hit= repmat('HI',size(lastCol,1),1);
Miss= repmat('MI',size(lastCol,1),1);
Correct_Reject= repmat('CR',size(lastCol,1),1);
False_Alarm= repmat('FA',size(lastCol,1),1);
Pre_Lick= repmat('PL',size(lastCol,1),1);
Not_Blocking= repmat('NB',size(lastCol,1),1);


Hitindexes = all(lastCol==Hit,2);
Missindexes = all(lastCol==Miss,2);
CRindexes = all(lastCol==Correct_Reject,2);
FAindexes = all(lastCol==False_Alarm,2);
PLindexes = all(lastCol==Pre_Lick,2);
NBindexes = all(lastCol==Not_Blocking,2);
level=str2num(char(textdata(:,2)));

fileindexmat=[Hitindexes Missindexes CRindexes FAindexes PLindexes NBindexes level];


%licks=licksdata(:,19);
%nolick=repmat(' ',size(licksdata,1),1);
%licksindexes = all(licks~=nolick,2);

time_file = char(textdata(:,1));
days=str2num(time_file(:,10:11));

difday=find(days(2:end)~=days(1:end-1));
    day=ones(length(days),1);
for d=1:length(difday)
day(difday(d)+1:end)=day(difday(d)+1:end)+1;
end

hour=str2num(time_file(:,1:2));
nb_latency=data(:,4);
stim_freq1=str2num(char(textdata(:,4)));
stim_freq2=str2num(char(textdata(:,5)));
retract_t=data(:,4);
retract_t(retract_t==0)=2000;%replacing 0 with 2000 for not stop bolocking trials
 indexmat=[day fileindexmat hour nb_latency stim_freq1 stim_freq2 retract_t];%[days H M CR FA PL NB level hour nb_latency stim_freq1 stim_freq2 retract_t]
 
 

%str2num(level);

%upgrade=find(textdata(start:end-1,2)~=indexmat(start+1:end,2));
end