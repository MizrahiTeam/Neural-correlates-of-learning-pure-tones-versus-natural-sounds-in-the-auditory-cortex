%clock: finding 
function [clock,ITI,rmStr]=findclock(textdata)
time_file = char(textdata(:,1));
hour=str2num(time_file(:,1:2));
minuts=str2num(time_file(:,4:5));
sec=str2num(time_file(:,7:8));
day=str2num(time_file(:,10:11));
month=str2num(time_file(:,13:14));
year=str2num(time_file(:,16:17));
clock=[hour minuts sec day month year];
%ITI=(clock(2:end,1)-clock(1:end-1,1))*3600+(clock(2:end,2)-clock(1:end-1,2))*60+(clock(2:end,3)-clock(1:end-1,3)+(clock(2:end,4)-clock(1:end-1,4))+(clock(2:end,5)-clock(1:end-1,5))+(clock(2:end,6)-clock(1:end-1,6)));

ITI=(clock(2:end,1)-clock(1:end-1,1))*3600+(clock(2:end,2)-clock(1:end-1,2))*60+(clock(2:end,3)-clock(1:end-1,3));
ITI(ITI<0)=(clock(find(ITI<0)+1,1)+24-clock(find(ITI<0),1))*3600+(clock(find(ITI<0)+1,2)-clock(find(ITI<0),2))*60+(clock(find(ITI<0)+1,3)-clock(find(ITI<0),3));
for b=1:size(textdata,1)
rmStr(b)=isempty(textdata{b,1});
end
%EmptyStrInd=find(rmStr==1);


        