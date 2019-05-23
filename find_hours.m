function [hours hour_diflevel]=find_hours(indexmat,dif_level,dif_day)
hours=indexmat(:,9);
for h=1:length(dif_day)
hours(dif_day(h)+1:end)=hours(dif_day(h)+1:end)+24;%moving to 24 Hr vectors
end
hours=hours-hours(1)+1;%making first hour to be 1
dif_hour=find(hours(2:end)~=hours(1:end-1));

temp=find(hours./24==floor(hours./24));
days24=[1;temp([find(diff(temp)>1)])+1];%trial index when start new 24 hours
%creating hours vector
    hours=ones(length(indexmat),1);
for h=1:length(dif_hour)
hours(dif_hour(h)+1:end)=hours(dif_hour(h)+1:end)+1;
end
  jump=(indexmat(2:end,9)-indexmat(1:end-1,9));
jumpind=find(abs(jump)>1);
jumpsize=jump(jumpind);
for jj=1:length(jumpind)
    hours(jumpind(jj)+1:end)=hours(jumpind(jj)+1:end)+jumpsize(jj)-1;
end
%  if n==8 %correction for '0006E2484E.mos' (not active for the first 24 h
%         hours(2:end)=hours(2:end)+24;
%  end
hour_diflevel=hours(dif_level);

temp=find(hours./24==floor(hours./24));
days24=[1;temp([find(diff(temp)>1)])+1];%trial index when start new 24 hours

end