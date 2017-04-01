%% Initilization

close all;
clc;

%% Variable Decleration

numberOfDataPoints = 100;         % Number of points in each test, 2 points is enough for linear relationships

% ----------------- POWER USAGE -----------------

batteryAh = 0.150;

idleCurrent = 0.050;
alarmCurrent = 0.120;

% ----------------- TURBINE EFFICIENCY -----------------

minAlarmOnPercent = 0;
maxAlarmOnPercent = 100;

alarmOnPercent = linspace(minAlarmOnPercent, maxAlarmOnPercent, numberOfDataPoints);

%% Calculations

for i = 1:length(alarmOnPercent)
    currentDraw(i) = alarmCurrent .* (alarmOnPercent(i) ./ 100) + idleCurrent .* (1 - ( (alarmOnPercent(i) ./ 100) ));
    batteryLife(i) = batteryAh ./ currentDraw(i);
    %fprintf('Alarm on percent: %0.1f, Power usage: %0.1f\n', alarmOnPercent(i), powerUsage(i));
end

%% Output

plot(alarmOnPercent, batteryLife, 'DisplayName', 'Battery Life');

xlabel('Alarm On Percent (%)');
ylabel('Battery Life (h)');
%title('Alarm On Percent vs. Battery Life');
legendHandle = legend(gca,'show');
set(legendHandle, 'Location', 'northeast');

fprintf('Max. battery life (0%% Alarm): %0.1fh (Current draw: %0.1fmA)\n', batteryLife(1), currentDraw(1) * 1000);
fprintf('Mid. battery life (50%% Alarm): %0.1fh (Current draw: %0.1fmA)\n', batteryLife(numberOfDataPoints/2), currentDraw(numberOfDataPoints/2) * 1000);
fprintf('Min. battery life (100%% Alarm): %0.1fh (Current draw: %0.1fmA)\n', batteryLife(numberOfDataPoints), currentDraw(numberOfDataPoints) * 1000);