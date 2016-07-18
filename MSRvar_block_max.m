% ---------------------------------------------------------------------
% Book:         
% ---------------------------------------------------------------------
% Quantlet:     MSRvar_block_max
% ---------------------------------------------------------------------
% Description:  MSRvar_block_max computes Value-at-Risk with Block
%               Maxima Model.
% ---------------------------------------------------------------------
% Usage:        [var,tau,alpha,beta,kappa]=msr_var_block_max(x)
% ---------------------------------------------------------------------
% Inputs:       x - vector of returns
% ---------------------------------------------------------------------
% Output:       var - Value at Risk
%               tau = -1/kappa
%               alpha - the scale parameter
%               beta - the location parameter
%               kappa - the shape parameter
% ---------------------------------------------------------------------
% Example:     
% ---------------------------------------------------------------------
% Time:         July.2016
% ---------------------------------------------------------------------

function MSRvar_block_max
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