<<<<<<< HEAD
result = load('./Output/26weeks_EqualWidth_5scale_2weeks.mat');
MAEarray = result.MAEandRMAEArray(1:174,1);
=======
result = load('./Output/52weeks_EqualWidth_5scale_2edge_v1.mat');
MAEarray = result.MAEandRMAEArray(1:190,1);
>>>>>>> d9842f617908bc25f4a07aed1ebc6e7d9f06c201
numOfUser = 1;
while numOfUser < length(MAEarray)
    if MAEarray(numOfUser) == 0
         MAEarray(numOfUser) = [];
         numOfUser = numOfUser - 1;
    end
    numOfUser = numOfUser + 1;
end

<<<<<<< HEAD
RMAEarray = result.MAEandRMAEArray(1:174,2);
=======
RMAEarray = result.MAEandRMAEArray(1:190,2);
>>>>>>> d9842f617908bc25f4a07aed1ebc6e7d9f06c201
numOfUser = 1;
while numOfUser < length(RMAEarray)
    if RMAEarray(numOfUser) == 0
         RMAEarray(numOfUser) = [];
         numOfUser = numOfUser - 1;
    end
    numOfUser = numOfUser + 1;
end

figure(1);
plot(MAEarray);
xlabel('User index');
ylabel('MAE');

figure(2);
plot(RMAEarray);
xlabel('User index');
ylabel('RMAE');