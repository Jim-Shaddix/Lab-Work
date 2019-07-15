
people(1).name = 'dad';
people(1).age = 52;
people(2).name = 'mom';
people(2).age = 50;
people(3).name = 'laurel';
people(3).age = 25;
people(4).name = 'tom';
people(4).age = 19;
people(5).name = 'bil';
people(5).age = 21;
people(6).name = 'jim';
people(6).age = 23;

people(7).name = 'zzzRand';
people(7).age  = 1000;
people(8).name = 'zzzRand';
people(8).age  = 10;
people(9).name = 'zzzRand';
people(9).age  = 1;
people(10).name = 'zzzRand';
people(10).age  = 100;

new_people = nestedSortStruct(people, {'name','age'}, [1,1]);
aTable = struct2table(new_people); 
disp(aTable);
