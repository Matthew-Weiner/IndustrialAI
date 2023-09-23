clear
clc
close all

% file paths
training_healthy_path = 'C:\Users\maxki\OneDrive\Desktop\School\ENME 691\HW 2\Reading Materials\Training\Healthy';
training_faulty_path = 'C:\Users\maxki\OneDrive\Desktop\School\ENME 691\HW 2\Reading Materials\Training\Faulty';
testing_path = 'C:\Users\maxki\OneDrive\Desktop\School\ENME 691\HW 2\Reading Materials\Testing';

addpath(training_healthy_path)
addpath(training_faulty_path)
addpath(testing_path)

training_healthy_dir = dir(fullfile(training_healthy_path, '*.txt'));
training_faulty_dir = dir(fullfile(training_faulty_path, '*.txt'));
testing_dir = dir(fullfile(testing_path, '*.txt'));

% load all data
fs = 2560;
for t = 1:numel(training_healthy_dir)
    training_healthy(t) = importdata(training_healthy_dir(t).name);
end

for t = 1:numel(training_faulty_dir)
    training_faulty(t) = importdata(training_faulty_dir(t).name);
end

for t = 1:numel(testing_dir)
    testing(t) = importdata(testing_dir(t).name);
end

%%
% time domain plots of healthy training data
figure
for t = 1:numel(training_healthy)
    title('Training Healthy')
    time = [0:1/fs:(length(training_healthy(t).data) - 1)/fs];
    plot(time, training_healthy(t).data)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    grid on
    hold on
end
hold off
legend('Location', 'best')

% time domain plots of faulty training data
figure
for t = 1:numel(training_faulty)
    title('Training Faulty')
    time = [0:1/fs:(length(training_faulty(t).data) - 1)/fs];
    plot(time, training_faulty(t).data)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    grid on
    hold on
end
hold off
legend('Location', 'best')

% time domain plots of testing data
figure
for t = 1:numel(testing)
    title('Testing')
    time = [0:1/fs:(length(testing(t).data) - 1)/fs];
    plot(time, testing(t).data)
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    grid on
    hold on
end
hold off
legend('Location', 'best')
%% frequency domain plots
% healthy training
% figure
for i = 1:numel(training_healthy)
    fft_data = fft(training_healthy(i).data);
    N = length(training_healthy(i).data);
    amp_healthy(:, i) = 2*abs(fft_data)/N;
    [max_amp_healthy(i), healthy_locs(i)] = max(amp_healthy([N*20/fs:N*30/fs], i));
    freq = (0:N-1)*fs/N;
%     plot(freq, amp_healthy(:, i));
%     xlim([0, 60]);
%     hold on
end
% hold off
% title('Training Healthy')
% xlabel('Frequency (Hz)')
% ylabel('Amplitude')
% legend()
% grid on
% ax = gca;
% ax.YAxis.Exponent = 0;

% faulty training
% figure
for i = 1:numel(training_faulty)
    fft_data = fft(training_faulty(i).data);
    N = length(training_faulty(i).data);
    amp_faulty(:, i) = 2*abs(fft_data)/N;
    [max_amp_faulty(i), faulty_locs(i)] = max(amp_faulty([N*20/fs:N*30/fs], i));
    freq = (0:N-1)*fs/N;
% %     plot(freq, amp_faulty(:, i));
%     xlim([0, 60]);
%     hold on
end
% hold off
% title('Training Faulty')
% xlabel('Frequency (Hz)')
% ylabel('Amplitude')
% legend()
% grid on
% ax = gca;
% ax.YAxis.Exponent = 0;

% testing
% figure
for i = 1:numel(testing)
    fft_data = fft(testing(i).data);
    N = length(testing(i).data);
    amp_test(:, i) = 2*abs(fft_data)/N;
    [max_amp_test(i), test_locs(i)] = max(amp_test([N*20/fs:N*30/fs], i));
    freq = (0:N-1)*fs/N;
%     plot(freq, amp);
%     xlim([0, 60]);
%     hold on
end
% hold off
% title('Testing')
% xlabel('Frequency (Hz)')
% ylabel('Amplitude')
% legend()
% grid on
% ax = gca;
% ax.YAxis.Exponent = 0;

%% compare amplitudes b/w healthy and faulty
sample = (1:numel(max_amp_faulty));     
figure
plot(sample, max_amp_healthy, '-o', 'color', 'b')
hold on                               
plot(sample, max_amp_faulty, '-s', 'color', 'r')      
hold off
grid on
legend('Healthy', 'Faulty', 'location', 'northwest')
xlabel('Sample')
ylabel('Max Amplitude')
ax = gca;
ax.YAxis.Exponent = 0;

%% max test amplitudes
sample = (1:numel(max_amp_test));
figure
plot(sample, max_amp_test, '-s')
legend('Test', 'location', 'northwest')
xlabel('Sample')
ylabel('Max Amplitude')
grid on

%% train model
res = lr_train(max_amp_healthy, max_amp_faulty, 0.5);

%% test model
for i = 1:length(max_amp_test)
    res_test(i) = lr_test(max_amp_test(i), res);
end

%% plot results
sample = [1:length(max_amp_test)];
plot(sample, res_test, '-o')
ylabel('CV Health')
xlabel('Sample')
title('Testing Data')
grid on
