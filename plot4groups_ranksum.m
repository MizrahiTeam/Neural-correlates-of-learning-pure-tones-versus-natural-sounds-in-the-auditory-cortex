%this script takes 1Xn cell array of n groups (NRS NFS ERS EFS) and plot
%all vars + means+results of  wilkinson test
function [Me,Std,Sizes,Medi]=plot4groups_ranksum(values,Test)
%presenting data for poster

%edgecol={'w','w','w','w'};
FaceCol={'none','none','none','none','none','none'};
%edgecol={[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734]};
edgecol={[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734]};

%edgecol={[1 0.400000005960464 0.200000002980232],[1 0.400000005960464 0.200000002980232],[1 0.400000005960464 0.200000002980232]};

markers={'^','o','^','o','^','o','^','o'}
%markers={'^','^','o','o','^','o'};

for n=1:length(values)  
Me(n)=nanmean(values{n});
Std(n)=nanstd(values{n});
Medi(n)=nanmedian(values{n});
Sizes(n)=length(values{n});

hold all
plot((n/2)*ones(1,length(values{n}))-(rand(1,length(values{n}))-0.5)./4,values{n},'Marker',markers{n},'MarkerEdgeColor',edgecol{n},'MarkerFaceColor',FaceCol{n},'linestyle','none','markersize',6)
plot([n/2-1/6 n/2+1/6],[Me(n) Me(n)],'color','k','LineWidth',2)

end
xlim([0.0 5])
%ylim([3000 40000])
set(gca,'box','off','Xtick',[],'color','none','fontsize',10)
%set(gca,'yscale','log')

A=squeeze(values{1});
     B=squeeze(values{2});
        if Test==1
 p_RS=ranksum(A(~isnan(A)),B(~isnan(B)))
        else
              [garb,p_RS]=ttest2(A(~isnan(A)),B(~isnan(B)),0.05)
        end
sizeA=size(A(~isnan(A)),2);sizeB=size(B(~isnan(B)),2);
p_FS=[];
p_N=[];
p_E=[];
if length(values)>2
C=squeeze(values{3});
if Test==1
p_N=ranksum(A(~isnan(A)),C(~isnan(C)))
else
              [garb,p_N]=ttest2(A(~isnan(A)),C(~isnan(C)));%,0.05,'right');
end
if Test==1
p_E=ranksum(B(~isnan(B)),C(~isnan(C)))
else
              [garb,p_E]=ttest2(B(~isnan(B)),C(~isnan(C)));%,0.05,'left');
end
if length(values)>3
     D=squeeze(values{4});
     if Test==1
       p_FS=ranksum(C(~isnan(C)),D(~isnan(D)))
     else
              [garb,p_FS]=ttest2(C(~isnan(C)),D(~isnan(D)))%,0.05,'left');
     end
              sizeC=size(C(~isnan(C)),2);sizeD=size(D(~isnan(D)),2);
if Test==1
              p_E=ranksum(B(~isnan(B)),D(~isnan(D)))
else
                  [garb,p_E]=ttest2(B(~isnan(B)),D(~isnan(D)));%,0.05,'right');

end
if length(values)>4
     E=squeeze(values{5});
          F=squeeze(values{6});

     if Test==1
       p_FS=ranksum(E(~isnan(E)),F(~isnan(F)))
     else
              [garb,p_FS]=ttest2(e(~isnan(E)),F(~isnan(F)))%,0.05,'left');
     end
              sizeE=size(E(~isnan(E)),2);sizeF=size(F(~isnan(F)),2);

end

end

end
text(4,Me(n),{['RS P=' num2str(p_RS)],['FS P=' num2str(p_FS)],['N P=' num2str(p_N)],['E P=' num2str(p_E)]},'fontsize',12)

%saveas(gcf,[folname titles{p}],'fig') 
end