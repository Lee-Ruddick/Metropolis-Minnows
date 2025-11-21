close all;

p = @(x) exp(-5*(x-0.5)^2) * cos(3*pi*x)+1; % Define p(x)

% Large sample to plot the histogram
total_samples = 10^7; % Set the number of samples that should be drawn

X = nan(total_samples, 1);
rng(1) % Fix the rng seed
X(1) = rand(); % Choose X_0 = x, using Uniform distribution on [0,1]
for n=1:total_samples-1
    proposed_x = rand(); % Choose x', using Uniform distribution on [0,1]
    acceptance_probability = min(1, p(proposed_x)/p(X(n))); % Calculate the acceptance probability
    if rand() <= acceptance_probability % If we accept x'
        X(n+1) = proposed_x; % Set X(n+1) = x'
    else % If we reject x'
        X(n+1) = X(n); % Stay at current state and set X(n+1) = x
    end
end


figure;
bins_num = 100;
histogram(X, 0:1/bins_num:1) % Draw the sample histogram
xlabel("$x$", "Interpreter", "latex", "FontSize", 20)
ylabel("Number of samples", "Interpreter", "latex", "FontSize", 20)
title("Metropolis-Hastings applied to $e^{-5(x-0.5)^2} cos(3 \pi x) +1$", 'Interpreter', 'latex', 'FontSize', 20)
xlim([0, 1]);

figure;
fplot(p, [0,1]); % Plot p(x) for comparison
ylim([0, 2]);
xlabel("$x$", 'Interpreter', 'latex', 'FontSize', 20);
ylabel("$p(x)$", 'Interpreter', 'latex', 'FontSize', 20);

% Small sample to show how the markov chain explores the domain
total_samples = 10; % Set the number of samples that should be drawn

X = nan(total_samples, 1);
rng(1) % Fix the rng seed to get same starting results as large sample
X(1) = rand(); % Choose X_0 = x
disp("X_0 has been chosen as: " + num2str(X(1)))
for n=1:total_samples-1
    proposed_x = rand(); % Choose x'
    disp("x' has been chosen as: " + num2str(proposed_x))
    acceptance_probability = min(1, p(proposed_x)/p(X(n))); % Calculate the acceptance probability
    disp("Acceptance probability is: " + num2str(acceptance_probability))
    if rand() <= acceptance_probability % If we accept x'
        X(n+1) = proposed_x; % Set X(n+1) = x'
        disp("Accepted x' and set X_" + num2str(n) + " to: " + num2str(X(n+1)))
    else % If we reject x'
        X(n+1) = X(n); % Stay at current state and set X(n+1) = x
        disp("Rejected x' and set X_" + num2str(n) + " to: " + num2str(X(n+1)))
    end
end
