%% Violin Fingerboard Spacing Analysis
% This script estimates the fingerboard spacing parameters using the
% matlab built-in function fminsearch():
%
% L_n = L_0 a^{-n/b}
%
% where W(1) = -1/b log a, and W(2) = log(L_0)
%
% Inputs:
%   User-provided initial guess of the parameters [a b]
%
% Outputs:
%   L_average_fminsearch.png.png - fingerboard spacing profile
%   with estimated parameters
%
% Description:
%   Comparison of three fingerboard spacing profiles as a function
%   of semitone position index n using the fminsearch optimization
%   method: the average measured string lengths at individual semitone
%   positions (blue), the fitted string-length profile derived from
%   parameter estimation (green), and the theoretical string-length
%   profile predicted by the 12-TET scale (red).

clc; clear; close all;

addpath(genpath('..')); 

% Objective function
objFun = @submission_Ln;

% Initial guess [x, y]
w = input('Enter two initial guess numbers as [a b]: ');
if isempty(w)
    w = [1.9, 11.9];
end

% Optimization options
options = optimset(Display="iter",PlotFcns=@optimplotfval, TolFun=1.0e-06, TolX=1.0e-06);

[w, fval, exitflag, output] = fminsearch(objFun, w, options);

% Extract results
fprintf('Optimal w = %.4f, %.4f\t MinVal = %.4f\n', w(1), w(2), fval);

load("data1.mat","data");
%load("data2.mat","data");

[N, M] = size(data);
n=0:(N-1);

avgData = mean(data, 2);
plot(avgData,'b--*', 'MarkerSize',2);
hold on;
plot(data(1).*w(1).^(-n./w(2)), 'g--*', 'MarkerSize',2);
plot(data(1).*2.^(-n./12), 'r--*', 'MarkerSize',2);
legend('Average measure','Exponential model fitting result','Equal-tempered system');
xlabel('$n$', 'Interpreter', 'latex');
ylabel('$L_n$', 'Interpreter', 'latex');
exportgraphics(gcf, 'L_average_fminsearch.png', 'Resolution', 500);
