function [ jsonData ] = saveJsonFile( pearsonPredictedResult,ratingDataset)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    jsonData = struct;
    for numOfUser = 1 : length(pearsonPredictedResult(:,1))
        
        
            userInfo = pearsonPredictedResult{numOfUser,1};
            if ~isempty(pearsonPredictedResult{numOfUser,1}{1})
                recommendations = find(cell2mat(userInfo(:,3)) >= 2);
            else
                recommendations = [];   
            end
            jsonData.(ratingDataset{numOfUser}) = [];
            if ~isempty(recommendations)
                
                for numOfTrack = 1 : length(recommendations)
                jsonData.(ratingDataset{numOfUser}) = ...
                    [jsonData.(ratingDataset{numOfUser}) ...
                    pearsonPredictedResult{numOfUser}(recommendations(numOfTrack))];
                end
            end
        
    end
    
    savejson('Recommendation List',jsonData,'MusicReccomendation.json');


end

