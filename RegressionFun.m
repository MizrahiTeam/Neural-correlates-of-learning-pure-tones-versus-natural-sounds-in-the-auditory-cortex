function RegressionIdo(x1,y1)

plot(x1,y1,'ok') 
mdl = LinearModel.fit(x1,y1)
temp1=table2array(mdl.Coefficients(2,4));
temp2=table2array(mdl.Coefficients(2,1));
temp3=mdl.Rsquared.Adjusted;
title(['m=' num2str(temp2) ' pval=' num2str(temp1) ' R^2=' num2str(temp3)])
hold on
plot(x1,mdl.Fitted,'k')
set(gcf,'color',[1 1 1])
set(gca,'box','off')