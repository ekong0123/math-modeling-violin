function f = submission_Ln(w)
%% Violin Fingerboard Spacing Analysis
% This function evaluates the cost function:
% J(w(1), w(2)) = \sum_i \sum_j |L(i,j) - L_0(i)*w(1)^{-j/w(2)}|
%
% Inputs:
%   w - a parameter vector
%
% Outputs:
%   J(w(1), w(2)) -  the cost function used for parameter estimation
%
% Description:
%   The experimental data on string lengths were collected from the
%   G string, with N=17 half notes above the open G (i.e. G3 = 196.00 Hz).
%   To ensure measurement accuracy, we measured the string length of each
%   note for M=10 times independently. These string length measurements
%   were computed as multiple response data points for parameter fitting
%   analysis.

addpath(genpath('..'));
load("data1.mat", "data");
%load("data2.mat", "data");

[N, M] = size(data);

L0 = repmat(data(1,:), [N-1,1]);
n = repmat((1:(N-1))', [1, M]);
Ln= data(2:end, :);
f = sum(abs(Ln - L0.*w(1).^(-n./w(2))), 'all');
