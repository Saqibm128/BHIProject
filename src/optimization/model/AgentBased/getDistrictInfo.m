function districts = getDistrictInfo(countryChoice)
%% districts is a data structure which represents info about West Africa Pop
%% countryChoice 1 if Guinea, 2 if Sierra Leone, 3 if Liberia

districts = struct;
if countryChoice == 1
districts.Kindia = struct;
districts.Kindia.population = 181126;
districts.Kindia.neighbors = {'Boke', 'Labe', 'Mamou'};
districts.Boke = struct;
districts.Boke.population =  61449;
districts.Boke.neighbors = {'Kindia', 'Labe', 'Mamou'};
districts.Labe = struct;
districts.Labe.population = 200000;
districts.Labe.neighbors = {'Boke', 'Kindia', 'Mamou', 'Faranah'};
districts.Faranah = struct;
districts.Faranah.neighbors = {'Labe', 'Mamou', 'Kankan', 'Nzerekore'};
districts.Faranah.population = 78108;
districts.Kankan = struct;
districts.Kankan.neighbors = {'Faranah', 'Nzerekore'};
districts.Kankan.population = 193830;
districts.Nzerekore = struct;
districts.Nzerekore.neighbors = {'Faranah', 'Kankan'};
districts.Nzerekore.population = 107329;
districts.Mamou = struct;
districts.Mamou.neighbors = {'Labe','Kindia','Faranah'};
districts.Mamou.population = 3184;
else
    if countryChoice == 2
        districts.Koinadugu = struct;
        districts.Koinadugu.neighbors = {'Bombali', 'Tonkolili', 'Kono'};
        districts.Koinadugu.population = 404097;
        districts.Bombali = struct;
        districts.Bombali.neighbors = {'Koinadugu', 'Tonkolili', 'PortLoko', 'Kambia'};
        districts.Bombali.population = 606183;
        districts.Kambia = struct;
        districts.Kambia.neighbors = {'Bombali', 'Port Loko'};
        districts.Kambia.population = 343686;
        districts.PortLoko = struct;
        districts.PortLoko.neighbors = {'Kambia', 'Bombali', 'Tonkolili', 'Moyamba'};
        districts.PortLoko.population = 23915;
        districts.Tonkolili = struct;
        districts.Tonkolili.neighbors = {'PortLoko', 'Bombali', 'Koinadugu', 'Kono', 'Kenema', 'Bo', 'Moyamba'};
        districts.Tonkolili.population = 530776;
        districts.Kono = struct;
        districts.Kono.neighbors = {'Koinadugu', 'Tonkolili', 'Kenema', 'Kailahun'};
        districts.Kono.population = 505767;
        districts.Moyamba = struct;
        districts.Moyamba.neighbors = {'PortLoko', 'Tonkolili', 'Bo', 'Bonthe'};
        districts.Moyamba.population = 11485;
        districts.Bo = struct;
        districts.Bo.neighbors = {'Tonkolili', 'Kenema', 'Pujehun', 'Bonthe', 'Moyamba'};
        districts.Bo.population = 306000;
        districts.Kenema = struct;
        districts.Kenema.neighbors = {'Kailahun', 'Kono', 'Tonkolili', 'Bo', 'Pujehun'};
        districts.Kenema.population = 200354;
        districts.Kailahun = struct;
        districts.Kailahun.neighbors =  {'Kono', 'Kenema'};
        districts.Kailahun.population = 30411;
        districts.Bonthe = struct;
        districts.Bonthe.neighbors = {'Moyamba', 'Bo', 'Pujehun'};
        districts.Bonthe.population = 10206;
        districts.Pujehun = struct;
        districts.Pujehun.population = 30000;
        districts.Pujehun.neighbors = {'Kenema', 'Bo', 'Bonthe'};
    else
        districts.Bomi = struct;
        districts.Bomi.neighbors = {'Grand Cape Mount', 'Gbarpolu', 'Montserrado'};
        districts.Bomi.population = 84119;
        districts.Bong = struct;
        districts.Bong.population = 328919;
        districts.Bong.neighbors = {'Lofa', 'Gbarpolu', 'Montserrado', 'Margibi', 'GrandBassa', 'Nimba'};
        districts.Gbarpolu = struct;
        districts.Gbarpolu.population = 83758;
        districts.Gbarpolu.neighbors = {'Lofa', 'Bong', 'Bomi', 'GrandCapeMount'};
        districts.GrandCapeMount = struct;
        districts.GrandCapeMount.population = 129817;
        districts.GrandCapeMount.neighbors = {'Gbarpolu', 'Bomi'};
        districts.Lofa = struct;
        districts.Lofa.population = 276863;
        districts.Lofa.neighbors = {'Gbarpolu', 'Bong'};
        districts.Montserrado = struct;
        districts.Montserrado.neighbors = {'Bomi' , 'Bong', 'Margibi'};
        districts.Montserrado.population = 1145000;
        districts.Margibi = struct;
        districts.Margibi.neighbors = {'Montserrado', 'Bong', 'GrandBassa'};
        districts.Margibi.population = 199689;
        districts.GrandBassa = struct;
        districts.GrandBassa.population = 224839;
        districts.GrandBassa.neighbors = {'Margibi', 'Bong', 'Nimba', 'RiverCess'};
        districts.Nimba = struct;
        districts.Nimba.population = 462026;
        districts.Nimba.neighbors = {'Bong', 'GrandBassa', 'RiverCess', 'Sinoe', 'GrandGedeh'};
        districts.RiverCess = struct;
        districts.RiverCess.population = 71509; 
        districts.RiverCess.neighbors = {'GrandBassa' ,'Nimba', 'GrandGedeh', 'Sinoe'};
        districts.Sinoe = struct;
        districts.Sinoe.population = 104932;
        districts.Sinoe.neighbors = {'RiverCess', 'Nimba', 'GrandGedeh', 'RiverGee', 'GrandKru'};
        districts.GrandGedeh = struct;
        districts.GrandGedeh.population = 126146;
        districts.GrandGedeh.neighbors = {'Nimba', 'RiverCess','Sinoe','RiverGee'};
        districts.RiverGee = struct;
        districts.RiverGee.population = 66789;
        districts.RiverGee.neighbors = {'GrandGedeh', 'Sinoe', 'GrandKru', 'Maryland'};
        districts.GrandKru = struct;
        districts.GrandKru.population = 57106;
        districts.GrandKru.neighbors = {'Sinoe', 'RiverGee', 'Maryland'};
        districts.Maryland = struct;
        districts.Maryland.population = 163404;
        districts.Maryland.neighbors = {'RiverGee', 'GrandKru'};
    end
end

for i = 1:length(fieldnames(districts))
    fields = fieldnames(districts);
    d = districts.(genvarname(fields{i}));
    a = districts.(genvarname(fields{i})).population;
    for j = 1:length(d.neighbors);
        neighb = d.neighbors{j};
        b = districts.(genvarname(neighb));
    end
end