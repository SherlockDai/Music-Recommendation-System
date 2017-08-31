%--------------------------------------------------------------------------
%MAIN_MRS    The main program of the Music Recommendation System
%
%   Program type: Script
%
%   @input:
%   @output:
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
% @author: Ting Zhou, Yue Dai
% @date:   3.27.2016
% @copyright: Team Sherlock
%--------------------------------------------------------------------------
%--------------------------------------------------------------------------

%% ----------------- system initialization start --------------------------
MRS_startup
warning off
dbstop if error
% ------------------ system initialization end-----------------------------

%% ---------------- read configuration file start--------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);
% ----------------- read configuration file end----------------------------

% %% ---------------- read and combine data start----------------------------
% combinedDataset = load([dataRootPath 'combinedDataset.mat']);
% combinedDataset = combinedDataset.dataset;
% % ---------------------------- read data start-----------------------------

%% ------------------read rating start-------------------------------------
ratingDataset = load([dataRootPath 'ratingDataset']);
ratingDataset = ratingDataset.combinedDataset;
% ------------------read rating end-  -------------------------------------
 
% %% ------------------calcualte the similarity between users start ---------
% % cosineSimMatrix = calculateCosineSim(ratingDataset);
% pearsonSimMatrix = calculatePearsonSim(ratingDataset);
% % ------------------calcualte the similarity between users end ------------
% 
% %% -----------------generate the neighbor matrix start---------------------
% % cosineNeighborMatrix = generateCosineNeighborMatrix(cosineSimMatrix);
% % save('./Output/cosineNeighborMatrix.mat', 'cosineNeighborMatrix');
% pearsonNeighborMatrix = generateNeighborMatrix(pearsonSimMatrix);
% save('./Output/pearsonNeighborMatrix.mat', 'pearsonNeighborMatrix');
% -------------------generate the neighbor matrix end-----------------------

% -----------------testing start -----------------------------------------
cosineNeighborMatrix = load('./Output/cosineNeighborMatrix.mat');
cosineNeighborMatrix = cosineNeighborMatrix.cosineNeighborMatrix;
pearsonNeighborMatrix = load('./Output/pearsonNeighborMatrix.mat');
pearsonNeighborMatrix = pearsonNeighborMatrix.pearsonNeighborMatrix;
cosineSimMatrix = load('./Output/CosineSimMatrix.mat');
cosineSimMatrix = cosineSimMatrix.userSimMatrix;
pearsonSimMatrix = load('./Output/PearsonSimMatrix.mat');
pearsonSimMatrix = pearsonSimMatrix.userSimMatrix;
%------------------testing end -------------------------------------------

%% -----------------generate recommendation start -------------------------
pearsonPredictedResult = generateRecommendation(ratingDataset, ...
    pearsonNeighborMatrix, pearsonSimMatrix);
save('./Output/pearsonPredictedResult.mat', 'pearsonPredictedResult');
% cosinePredictedResult = generateRecommendation(ratingDataset, ...
%     cosineNeighborMatrix, cosineSimMatrix);
% save('./Output/cosinePredictedResult.mat', 'cosinePredictedResult');
%-------------------generate recommendation end ---------------------------

%% -----------------performance meassurement start ------------------------
MAEandRMAEArray = MAEandRMAECalculation(pearsonPredictedResult);
% MAEandRMAEArray_cosine = MAEandRMAECalculation(cosinePredictedResult);
[confusionMatrix, TPR, FPR, Precision, Accuracy] = calculateConfusionMatrix(pearsonPredictedResult);
% [confusionMatrix_cosin, TPR_cosin, FPR_cosin, Precision_cosin, Accuracy_cosin] = calculateConfusionMatrix(cosinePredictedResult);
% ------------------performance meassurement end --------------------------

%% -----------------generate recommendation list start --------------------
jsonData = saveJsonFile(pearsonPredictedResult,ratingDataset);
createResultTable(jsonData,ratingDataset);
% -------------------generate recommendation list end ---------------------

save('./Output/52weeks_EqualWidth_5scale_2edge.mat',...
    'pearsonNeighborMatrix','MAEandRMAEArray',...
    'confusionMatrix','TPR','FPR','Precision','Accuracy');

disp('test');



