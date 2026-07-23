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

%% Select simulation to plot
integrationScheme='_3-9-5IPs';
% integrationScheme='_equalSpace_21IPs';

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

results_OpenSees_Disp=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme,smoothEtaScheme,'_tipDisp','.txt'));
results_OpenSees_RBase=importdata(strcat(OpenSeesResultsPath,specimen,'_beamOnly',integrationScheme,smoothEtaScheme,'_baseReact','.txt'));
% U_axial_OpenSees=results_OpenSees_Disp(1+nbStepAxialLoad:1:end,3);
U_lat_OpenSees=results_OpenSees_Disp(1+nbStepAxialLoad:1:end,3);
RM_OpenSees=-results_OpenSees_RBase(1+nbStepAxialLoad:1:end,7);
simulTime_OpenSees=results_OpenSees_Disp(1+nbStepAxialLoad:1:end,1);


%% Computation of the OpenSees chord rotation
%Ln_OpenSees=sqrt((L+U_axial_OpenSees).^2 + (U_lat_OpenSees).^2); %deformed length of the column
%axialShortening_OpenSees=Ln_OpenSees-L;
chordRotation_OpenSees=U_lat_OpenSees./L;

%% Reduce experimental data to same size as OpenSees results
% [ChordRotation_strongAxis_Experimental_Mapped,RM_strongAxis_Experimental_Mapped]=mapVectors(ChordRotation_strongAxis_OpenSees,RM_strongAxis_OpenSees,ChordRotation_strongAxis_Experimental,RM_Experimental);
% [~,axialShortening_Experimental_Mapped]=mapVectors(ChordRotation_strongAxis_OpenSees,axialShortening_OpenSees,ChordRotation_strongAxis_Experimental,axialShortening_Experimental);
chordRotation_Experimental_Mapped=chordRotation_Experimental;
RM_Experimental_Mapped=RM_Experimental;

%% Plot of the comparison 
%Moment-chord strong axis rotation results
h1=figure;
plot(chordRotation_Experimental,RM_Experimental/1e6,'-k','LineWidth',1.2)
hold on
plot(chordRotation_OpenSees,RM_OpenSees/1e6,'-r')
leg=legend('Test',integrationScheme(end-7:end),'Location','best','NumColumns',1);
leg.ItemTokenSize = [12,1];
xlabel('Beam rotation \theta [rad]')
ylabel('Moment M [kNm]')
grid on
% plot_settings_ASCE(h1)
% export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,integrationScheme,smoothEtaScheme,'_RMChordRot','.pdf'),'-pdf');

% %Detailed view
% h2=figure;
% plot(ChordRotation_strongAxis_Experimental,RM_strongAxis_Experimental,'-k','LineWidth',1.2)
% hold on
% plot(ChordRotation_strongAxis_nonUniformSpace,RM_strongAxis_nonUniformSpace,'-r')
% leg=legend('Test',integrationScheme(end-7:end),'Location','best','NumColumns',1);
% leg.ItemTokenSize = [12,1];
% xlabel('Chord rotation \theta_z [rad]')
% ylabel('Moment M_z [kNm]')
% % xlim([0.005,0.03])
% % ylim([1200,2900])
% xlim([-0.015,0.035])
% ylim([-3000,500])
% grid on
% % plot_settings_ASCE(h2)
% % export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,integrationScheme,'_FInitial','_RMChordRotStrongAxis','_detailedView','.pdf'),'-pdf');


% Plot of Moment- cumumative chord rotation results
chordRotation_Cumulative_experimental_Mapped=[0;cumsum(abs(diff(chordRotation_Experimental_Mapped)))];
chordRotation_Cumulative_OpenSees=[0;cumsum(abs(diff(chordRotation_OpenSees)))];

