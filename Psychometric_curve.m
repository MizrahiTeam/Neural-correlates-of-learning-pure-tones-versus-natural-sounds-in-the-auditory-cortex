function TR=Psychometric_curve(Level,score,index_selected_level,PlayedFreqs,n,TR)
allL=unique(Level);
%levelsLC=allL(index_selected_level);

% if ~isnan(find(PlayedFreqs==0));
% zeroInd=find(PlayedFreqs==0);
% Level(zeroInd)=[];
% score(zeroInd)=[];
% PlayedFreqs(zeroInd)=[];
% end

clear LCsInd_temp
clear LCFreqs
for ll=1:length(allL)
    LCsInd_temp=find(Level==allL(ll));
             LCFreqs=PlayedFreqs(LCsInd_temp(1:end));
             gos=score(LCsInd_temp(1:end));
gos(gos==5)=2;
gos(gos==6)=0;
gos(gos==3)=2;
gos(gos==1)=0;
 UniqueF=unique(LCFreqs);
[a b]=sort(LCFreqs);
difTone=[find(a(2:end)~=a(1:end-1))+1;a(end)];
binings=ones(1,length(b));
for bb=1:length(difTone)-1
    binings(difTone(bb):end)=binings(difTone(bb):end)+1;
end
binings=binings';
SOrtScore=gos(b);
[hit, miss,fa,cr,tr,ntr,newcorrect,correct]=find_ratios4(binings,SOrtScore); 

  TR{ll}(n,:)=tr;   
end