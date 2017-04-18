function districts = getDistrictInfo()
%% districts is a data structure which represents info about West Africa Pop
%% 

districts = struct;
districts.Kindia = struct;
districts.Kindia.population = 181126;
districts.Kindia.neighbors = {'Boke', 'Labe', 'Mamou'};
districts.Boke = struct;
districts.Boke.population =  61449;
districts.Boke.neighbors = {'Kindia', 'Labe', 'Mamou'};
districts.Labe = struct;
districts.Labe.population = 200000;
districts.Labe.neighbors = {};