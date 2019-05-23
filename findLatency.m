%finding latency to psth peak
function [latency_S,latency_peak,peak_minus_Latency,psth_some,latency_end,end_minus_Latency,width,tlead,ttrail]=findLatency(psth,stdIncrease) 
psth=smooth(psth,1);
psth_some=psth;
[peak,peak_ind]=max(smooth(psth(101:200),3));
latency_peak=peak_ind; %latency to peak
   % latency_S=find(psth(101:299)>(nanmean(psth([1:100]))+stdIncrease*nanstd(psth([1:100])))& psth(102:300)>(nanmean(psth([1:100]))+stdIncrease*nanstd(psth([1:100]))),1,'first');
       Xm=nanmean(psth([1:100]));
Xs=nanstd(psth([1:100]));
    latency_St=psth(100:300)>(Xm+stdIncrease*Xs);
numBin=2;
for hg=1:length(latency_St)-numBin
 latency_Sd(hg)=nansum(latency_St(hg:hg-1+numBin));
end
latency_S=find(latency_Sd>=numBin,1,'first');

latency_Stemp=find(psth(101:299)>(mean(psth([1:100]))+stdIncrease*std(psth([1:100])))& psth(102:300)>(mean(psth([1:100]))+stdIncrease*std(psth([1:100]))));
latency_end=latency_Stemp(find(diff(latency_Stemp)>2,1,'first'));
   
        %Full-Width at Half-Maximum (FWHM) of the waveform y(x)
[width,tlead,ttrail] = fwhm(1:length(smooth(psth(101:400),7)),smooth(psth(101:400),7));
        
    %if isempty(latency_S)|| latency_S>60 || latency_peak>70 || latency_S<15 || latency_peak<20
        if isempty(latency_S) 
    latency_S=nan; 
         %latency_peak=nan;
           peak_minus_Latency=nan;
          psth_some=nan;
          latency_end=nan;
          end_minus_Latency=nan;
          width=nan;
    end
 peak_minus_Latency=latency_peak-latency_S;
        %latency_end=find(psth(101:299)>(mean(psth([1:100]))+stdIncrease*std(psth([1:100])))& psth(102:300)>(mean(psth([1:100]))+stdIncrease*std(psth([1:100]))),1,'last');
        end_minus_Latency=latency_end-latency_S;
        