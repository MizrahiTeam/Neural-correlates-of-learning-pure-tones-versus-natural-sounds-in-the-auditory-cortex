%-- Calculate d-prime-------------------------------------------
function [dPrime c_bias]=find_dprime(tr,ntr,binsize);
%correcting errors
for tt=1:length(tr)
if tr(tt)==1
    tr(tt)=1-1/binsize;
end
if ntr(tt)==0
    ntr(tt)=1/binsize;
end
if tr(tt)==0
    tr(tt)=1/binsize;
end
if ntr(tt)==1
    ntr(tt)=1-1/binsize;
end
end
%Normal inverse cumulative distribution function
zHit = norminv(tr) ;
zFA = norminv(ntr) ;
dPrime = zHit - zFA ;
c_bias = -(zHit + zFA)./2 ;

end
%The highest possible d' (greatest sensitivity) is 6.93, the effective
%limit (using .99 and .01) 4.65, typical values are up to 2.0, and 69
% correct for both different and same trials corresponds to a d' of 1.0
%JND is the value corresponding to d'<1
%Livia is starting with 1.8 