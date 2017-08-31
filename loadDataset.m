%--------------------------------------------------------------------------
%loadDataset    load json dataset and convert it into a better dataset
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

%------------------ system initialization ---------------------------------
MRS_startup
warning off
dbstop if error

%------------------ read configuration file -------------------------------
configFile = './preamble/configuration.ini';
[homePath, dataRootPath, outputPath, ~] = loadGlobalPathSetting(configFile);

%---------------------------- read data -----------------------------------
dataset = load([dataRootPath 'jsonDataset.mat']);
dataset = dataset.dataset;
usernames = load([dataRootPath 'usernames.mat']);
usernames = usernames.usernames;

% get the size of the users
userSize = size(dataset);
userSize = userSize(1,1);

i = 1; 
while i < userSize + 1
    weekSize = size(dataset{i});
    weekSize = weekSize(1,2);
    dataset{i} = transpose(dataset{i});
    
    j = 1; numOfEmptyWeek = 0;
    while j < weekSize + 1
        dataset{i}{j} = struct2cell(dataset{i}{j});
        dataset{i}{j} = clearEmptyMbid(cell2mat(dataset{i}{j}{1}));
        if isempty(dataset{i}{j})
            dataset{i}{j} = {};
            numOfEmptyWeek = numOfEmptyWeek +1;
        else
            dataset{i}{j} = table2array(struct2table(dataset{i}{j}));
        end
        j = j + 1;
    end
    
    % delete the user if num of the empty week > weekSize - 12 ||
    % at least have 12 weeks' data
    if numOfEmptyWeek > weekSize - 12
        dataset(i) = [];
        usernames(i) = [];
        userSize = userSize - 1;
        i = i -1;
    end
    i = i + 1;
end

usernames(:,2) = dataset(:,1);
dataset = usernames;

for i = 1 : userSize
    for j = 1 : size(dataset{i,2})
        for k = 1 : size(dataset{i,2}{j,1})
            if ischar(dataset{i,2}{j,1})
                dataset{i,2}{j,1} = [];
            else
                dataset{i,2}{j,1}{k,2} = str2num(dataset{i,2}{j,1}{k,2});
            end
        end
    end
end

save([dataRootPath 'dataset.mat'], 'dataset');
delete([dataRootPath 'usernames.mat']);

