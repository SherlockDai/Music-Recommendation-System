ratingDataset = load('./Data/ratingDataset.mat');
ratingDataset = ratingDataset.combinedDataset;
<<<<<<< HEAD
trackIdx = 1:1:length(ratingDataset{1,2}{1,1});
playcountsArray = cell2mat(ratingDataset{1,2}{1,1}(:,2));
ratingArray = cell2mat(ratingDataset{1,2}{1,1}(:,4));
=======
trackIdx = 1:1:length(ratingDataset{10,2}{1,1});
playcountsArray = cell2mat(ratingDataset{10,2}{1,1}(:,2));
ratingArray = cell2mat(ratingDataset{10,2}{1,1}(:,4));
>>>>>>> d9842f617908bc25f4a07aed1ebc6e7d9f06c201
figure(1);
bar(trackIdx,ratingArray);
xlabel('Track index');
ylabel('Rating');
<<<<<<< HEAD
title('SaulCLRadiohead''s tarcks'' rating');
=======
title('Arlaug''s tarcks'' rating');
>>>>>>> d9842f617908bc25f4a07aed1ebc6e7d9f06c201

figure(2);
plot(trackIdx,playcountsArray);
xlabel('Track index');
ylabel('Play counts');
<<<<<<< HEAD
title('SaulCLRadiohead''s tarcks'' play counts');
=======
title('Arlaug''s tarcks'' play counts');
>>>>>>> d9842f617908bc25f4a07aed1ebc6e7d9f06c201
