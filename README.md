# SFM09var_block_max_params
[<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/banner.png" alt="Visit QuantNet">](http://quantlet.de/index.php?p=info)

## [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/qloqo.png" alt="Visit QuantNet">](http://quantlet.de/) **SFSvar_block_max_params** [<img src="https://github.com/QuantLet/Styleguide-and-Validation-procedure/blob/master/pictures/QN2.png" width="60" alt="Visit QuantNet 2.0">](http://quantlet.de/d3/ia)

```yaml

Name of QuantLet : SFM09var_block_max_params

Published in : Statistics of Financial Markets 

Description : 'Provides and plots shape, scale and location parameters estimated for calculating Value-at-Risk with Block Maxima Model.'

Keywords : VaR, block-maxima, data visualization, estimation, forecast, graphical representation, parameter, plot, portfolio, scale

Author : Chen Yingping ,Deng Ziwen ,Zhang Huijie ,Zhang Yifan.

Submitted : Mon, July 18 2016 by Chen Yingping

Datafiles: BAY_close.txt, BMW_close.txt, SIE_close.txt, alpha_bMax_Portf.txt, beta_bMax_Portf.txt, kappa_bMax_Portf.txt

Example: 'Parameters estimated in Block Maxima Model for portfolio: Bayer, BMW, Siemens.Time period: from 2000-01-18 to 2016-06-28.'

```

![Picture1](Parameters_in_Block_Maxima_Model.png)


```

# MATLAB code
```matlab
# Estimate shape, scale and location parameters

clc;
close all;
a=load('BAY_close.txt','-ascii');
b=load('BMW_close.txt','-ascii');
c=load('SIE_close.txt','-ascii');
d=a+b+c;
x=d(2:end)-d(1:end-1);
x=-x;
T=length(x);
h=250;
p=0.95;
n=16;
for i=1:T-h
    y=x(i:i+h-1);
    [var(i),tau(i),alpha(i),beta(i),kappa(i)]=block_max(y,n,p);
end;
save ('VaR9906_bMax_Portf.txt','var','-ascii');
save ('tau_bMax_Portf.txt','tau','-ascii');
save ('alpha_bMax_Portf.txt','alpha','-ascii');
save ('beta_bMax_Portf.txt','beta','-ascii');
save ('kappa_bMax_Portf.txt','kappa','-ascii');

function [var,tau,alpha,beta,kappa]=block_max(y,n,p)
T=length(y);
k=floor(T/n);

for j=1:k-1
    r=y((j-1)*n+1:j*n);
    z(j)=max(r);
end;

r=y((k-1)*n+1:end);
z(k)=max(r);
mu=mean(z);
sigma=std(z);
warning off
parmhat = gevfit(z);
kappa=parmhat(1);
tau=-1/kappa;
alpha=parmhat(2);
beta=parmhat(3);
pext=p^n;
var=beta+alpha/kappa*((-log(1-pext))^(-kappa)-1);

# Plots of shape, scale and location parameters
function MSRvar_block_max_params
clc;
close all;
k=load('kappa_bMax_Portf.txt','-ascii');
a=load('alpha_bMax_Portf.txt','-ascii');
b=load('beta_bMax_Portf.txt','-ascii');

plot(k)
grid on
hold on
plot(a,'Color','red')
plot(b,'Color','m');
hold off
legend('Shape Parameter','Scale Parameter','Location Parameter')
title('Parameters in Block Maxima Model')
xlim([-3 3963])
set(gca,'XTick',[249 771 1294 1814 2337 2855 3366 3871]-250)
set(gca,'XTickLabel',{'Jan 2001' 'Jan 2003' 'Jan 2005' ...
   'Jan 2007' 'Jan 2009' 'Jan 2011' 'Jan 2013' 'Jan 2015'})

```
# R code
```r
# Close all plots and clear variables
graphics.off()
rm(list = ls(all = TRUE))

# Load data
k = t(read.table("kappa_bMax_Portf.txt"))
a = t(read.table("alpha_bMax_Portf.txt"))
b = t(read.table("beta_bMax_Portf.txt"))

# Plots of shape, scale and location parameters
plot(k, type = "l", col = "blue", ylim = c(-1, 10), ylab = c(""), xlab = c(""), axes = FALSE)
lines(a, col = "red")
lines(b, col = "magenta")
title("Parameters in Block Maxima Model")
box()
axis(1, c(250, 510, 771, 1032, 1294, 1554, 1814, 2075, 2337, 2598, 2855, 3112, 3366, 3619, 3871, 
    4099) - 250, c("2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", 
    "2011", "2012", "2013", "2014", "2015", "2016"))
axis(2)
legend("top", c("Shape Parameter", "Scale Parameter", "Location Parameter"), pch = c(15, 15, 
    15), col = c("blue", "red", "magenta"))
