function RasterPSTH(SortedRP,freq_num,att_num,rep,ISI,freqs)

sps_att=2;
 chooseInd=[];
    for nn=1:freq_num
               
    chooseInd=[chooseInd 1+(nn-1)*rep*att_num+(sps_att-1)*rep:(nn-1)*rep*att_num+(sps_att-1)*rep+rep];%2/3 att
    end    
       
        SortedRP=SortedRP(chooseInd,:);


%creating PSTH
  figure
  set(gcf,'color',[1 1 1])
subplot(4,5,[6:9 11:14 16:19])

ylim([0 size(SortedRP,1)+1]);
xlim([1 100+ISI]);

hold('all');

for j=1:size(SortedRP,1)
  
numSpikesForRow=length(find(SortedRP(j,:)));
spikeIndices=find(SortedRP(j,:));
for i=1:numSpikesForRow

    line([spikeIndices(i) spikeIndices(i)],[j-1 j+1],[1 1],'LineStyle','-','linewidth',3,'color','k')
end;
 end;
set(gca,  ...
    'YTick',rep*[7 10],'YTickLabel',{},...
    'XTickLabel',{'','','',''},...
    'XTick',[100 200 500 ISI+100],'FontSize',14,'box','off')

  psth=nanmean(SortedRP);
subplot(4,5,1:4)
%plot(new_psth,'linewidth',2);
plot(smooth(psth,11),'k','linewidth',2);

for tt=1:100;
    ss(tt)=sum(psth(100+tt:159+tt));
end
[l w_ind]=max(ss);
win=100+w_ind:159+w_ind;
win2=ISI+1:ISI+60;
set(gca,'FontSize',14,'box','off','XTick',[],'YColor',[1 1 1])
xlim([1 (100+ISI)]);

TC=mean(reshape(sum(SortedRP(:,win),2),rep,freq_num),1);
subplot(4,5,[10 15 20])
plot(smooth(TC,3),'k','linewidth',2);
view([90 -90])
set(gca,'FontSize',14,'box','off','XTick',[],'YColor',[1 1 1])
[h,p]=ttest(psth(win),psth(win2));
% if h==1
% Create textbox
[a b]=max(TC)
% annotation(gcf,'textbox',[0.7188 0.8409 0.09959 0.04545],...
%     'String',{['BF=' freqs(b)]},...
%     'FitBoxToText','off');
% end