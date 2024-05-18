Ra = 11.4;
La = 0.1214;
Jm = 0.02215;
Bm = 0.002953;
Kt = 1.28;
Ke = 0.0045;

% Define the transfer function
sys = tf(Kt / (La * Jm), [1, (Ra * Jm + Bm * La) / (La * Jm), (Kt * Ke + Ra * Bm + Kt) / (La * Jm)]);

% Plot the root locus with increased line width
figure;
rlocus(sys);
h = findall(gca, 'type', 'line');
set(h, 'linewidth', 2);

% Compute and plot the poles
ch_eq_coefs = [1, (Ra * Jm + Bm * La) / (La * Jm), (Kt * Ke + Ra * Bm + Kt) / (La * Jm)];
poles = roots(ch_eq_coefs);
T = 1 / max(abs(poles));
ts_2 = 4 * T;
ts_5 = 3 * T;

figure;
plot(real(poles), imag(poles), 'rx', 'LineWidth', 2, 'MarkerSize', 20);
grid on;
xlabel('Real');
ylabel('Imaginary');
title('Poles');

% Ensure all grid lines and axis lines are of width 2
set(gca, 'LineWidth', 2);
set(findall(gcf, 'Type', 'Line'), 'LineWidth', 2);

% Additional calculations
result1 = (Kt * Ke + Ra * Bm) / Kt;
result2 = Kt / (Kt * (Ke + 1) + Ra * Bm);

% Display results
disp('Results:');
disp(['Result 1: ', num2str(result1)]);
disp(['Result 2: ', num2str(result2)]);

tf_eq_bb = [Kt / (La * Jm)];
ch_eq_coefs2 = [1, (Ra * Jm + Bm * La) / (La * Jm), (Kt * Ke + Ra * Bm) / (La * Jm)];
