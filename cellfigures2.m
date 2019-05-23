function cellfigures2(SortedRP,fra,rep,att_num,freq_num,ISI,win)

figure
%FRA's of all cells

subplot(5,5,[4 5 9 10])
        imagesc(fra)
        set(gca,...
    'YDir','reverse',...
    'XTick',freq_num,'XTicklabel',num2str(freq_num),'box','off')

%Rasters

subplot(5,5,[11:13 16:18 21:23])

% for j=1:length(SortedRP)
%   
% numSpikesForRow=length(find(SortedRP(j,:)));
% spikeIndices=find(SortedRP(j,:));
% 
%   plot(spikeIndices,j*ones(1,numSpikesForRow),'k.','markersize',0.5)
%   hold all
%  end;
%    set(gca,'XTick',[100 200],'XTicklabel',{'0','100'},'box','off') 
% xlim([0 size(SortedRP,2)]);ylim([0 size(SortedRP,1)])
for j=1:size(SortedRP,1)
  
numSpikesForRow=length(find(SortedRP(j,:)));
spikeIndices=find(SortedRP(j,:));
for i=1:numSpikesForRow
  line([spikeIndices(i) spikeIndices(i)],[j-2 j+2],[1 1],'LineStyle','-','linewidth',6,'color','k')
end;
 end;
   set(gca,'YTick',zeros(1,0),...
    'XTick',[100 200],'XTicklabel',{0,100},'FontSize',20,'box','off') 
xlim([0 size(SortedRP,2)]);ylim([0 size(SortedRP,1)])

%
subplot(5,5,[1:3 6:8])
psthh=sum(SortedRP);
psth=sum(reshape(psthh,10,[]),1)./(10*size(SortedRP,1)*0.001);
         plot(smooth(psth,1),'k','linewidth',3)
         set(gca,... 
    'XTickLabel',{},...
    'box','off')
xlim([1 (100+ISI)/10])
% hold on
% plot(round(win/10),zeros(1,length(win)),'r.')
subplot(5,5,[14 19 24])
ps=sum(SortedRP(:,win),2);
         plot(smooth(ps,15),'k','linewidth',2)
         set(gca,... 
    'XTickLabel',{},...
    'XTick',[],'box','off','CameraUpVector',[1 0 0])
hold on
[d v]=max(ps);
plot(d,0,'r.')

%title(0.2,0.2,['Name=' name num2str(MiceNames) ' ' cellnum])
end