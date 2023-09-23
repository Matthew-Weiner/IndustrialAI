%E-Manufacturing 2013

%Logistic Regression 

%How to Use This Method


%% clear stuff
clear all
clc
close all


normal_data = [0.0008824929443993322, 0.0008642239566808705, 0.001341403139103345, 0.0012581054273561032, 0.001417725379284841, 0.0016738868014420634, 0.0007992936957718482, 0.0022282241792880193, 0.0023609183341818185, 0.0022730284474489987, 0.00185373201975912, 0.0013711254001554196, 0.0014783733202044392, 0.001200775394538397, 0.0006601415674404889, 0.0005969001925681068, 0.0006540637459141124, 0.0002793368235030195, 0.0010639753049586313, 0.0010344952952668711];
faulty_data = [0.017041239920371567, 0.01759162937487094, 0.01929322892398531, 0.01895308493015853, 0.019174935593763386, 0.01976901839954141, 0.020476280276764614, 0.02129309675997389, 0.020017126035872305, 0.02106527800642063, 0.02131714911682699, 0.02161347669099795, 0.02186682991616575, 0.022225172338878663, 0.023053869232437962, 0.02417931374850932, 0.024407417963853612, 0.025585975375229966, 0.025628591151252978, 0.024458624206631384];


%% Select Training Portion and PCA (front/back)

%GoodSampleIndex (in this example I assume the baseline data is first 100
%samples

GoodSampleIndex=1:20;

%Lets assume the last 100 samples are from a degraded system
DegradedSampleIndex=21:40;

%Baseline Data
BaselineData=FeatureMatrix(GoodSampleIndex,:);

DegradedData=FeatureMatrix(DegradedSampleIndex,:);



%% Train LR Model

%Label Vector (0.95 for good samples, 0.05 for bad samples
Label=[ones(size(BaselineData,1),1)*0.95; ones(size(DegradedData,1),1)*0.05];

%fit LR Model (glm-fit)
beta = glmfit([BaselineData; DegradedData],Label,'binomial');



%% Calculating Health Value (using LR Model)

%assume I have some test-data (assume it is samples 301-400

TestFeatureMatrix=FeatureMatrix(41:70,:);

%calculate CV (Health Value)
CV_Test = glmval(beta,TestFeatureMatrix,'logit') ;  %Use LR Model
   

