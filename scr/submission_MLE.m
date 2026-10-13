%% Violin Fingerboard Spacing Analysis
% This script estimates the fingerboard spacing parameters:
%
% log(L_n) = (-1/b log a) n + log(L_0)
%
% where W(1) = -1/b log a, and W(2) = log(L_0)
%
% Inputs:
%   data.mat - experimental measurements
%
% Outputs:
%   MLE_Average.png - fingerboard spacing profile with estimated
%   parameters
%
% Description:
%   Comparison of the three fingerboard spacing
%   profiles using the MLE approach: the average measured string
%   lengths at individual semitone positions (blue), the fitted
%   string-length profile derived from parameter estimation (green),
%   and theoretical string-length profile predicted by the 12-TET
%   scale (red).

clear; close all; clc;
addpath(genpath('..'));
load("data1.mat","data");
%load("data2.mat","data");

y=log10(mean(data(2:end,:), 2));

N=size(y,1);
n=1:N;
x = [n; ones(1, N)];

alpha = [1:N]*y;
beta = sum(y);
gamma = 12/(N^2*(N^2-1));
A = N*(N+1)*(2*N+1)/6;
B = -N*(N+1)/2;
W = gamma * [alpha*N+beta*B; alpha*B+beta*A];

fprintf('faster impleme: Estimated L0: %.4f \t Estimated -1/b * log(a): %.4f \n', [10^W(2), W(1)]);

figure;
hold on;
plot(n, mean(data(2:end, :),2),'bo--', 'MarkerSize',4);
plot(n, 10.^(W'*x), 'g--*', 'MarkerSize',2);
plot(n, mean(data(1,:),2)*2.^(-n/12),'rs--', 'MarkerSize',4);
h=legend('Averaged measurement data', 'Data fitting result with measured data', 'Equal temperament system', 'FontSize', 8);
xlabel('$n$', 'Interpreter', 'latex');
ylabel('$L_n$', 'Interpreter', 'latex');

exportgraphics(gcf, sprintf('MLE_%s.png', 'Average'), 'Resolution', 500);
