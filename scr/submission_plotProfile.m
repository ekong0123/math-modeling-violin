%% Violin Fingerboard Spacing Analysis
% This script plots the fingerboard spacing function:
%
% L_n = L_0*a^{-n/b}
%
% where L_n: string length associated with the n-th half step
%       L_0: open string length
%         n: the n-th half note above the open string
%
% Inputs:
%   User-provided parameters [L_0 n]
%
% Outputs:
%   The plot of the customized string-length profile
%
% Description:


clc; clear; close all;

% Get user input
w = input('Enter the open string length and number of half-steps [L_0 n]:');
if isempty(w)
    w= [33 20];
end
n= round(w(2));

fprintf('Open string length: %.4f, Number of half-notes for display: %d\n', w(1), n);

% Define parameters
a=2;
b=12;
k = 1/b;    % Decay constant
N = 20;      % Maximum half-step

% Limit n if necessary
if n > N
    n = N;
    fprintf('n is larger than max N = %d\n', N);
end

% Generate x values
x = linspace(0, n, n+1);

% Compute exponential decay
y = w(1) * 2.^(-k * x);

% Plot
plot(x, y, 'b-o', 'LineWidth', 2, ...
    'DisplayName', sprintf('String-length Profile (a=%.2f, b=%.4f)', a, b));
hold on

% Labels and formatting
title('String-length Profile', 'FontSize', 14, 'FontWeight', 'bold')
xlabel('$n$', 'Interpreter', 'latex');
ylabel('$L_n$', 'Interpreter', 'latex');
grid on
legend('Location','best')
hold off
