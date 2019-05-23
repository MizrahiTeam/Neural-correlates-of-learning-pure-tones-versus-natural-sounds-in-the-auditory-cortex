function plotFRA(fra)

imagesc(fra)
set(gca,'YTick',[],'YDir','reverse',...
    'XTick',[])
   %colorbar('peer',axes1);