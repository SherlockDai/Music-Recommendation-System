function createResultTable( jsonData,ratingDataset )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
resultData = cell(50,length(ratingDataset(:,1)));
resultData(:) = {'NULL'};

    for numOfUser = 1 : length(ratingDataset(:,1))
    
        userName = ratingDataset{numOfUser,1};
        userData = jsonData.(userName);
        if isempty(userData)
            resultData(1,numOfUser) = {'NULL'};
        else
            for numOfTrack = 1 : length(userData)
                resultData(numOfTrack,numOfUser) = userData(numOfTrack);
            end
        end
        
            
       
    end
    userNames = ratingDataset(:,1);
scrsz = get(groot,'ScreenSize');
f = figure('Position',[1 scrsz(4)/2 scrsz(3)/3 scrsz(4)/3]);
    t = uitable(f,'Data',resultData, 'ColumnName',userNames');

end

