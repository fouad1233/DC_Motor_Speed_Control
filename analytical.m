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

%% Lead Compensator

close all

wd = 80;
z = -90;
p1 = poles(1);
p2 = poles(2);

p = p1 - (wd/(   tan(   -atan((p2-p1)/wd) + atan(wd/(p1 - z))  )));

zero_tf = tf([1, -z], 1);  % Transfer function for zero: (s - z)
pole_tf = tf(1, [1, -p]);  % Transfer function for pole: 1/(s - p)

% Combine the existing transfer function with the new zero and pole
new_sys = series(sys, zero_tf);
new_sys = series(new_sys, pole_tf);


% Plot the root locus of the new system
figure;
rlocus(new_sys);
title('Root Locus Plot for Lead Compensation');
grid on;
atan((p2-p1)/wd) + atan(wd/(p1 - p)) - atan(wd/(p1 - z))


%% Lag Compensator

close all

p = -100;
z = p1 + p - p2;

zero_tf_lag = tf([1, -z], 1);  % Transfer function for zero: (s - z)
pole_tf_lag = tf(1, [1, -p]);  % Transfer function for pole: 1/(s - p)

% Combine the existing transfer function with the new zero and pole
new_sys_lag = series(sys, zero_tf_lag);
new_sys_lag = series(new_sys_lag, pole_tf_lag);

% Plot the root locus of the new system with lag compensator
figure;
rlocus(new_sys_lag);
title('Root Locus Plot for Lag Compensation');
grid on;

