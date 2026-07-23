clear 
clc

%This scripts plots the comparison of NipLe with respect to
%reference simulation

%% Select load protocol
specimen="LS4";

%% Select resize
% resizeParam='_resize100';

%% Path
OpenSeesResultsPath='D:\01 - OpenSeesDevelopment\OpenSees\Win64\proj\openSees\results_LS4_Yu2000_BeamOnly_sigmaC0MaityEtAL2025_4Erc\';

plotsOutputPath='D:\Lehigh University Dropbox\Diego Heredia Rosa\07 - OpenSees\Validation non-uniform spacing integration\04 - Figures\';

testResultsPath=strcat('D:\Lehigh University Dropbox\Diego Heredia Rosa\07 - OpenSees\Validation non-uniform spacing integration\01 - Experiments Results\');
testName=strcat(specimen,'_Yu2000');

%% Select simulations to plot
integrationScheme_3_3_5='_3-3-5IPs';
integrationScheme_3_5_5='_3-5-5IPs';
integrationScheme_3_7_5='_3-7-5IPs';
integrationScheme_3_9_5='_3-9-5IPs';
integrationScheme_3_11_5='_3-11-5IPs';
integrationScheme_5_9_9='_5-9-9IPs';
integrationScheme_5_11_11='_5-11-11IPs';

% smoothEtaScheme='_alphaBound4Smoothin005';
% smoothEtaScheme='_alphaBound4Smoothin5';
smoothEtaScheme='_delta005';

%% Beam Geometry
L=3591;

%% Import test results
%Yu et al. 2000
experimentalResults=importdata(strcat(testResultsPath,'LS4_experimental_totalRotation_M_Nmm','.txt'));
RM_Experimental=experimentalResults.data(:,4);
chordRotation_Experimental=experimentalResults.data(:,1);


%% Import the moment rotation results OpenSees
nbStepAxialLoad=0;

% 3-3-5 IPs
results_OpenSees_3_3_5_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_3_5,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_3_3_5_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_3_5,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_3_3_5=results_OpenSees_3_3_5_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_3_3_5=-results_OpenSees_3_3_5_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_3_3_5=results_OpenSees_3_3_5_Disp(1+nbStepAxialLoad:1:end,1);

% 3-5-5 IPs
results_OpenSees_3_5_5_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_5_5,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_3_5_5_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_5_5,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_3_5_5=results_OpenSees_3_5_5_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_3_5_5=-results_OpenSees_3_5_5_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_3_5_5=results_OpenSees_3_5_5_Disp(1+nbStepAxialLoad:1:end,1);

% 3-7-5 IPs
results_OpenSees_3_7_5_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_7_5,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_3_7_5_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_7_5,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_3_7_5=results_OpenSees_3_7_5_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_3_7_5=-results_OpenSees_3_7_5_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_3_7_5=results_OpenSees_3_7_5_Disp(1+nbStepAxialLoad:1:end,1);

% 3-9-5 IPs
results_OpenSees_3_9_5_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_9_5,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_3_9_5_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_9_5,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_3_9_5=results_OpenSees_3_9_5_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_3_9_5=-results_OpenSees_3_9_5_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_3_9_5=results_OpenSees_3_9_5_Disp(1+nbStepAxialLoad:1:end,1);

% 3-11-5 IPs
results_OpenSees_3_11_5_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_11_5,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_3_11_5_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_3_11_5,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_3_11_5=results_OpenSees_3_11_5_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_3_11_5=-results_OpenSees_3_11_5_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_3_11_5=results_OpenSees_3_11_5_Disp(1+nbStepAxialLoad:1:end,1);

% 5-9-9 IPs
results_OpenSees_5_9_9_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_5_9_9,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_5_9_9_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_5_9_9,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_5_9_9=results_OpenSees_5_9_9_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_5_9_9=-results_OpenSees_5_9_9_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_5_9_9=results_OpenSees_5_9_9_Disp(1+nbStepAxialLoad:1:end,1);

% 5-11-11 IPs
results_OpenSees_5_11_11_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_5_11_11,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_5_11_11_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme_5_11_11,smoothEtaScheme,'_baseReact','.txt'));
U_lat_OpenSees_5_11_11=results_OpenSees_5_11_11_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees_5_11_11=-results_OpenSees_5_11_11_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees_5_11_11=results_OpenSees_5_11_11_Disp(1+nbStepAxialLoad:1:end,1);


