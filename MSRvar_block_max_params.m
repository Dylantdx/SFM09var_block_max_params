% ---------------------------------------------------------------------
% Book:         
% ---------------------------------------------------------------------
% Quantlet:     MSRvar_block_max_params
% ---------------------------------------------------------------------
% Description:  MSRvar_block_max_params provides parameters estimated 
%               for calculating Value-at-Risk with Block Maxima Model.
% ---------------------------------------------------------------------
% Usage:        MSRvar_block_max_params
% ---------------------------------------------------------------------
% Inputs:       k - shape parameter
%               a - scale parameter
%               b - location parameter
% ---------------------------------------------------------------------
% Output:       Parameters estimated for calculating Value-at-Risk with 
%               Block Maxima Model.
% ---------------------------------------------------------------------
% Example:     
% ---------------------------------------------------------------------
% Time:         July.2016
% ---------------------------------------------------------------------

function MSRvar_block_max_params
clc;
close all;
k=load('kappa_bMax_Portf.txt','-ascii');
a=load('alpha_bMax_Portf.txt','-ascii');
b=load('beta_bMax_Portf.txt','-ascii');
%^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^PLOTS
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