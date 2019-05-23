%this script takes 1Xn cell array of n groups (NRS NFS ERS EFS) and plot
%all vars + means+results of  wilkinson test
function [Me,Std,Sizes,Medi]=plot4groups_bars(values)
%presenting data for poster
figure1 = figure;

% Create axes
axes1 = axes('Parent',figure1,'XTick',zeros(1,0));
hold(axes1,'all');
hold all
edgecol={[0 .5 .5],[0 .5 .5],[0 .5 .5],[0 .5 .5]};
edgecol={[1 0.200000002980232 0.200000002980232],[0 0.447058826684952 0.74117648601532],[1 0.200000002980232 0.200000002980232],[0 0.447058826684952 0.74117648601532]};


%edgecol={[1 0.400000005960464 0.200000002980232],[0 .5 .5],[1 0.400000005960464 0.200000002980232],[0 .5 .5]};
%edgecol={[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734]};
%edgecol={[0 .5 .5],[0 .5 .5],[0 .5 .5],[0.749019622802734 0 0.749019622802734],[0.749019622802734 0 0.749019622802734],[0.749019622802734 0 0.749019622802734],[0 .5 .5],[0.749019622802734 0 0.749019622802734]};

%edgecol={'k','k','k','k'};

facecol=edgecol;
%facecol={[1 1 1],[0 .5 .5],[1 1 1],[0 .5 .5],[1 1 1],[1 1 1],[1 1 1],[1 1 1],[1 1 1],[1 1 1]};

markers={'o','o','o','o'}

for n=1:length(values)  
Me(n)=nanmean(values{n});
Std(n)=nanstd(values{n});
Medi(n)=nanmedian(values{n});
Sizes(n)=length(values{n});

bar(n,Me(n),...
    'FaceColor',facecol{n},...
    'edgeColor',edgecol{n},'LineWidth',1);
plot(n*ones(1,length(values{n}))-(rand(1,length(values{n}))-1.2)./16,values{n},'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','none','linestyle','none','markersize',8)

% Create errorbar
end
errorbar(1:length(values),Me,Std./sqrt(Sizes),'LineStyle','none','Color','k','LineWidth',2);

% set(gca,'yscale','log')
% ylim([3000 40000])
 


end