%% Computation of the OpenSees chord rotation
chordRotation_OpenSees_3_3_5=U_lat_OpenSees_3_3_5./L;
chordRotation_OpenSees_3_5_5=U_lat_OpenSees_3_5_5./L;
chordRotation_OpenSees_3_7_5=U_lat_OpenSees_3_7_5./L;
chordRotation_OpenSees_3_9_5=U_lat_OpenSees_3_9_5./L;
chordRotation_OpenSees_3_11_5=U_lat_OpenSees_3_11_5./L;
chordRotation_OpenSees_5_9_9=U_lat_OpenSees_5_9_9./L;
chordRotation_OpenSees_5_11_11=U_lat_OpenSees_5_11_11./L;


%% Reduce experimental data to same size as OpenSees results
chordRotation_Experimental_Mapped=chordRotation_Experimental;
RM_Experimental_Mapped=RM_Experimental;

%% Plot of the comparison 
%Moment-chord strong axis rotation results
h1=figure;
plot(chordRotation_Experimental,RM_Experimental/1e6,'-k','LineWidth',1.2)
hold on
plot(chordRotation_OpenSees_3_3_5,RM_OpenSees_3_3_5/1e6)
plot(chordRotation_OpenSees_3_5_5,RM_OpenSees_3_5_5/1e6)
plot(chordRotation_OpenSees_3_7_5,RM_OpenSees_3_7_5/1e6)
leg=legend('Test','3-3-5 IPs','3-5-5 IPs','3-7-5 IPs','Location','best','NumColumns',1);
% plot(chordRotation_OpenSees_3_5_5,RM_OpenSees_3_5_5/1e6)
% plot(chordRotation_OpenSees_5_9_9,RM_OpenSees_5_9_9/1e6)
% plot(chordRotation_OpenSees_3_3_5,RM_OpenSees_3_3_5/1e6)
% leg=legend('Test','3-5-5 IPs','5-9-9 IPs','3-3-5 IPs','Location','best','NumColumns',1);
leg.ItemTokenSize = [12,1];
xlabel('Beam rotation \theta [rad]')
ylabel('Moment M [kNm]')
grid on
% plot_settings_ASCE(h1)
% export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,smoothEtaScheme,'_RMChordRot','.pdf'),'-pdf');


% Plot of Moment- cumumative chord rotation results
chordRotation_Cumulative_experimental_Mapped=[0;cumsum(abs(diff(chordRotation_Experimental_Mapped)))];
chordRotation_Cumulative_OpenSees_3_3_5=[0;cumsum(abs(diff(chordRotation_OpenSees_3_3_5)))];
chordRotation_Cumulative_OpenSees_3_5_5=[0;cumsum(abs(diff(chordRotation_OpenSees_3_5_5)))];
chordRotation_Cumulative_OpenSees_3_7_5=[0;cumsum(abs(diff(chordRotation_OpenSees_3_7_5)))];
chordRotation_Cumulative_OpenSees_3_9_5=[0;cumsum(abs(diff(chordRotation_OpenSees_3_9_5)))];
chordRotation_Cumulative_OpenSees_3_11_5=[0;cumsum(abs(diff(chordRotation_OpenSees_3_11_5)))];
chordRotation_Cumulative_OpenSees_5_9_9=[0;cumsum(abs(diff(chordRotation_OpenSees_5_9_9)))];
chordRotation_Cumulative_OpenSees_5_11_11=[0;cumsum(abs(diff(chordRotation_OpenSees_5_11_11)))];

h3=figure;
plot(chordRotation_Cumulative_experimental_Mapped,RM_Experimental_Mapped/1e6,'-k','LineWidth',1.2)
hold on
plot(chordRotation_Cumulative_OpenSees_3_3_5,RM_OpenSees_3_3_5/1e6) 
plot(chordRotation_Cumulative_OpenSees_3_5_5,RM_OpenSees_3_5_5/1e6) 
plot(chordRotation_Cumulative_OpenSees_3_7_5,RM_OpenSees_3_7_5/1e6) 
leg=legend('Test','3-3-5 IPs','3-5-5 IPs','3-7-5 IPs','Location','best','NumColumns',1);
% plot(chordRotation_Cumulative_OpenSees_3_5_5,RM_OpenSees_3_5_5/1e6)
% plot(chordRotation_Cumulative_OpenSees_5_9_9,RM_OpenSees_5_9_9/1e6)
% plot(chordRotation_Cumulative_OpenSees_3_3_5,RM_OpenSees_3_3_5/1e6)
% leg=legend('Test','3-5-5 IPs','5-9-9 IPs','3-3-5 IPs','Location','best','NumColumns',1);
leg.ItemTokenSize = [12,1];
xlabel('Cumulative beam rotation \theta [rad]')
ylabel('Moment M [kNm]')
grid on
% plot_settings_ASCE(h3)
% export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,smoothEtaScheme,'_RMCumulChordRot','.pdf'),'-pdf');

