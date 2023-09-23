max_amp_healthy = [0.0008824929443993322, 0.0008642239566808705, 0.001341403139103345, 0.0012581054273561032, 0.001417725379284841, 0.0016738868014420634, 0.0007992936957718482, 0.0022282241792880193, 0.0023609183341818185, 0.0022730284474489987, 0.00185373201975912, 0.0013711254001554196, 0.0014783733202044392, 0.001200775394538397, 0.0006601415674404889, 0.0005969001925681068, 0.0006540637459141124, 0.0002793368235030195, 0.0010639753049586313, 0.0010344952952668711];
max_amp_faulty = [0.017041239920371567, 0.01759162937487094, 0.01929322892398531, 0.01895308493015853, 0.019174935593763386, 0.01976901839954141, 0.020476280276764614, 0.02129309675997389, 0.020017126035872305, 0.02106527800642063, 0.02131714911682699, 0.02161347669099795, 0.02186682991616575, 0.022225172338878663, 0.023053869232437962, 0.02417931374850932, 0.024407417963853612, 0.025585975375229966, 0.025628591151252978, 0.024458624206631384];
max_amp_test = [0.00028918000060579573, 0.0005864488933814319, 0.001096903604630066, 0.0011252786883063487, 0.000979820574863369, 0.0010323775172290306, 0.0008171247348647083, 0.0006914805889962655, 0.0009730858934025584, 0.0012405675303247385, 0.004119853681349886, 0.00441385034054524, 0.004549640064881002, 0.00470532955861928, 0.004583764727256316, 0.004700703462934546, 0.004584735538799882, 0.004622685283420054, 0.004667516783651969, 0.004830959538579846, 0.024710727604046107, 0.025433486633071618, 0.027039382619038037, 0.02870965867910361, 0.024708673279751247, 0.01431011899990185, 0.013844504693267689, 0.01381482022231883, 0.01340069393773258, 0.013117282683032413];

%% train model
res = lr_train(max_amp_healthy, max_amp_faulty, 1);

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