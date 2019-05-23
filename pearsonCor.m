%calculate pearson correlation
%take cells of fra and array of mice names (must be the same length0
function [Allcorrelation,samemiceCAll,diffmiceCAll,FRAmice,coeff,coeff_prm]=pearsonCor(FRAs,Names)
clear coeff

for i=1:length(FRAs)
    for t=1:length(FRAs)
    if size(FRAs{i},2)==size(FRAs{t},2)
C = cov(FRAs{i},FRAs{t});
coeff(i,t) = C(1,2) / sqrt(C(1,1) * C(2,2));

FRa1=FRAs{i}(:);
FRa2=FRAs{t}(:);
FRa1Perm=FRa1(randperm(length(FRa1)));
FRa2Perm=FRa2(randperm(length(FRa2)));
 Cp = cov(FRa1Perm,FRa2Perm);
coeff_prm(i,t) = Cp(1,2) / sqrt(Cp(1,1) * Cp(2,2));
    else
        coeff(i,t) = nan;
        coeff_prm(i,t)= nan;
    end
    end
end


clear Utemp
   
    U = triu(coeff,1);
    Allcorrelation=U(find(U~=0));
     
% sort corelations by mice
if nargin<2
    Names = ones(1,length(FRAs));
end
difmice_names=unique(Names);
diffmiceCAll=[];
samemiceCAll=[];
clear samemiceC
clear diffmiceC
for ll=1:length(difmice_names)
    mouseinds=find(Names==difmice_names(ll));
        mouseinds_no=find(Names>difmice_names(ll));
U=triu(coeff(mouseinds,mouseinds),1);
samemiceC{ll}=U(find(U~=0));
samemiceCAll=[samemiceCAll;samemiceC{ll}]; 
U=reshape(coeff(mouseinds,mouseinds_no),1,[]);
diffmiceC{ll}=U;
diffmiceCAll=[diffmiceCAll diffmiceC{ll}];
FRAmice{ll}=FRAs(mouseinds);
end
end


