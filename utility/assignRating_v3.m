function [ data ] = assignRating_v3( data )

playcountsArray = cell2mat(data(:,2));
playcountsCategories = unique(playcountsArray);
playcountSortation = [playcountsCategories,histc(playcountsArray(:),playcountsCategories)];
totalPlayCounts = sum(playcountSortation(:,2));

% calculate standard diviation
sigma = std(cell2mat(data(:,2)),1);

% calcualte average
mu = mean(cell2mat(data(:,2)));

% calculate Coefficient of variation
CV = sigma/mu;

if CV < 0.5
    
    ratings = cell(1,length(data(:,1)));
    ratings(:) = {3};
    data = [data ratings'];
    
else

    [~, ~, ~, edges] = sshist(playcountSortation(:,2),5);

    for numOfPlaycountsCategories = 1 : length(playcountSortation(:,1))

        currentPlayCounts = playcountSortation(numOfPlaycountsCategories,2);

        if currentPlayCounts <= edges(2) && currentPlayCounts >= edges(1)

            playcountSortation(numOfPlaycountsCategories,3) = 5;


        elseif currentPlayCounts <= edges(3) && currentPlayCounts >= edges(2)

            playcountSortation(numOfPlaycountsCategories,3) = 4;


        elseif currentPlayCounts <= edges(4) && currentPlayCounts >= edges(3)

            playcountSortation(numOfPlaycountsCategories,3) = 3;


        elseif currentPlayCounts <= edges(5) && currentPlayCounts >= edges(4)

            playcountSortation(numOfPlaycountsCategories,3) = 2;

        elseif currentPlayCounts <= edges(6) && currentPlayCounts >= edges(5)

            playcountSortation(numOfPlaycountsCategories,3) = 1;

        end

    end

    for numOfTracks = 1 : length(data(:,1))

        idxOfPlayCounts = find(data{numOfTracks,2} == playcountSortation(:,1));
        rating = playcountSortation(idxOfPlayCounts,3);
        data{numOfTracks,4} = rating;

    end

end

