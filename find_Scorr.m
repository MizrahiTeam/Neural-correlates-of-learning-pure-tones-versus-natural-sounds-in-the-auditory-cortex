%%
function [AllCorrelations, AllCorrelations2]=find_Scorr(T,xGroup,Corrtype)
%groupsS=unique(T.group);
%for NE=1:2%length(groupsS) 
for NE=1:length(xGroup) 
allSigCorrFMatNPV=[];
allSigCorrFMatPV=[];
allSigCorrFMatNPVPV=[];
allSigCorrFMatmix=[];
allDistMatNPV=[];
allDistMatPV=[];
allDistCFNPV=[];
allDistMatmix=[];
CFdistNPV=[];
CFdistPV=[];
        allDistCFPV=[];
allSigCorrRndNPV=[];
        allSigCorrRndPV=[];
        allSigCorrRndmix=[];
mousetagNPV=[];
mousetagPV=[];
temp=T(T.group==xGroup(NE),:);
miceS=unique(temp.mouse);
for nn=1:length(miceS)%# of mice
    temp2=temp(temp.mouse==miceS(nn),:);
        panit=unique(temp.panitration(temp.mouse==miceS(nn)));
for nnn=1:length(panit)
    temp3=temp2(temp2.panitration==panit(nnn),:);
if Corrtype==1    
[Allcorrelation,samemiceCAll,diffmiceCAll,FRAmice,coeff,coeff_prm]=pearsonCor(temp2.FRA(temp2.panitration==panit(nnn)));
else
gfds=cell2mat(temp2.PSTH(temp2.panitration==panit(nnn)));
window=101:200;
%To work with PSTH of natural calls
if nargin>3
  gfds=cell2mat(temp2.PSTH{Wstim}(temp2.panitration==panit(nnn)));
  window=Wwindow;
end
temp4=gfds(:,window);
temp4=temp4./repmat(max(temp4,[],2),1,length(window));
[Allcorrelation,samemiceCAll,diffmiceCAll,FRAmice,coeff,coeff_prm]=pearsonCor(mat2cell(temp4,[ones(size(temp4,1),1)],length(window)));
end


pvind=temp3.cellType(:,1)=='F';
nonpvind=temp3.cellType(:,1)=='R';

if Corrtype==3

z=temp3.FF_cf;
clear CFdis2meanPV
clear CFdis2meanNPV
for hh=1:length(z)
    for rr=1:length(z)
%coeff(hh,rr)=log2(max([z(hh) z(rr)]) /min([z(hh) z(rr)]));%octave distance
coeff(hh,rr)=nanmean([z(hh) z(rr)]);%octave distance

end
zp=nanmean(z);
znp=nanmean(z);
%to calculate mean to each population seperatlly:

CFdis2meanPV(hh)=log2(max([z(hh) zp]) /min([z(hh) zp]));%octave distance
CFdis2meanNPV(hh)=log2(max([z(hh) znp]) /min([z(hh) znp]));%octave distance

end
CFdis2meanPV(nonpvind)=[];
CFdis2meanNPV(pvind)=[];

CFdistNPV=[CFdistNPV CFdis2meanNPV];
        CFdistPV=[CFdistPV CFdis2meanPV];
end

%PV-PV
FRAsCorr_PVtemp=triu(coeff(pvind,pvind)+0.0001,1);
FRAsCorr_PV=FRAsCorr_PVtemp(find(FRAsCorr_PVtemp~=0));
RandCorrtemp=triu(coeff_prm(pvind,pvind)+0.0001,1);
FRAsCorrR_PV=RandCorrtemp(find(RandCorrtemp~=0));
%nPV-nPV
FRAsCorr_nonPVtemp=triu(coeff(nonpvind,nonpvind)+0.0001,1);
FRAsCorr_nonPV=FRAsCorr_nonPVtemp(find(FRAsCorr_nonPVtemp~=0));
RandCorrtemp=triu(coeff_prm(nonpvind,nonpvind)+0.0001,1);
FRAsCorrR_nonPV=RandCorrtemp(find(RandCorrtemp~=0));

       allSigCorrFMatNPV=[allSigCorrFMatNPV;FRAsCorr_nonPV];
        allSigCorrFMatPV=[allSigCorrFMatPV;FRAsCorr_PV];
        
        allSigCorrRndNPV=[allSigCorrRndNPV;FRAsCorrR_nonPV];
        allSigCorrRndPV=[allSigCorrRndPV;FRAsCorrR_PV];

%PV-nPV
FRAsCorr_PVNPVtemp=triu(coeff(pvind,nonpvind)+0.0001,1);
FRAsCorr_PVNPV=FRAsCorr_PVNPVtemp(find(FRAsCorr_PVNPVtemp~=0));
if size(FRAsCorr_PVNPV,2)>1
FRAsCorr_PVNPV=FRAsCorr_PVNPV';
end
       allSigCorrFMatNPVPV=[allSigCorrFMatNPVPV;FRAsCorr_PVNPV];


end
end
AllCorrelations{NE}=allSigCorrFMatNPV;
AllCorrelations{NE+2}=allSigCorrFMatPV;
AllCorrelations3{NE}=allSigCorrFMatNPVPV;
if Corrtype==3
AllCorrelations2{NE}=CFdistNPV;
AllCorrelations2{NE+2}=CFdistPV;
end
end


end

