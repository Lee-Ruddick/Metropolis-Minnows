close all;

p = @(r, theta, phi) deal(r .* sin(phi) .* cos(theta), r .* sin(phi) .* sin(theta), r.* cos(phi));

% Large sample to plot the histogram
total_samples = 2 * 10^6; % Set the number of samples that should be drawn

X = nan(total_samples, 3);
rng(1); % Fix the rng seed

r = 1;
theta = 2 * pi * rand(); % Choose theta_0 = theta
phi = acos(2 * rand() - 1); % Choose phi_0 = phi

X(1,:) = [r, theta, phi]; % Choose X_0 = x
for n=1:total_samples-1

    proposed_r = r;
    proposed_theta = 2 * pi * rand(); % Choose theta'
    proposed_phi = acos(2 * rand() - 1); % Choose phi'

    [x,y,z] = p(X(n,1), X(n,2), X(n,3));
    [proposed_x, proposed_y, proposed_z] = p(proposed_r, proposed_theta, proposed_phi);

    acceptance_probability = min(1, norm([proposed_x, proposed_y, proposed_z])/norm([x,y,z])); % Calculate the acceptance probability
    if rand() <= acceptance_probability % If we accept x'
        X(n+1,:) = [proposed_r, proposed_theta, proposed_phi]; % Set X(n+1) = x'
    else % If we reject x'
        X(n+1,:) = X(n,:); % Stay at current state and set X(n+1) = x
    end
end

figure;
[x,y,z] = p(X(:,1), X(:,2), X(:,3));
scatter3(x, y, z, 'x');
xlabel('r'); ylabel('theta'); zlabel('phi');
axis equal;
set(gca, 'FontSize', 18);

%Testing Uniformity
theta = mod(X(:,2), 2*pi);
z = cos(X(:,3));

%Testing theta against 1/(2*pi)
figure; 
subplot(1,2,1);
histogram(theta, 'Normalization', 'pdf'); hold on;
yline(1/(2*pi), '--r', 'LineWidth', 2);
title('θ density vs 1/(2π)'); xlabel('θ'); ylabel('pdf');
set(gca, 'FontSize', 14);

%Testing z against 1/2
subplot(1,2,2);
histogram(z, 'Normalization', 'pdf'); hold on;
yline(1/2, '--r', 'LineWidth', 2);
title('z=cos(φ) density vs 1/2'); xlabel('z'); ylabel('pdf');
set(gca, 'FontSize', 14);