h3=figure;
plot(chordRotation_Cumulative_experimental_Mapped,RM_Experimental_Mapped/1e6,'-k','LineWidth',1.2)
hold on
plot(chordRotation_Cumulative_OpenSees,RM_OpenSees/1e6,'-r') 
leg=legend('Test',integrationScheme(end-7:end),'Location','best','NumColumns',1);
leg.ItemTokenSize = [12,1];
xlabel('Cumulative beam rotation \theta [rad]')
ylabel('Moment M [kNm]')
grid on
% plot_settings_ASCE(h3)
% export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,integrationScheme,smoothEtaScheme,'_RMCumulChordRot','.pdf'),'-pdf');

% %Axial shortening-chord rotation results
% h4=figure;
% plot(ChordRotation_strongAxis_Experimental,axialShortening_Experimental,'-k','LineWidth',1.2)
% hold on
% plot(chordRotation_OpenSees,axialShortening_OpenSees,'-r')
% leg=legend('Test',integrationScheme(end-7:end),'Location','best','NumColumns',1);
% leg.ItemTokenSize = [12,1];
% xlabel('Chord Rotation \theta_z [rad]')
% ylabel('Axial shortening \delta [mm]')
% grid on
% % plot_settings_ASCE(h4)
% % export_fig(strcat(plotsOutputPath,'comparisonNIPs_',testName,integrationScheme,'_AxialShortChordRot','.pdf'),'-pdf');


%% Analysis fiber stresses and strains
% connectivity_file = strcat(OpenSeesResultsPath,testName,integrationScheme(end-8:end),'_connectivityMatrix','.txt');
% coordinate_file=strcat(OpenSeesResultsPath,testName,integrationScheme(end-8:end),'_coordinateMatrix','.txt');
% allStresses_file=strcat(OpenSeesResultsPath,testName,integrationScheme(end-8:end),'_Section1','_allFiberStresses','.txt');
% allStrains_file=strcat(OpenSeesResultsPath,testName,integrationScheme(end-8:end),'_Section1','_allFiberStrains','.txt');
% 
% connectivity_matrix = readmatrix(connectivity_file);
% coordinate_matrix   = readmatrix(coordinate_file);
% allStresses_matrix  = readmatrix(allStresses_file);
% allStrains_matrix  = readmatrix(allStrains_file);
% 
% numFibers = floor(numel(connectivity_matrix(1,:)) / 4);
% connectivity_matrix = reshape(connectivity_matrix(1,:), 4, []).';
% connectivity_matrix = int32(connectivity_matrix);
% numNodes = floor(numel(coordinate_matrix(1,:)) / 2);
% coordinate_matrix = reshape(coordinate_matrix(1,:), 2, []).';
% 
% centroids=computeCentroid(connectivity_matrix,coordinate_matrix);
% 
% allFibers_sigma11=allStresses_matrix(1+nbStepAxialLoad:1:end,1:3:size(allStresses_matrix, 2));
% allFibers_epsi11=allStrains_matrix(1+nbStepAxialLoad:1:end,1:3:size(allStrains_matrix, 2));
% allFibers_sigma12=allStresses_matrix(1+nbStepAxialLoad:1:end,2:3:size(allStresses_matrix, 2));
% allFibers_epsi12=allStrains_matrix(1+nbStepAxialLoad:1:end,2:3:size(allStrains_matrix, 2));
% allFibers_sigma13=allStresses_matrix(1+nbStepAxialLoad:1:end,3:3:size(allStresses_matrix, 2));
% allFibers_epsi13=allStrains_matrix(1+nbStepAxialLoad:1:end,3:3:size(allStrains_matrix, 2));
% 
% % for i=1:numFibers
% % for i=14
% % h5=figure;
% % plot(allFibers_epsi11(:,i),allFibers_sigma11(:,i))
% % xlabel('$\varepsilon_{11}$ [-]','Interpreter','latex')
% % ylabel('$\sigma_{11}$ [MPa]','Interpreter','latex')
% % grid on
% % end
% 
% % for i=14;
% for i=1:numFibers
%     figure
% 
%     % --- Plot 1: stress-strain ---
%     subplot(1,2,1)
%     plot(allFibers_epsi11(:,i),allFibers_sigma11(:,i));
%     hold on
%     p1 = plot(allFibers_epsi11(7833,i),allFibers_sigma11(7833,i), 'r.','MarkerSize',20);
%     xlabel('$\varepsilon_{11}$ [-]','Interpreter','latex')
%     ylabel('$\sigma_{11}$ [MPa]','Interpreter','latex')
%     title(['Fiber ', num2str(i)])
%     grid on
% 
%     % --- Plot 2: moment-rotation ---
%     subplot(1,2,2)
%     plot(ChordRotation_strongAxis_nonUniformSpace,RM_strongAxis_nonUniformSpace, '-r')
%     hold on
%     p2 = plot(ChordRotation_strongAxis_nonUniformSpace(7833), RM_strongAxis_nonUniformSpace(7833), 'b.','MarkerSize',20,'LineWidth',2);
%     xlabel('Chord rotation \theta_z [rad]')
%     ylabel('Moment M_z [kNm]')
%     legend('Test', integrationScheme(end-7:end),'Location','best')
%     grid on
% 
%     % =========================
%     % SLIDER
%     % =========================
%     n=size(RM_strongAxis_nonUniformSpace,1);
%     uicontrol('Style','slider',...
%         'Min',1,'Max',n,'Value',7833,...
%         'Units','normalized',...
%         'Position',[0.2 0.02 0.6 0.04],...
%         'SliderStep',[1/(n-1) , 10/(n-1)],...
%         'Callback',@(src,~) updatePlots(round(src.Value), allFibers_epsi11(:,i), allFibers_sigma11(:,i), ChordRotation_strongAxis_nonUniformSpace, RM_strongAxis_nonUniformSpace, p1, p2));
% 
% end
% 
% test=1;


