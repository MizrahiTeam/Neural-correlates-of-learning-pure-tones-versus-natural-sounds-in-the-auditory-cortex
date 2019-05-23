function dprime=dprimeRespons(stim1,stim2)
%stim1,stim2 are vactor with evoked spike counts for different trials
mu1=nanmean(stim1);
mu2=nanmean(stim2);
sigma1=nanvar(stim1);
sigma2=nanvar(stim2);
dprime=abs(mu1-mu2)/sqrt(0.5*(sigma1+sigma2));
