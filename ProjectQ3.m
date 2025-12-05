N = 100000;
T_values = [0.5, 1, 2, 5];  
for j = 1:length(T_values)
    rng(3);
    T = T_values(j);
    steps = 10000;
    spins = randi([0, 1], 1, N);
    for i = 1:length(spins)
        if spins(i) == 0
            spins(i) = -1;
        end
    end
    magnetization = zeros(1, steps);
    for i = 1:steps
            k = randi(N);
            left = mod(k - 2, N) + 1;
            right = mod(k, N) + 1;
            energyChange = 2 * spins(k) * (spins(left) + spins(right));
        if energyChange <= 0 || rand() <= exp(-energyChange / T)
            spins(k) = -spins(k);
        end
        magnetization(i) = sum(spins) / N;
    end

    subplot(2, 2, j);
    histogram(magnetization, 'NumBins', 100)
    set(gca, 'FontSize', 14)
    xlabel('Magnetisation')
    ylabel('Frequency')
    title(['T = ' num2str(T)]);
    drawnow;
end