%% Error Metric with respect to Abaqus
% %Moment-chord rotation
% diffMomentSquared=(RM_OpenSees-RM_strongAxis_Experimental_Mapped).^2;
% phiError_moment=trapz(ChordRotation_strongAxis_Cumulative_experimental_Mapped,diffMomentSquared)/ChordRotation_strongAxis_Cumulative_experimental_Mapped(end);
% phiBarError_RMChordRot_OpenSees=sqrt(phiError_moment/(trapz(ChordRotation_strongAxis_Cumulative_experimental_Mapped,RM_strongAxis_Experimental_Mapped.^2)/ChordRotation_strongAxis_Cumulative_experimental_Mapped(end)))
% 
% 
% %Axial shortening-chord rotation
% diffaxialShorteningSquared=(axialShortening_OpenSees-axialShortening_Experimental_Mapped).^2;
% phiError_axialShortening=trapz(ChordRotation_strongAxis_Cumulative_experimental_Mapped,diffaxialShorteningSquared)/ChordRotation_strongAxis_Cumulative_experimental_Mapped(end);
% phiBarError_axialShorteningChordRot_nonUniformSpace=sqrt(phiError_axialShortening/(trapz(ChordRotation_strongAxis_Cumulative_experimental_Mapped,axialShortening_Experimental_Mapped.^2)/ChordRotation_strongAxis_Cumulative_experimental_Mapped(end)))



function updatePlots(idx, epsi, sigma, theta, M, p1, p2)

% Update marker in stress-strain
set(p1, 'XData', epsi(idx), 'YData', sigma(idx));

% Update marker in moment-rotation
set(p2, 'XData', theta(idx), 'YData', M(idx));

end


function centroids=computeCentroid(connectivity_matrix,coordinate_matrix)
nElem = size(connectivity_matrix, 1);

centroids = zeros(nElem, 2);

for e = 1:nElem
    nodes = connectivity_matrix(e, :);

    coords = coordinate_matrix(nodes, :);  % (nNodesPerElem x 2)

    centroids(e, :) = mean(coords, 1);
end
end


