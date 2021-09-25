Exercise: 1 (Serge I: 2002-09-30)
Find the model number, speed and hard drive capacity for all the PCs with prices below $500.
Result set: model, speed, hd.

Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, screen, price)
Printer(code, model, color, type, price)
The Product table contains data on the maker, model number, and type of product ('PC', 'Laptop', or 'Printer'). It is assumed that model numbers in the Product table are unique for all makers and product types. Each personal computer in the PC table is unambiguously identified by a unique code, and is additionally characterized by its model (foreign key referring to the Product table), processor speed (in MHz) – speed field, RAM capacity (in Mb) - ram, hard disk drive capacity (in Gb) – hd, CD-ROM speed (e.g, '4x') - cd, and its price. The Laptop table is similar to the PC table, except that instead of the CD-ROM speed, it contains the screen size (in inches) – screen. For each printer model in the Printer table, its output type (‘y’ for color and ‘n’ for monochrome) – color field, printing technology ('Laser', 'Jet', or 'Matrix') – type, and price are specified.

PRODUCT TABLE:

maker|model|type   |
-----+-----+-------+
B    |1121 |PC     |
A    |1232 |PC     |
A    |1233 |PC     |
E    |1260 |PC     |
A    |1276 |Printer|
D    |1288 |Printer|
A    |1298 |Laptop |
C    |1321 |Laptop |
A    |1401 |Printer|
A    |1408 |Printer|
D    |1433 |Printer|
E    |1434 |Printer|
B    |1750 |Laptop |
A    |1752 |Laptop |
E    |2112 |PC     |
E    |2113 |PC     |


PRINTER TABLE:

code|model|color|type  |price |
----+-----+-----+------+------+
   1|1276 |n    |Laser |400.00|
   2|1433 |y    |Jet   |270.00|
   3|1434 |y    |Jet   |290.00|
   4|1401 |n    |Matrix|150.00|
   5|1408 |n    |Matrix|270.00|
   6|1288 |n    |Laser |400.00|


PC TABLE

code|model|speed|ram|hd  |cd |price |
----+-----+-----+---+----+---+------+
   1|1232 |  500| 64| 5.0|12x|600.00|
   2|1121 |  750|128|14.0|40x|850.00|
   3|1233 |  500| 64| 5.0|12x|600.00|
   4|1121 |  600|128|14.0|40x|850.00|
   5|1121 |  600|128| 8.0|40x|850.00|
   6|1233 |  750|128|20.0|50x|950.00|
   7|1232 |  500| 32|10.0|12x|400.00|
   8|1232 |  450| 64| 8.0|24x|350.00|
   9|1232 |  450| 32|10.0|24x|350.00|
  10|1260 |  500| 32|10.0|12x|350.00|
  11|1233 |  900|128|40.0|40x|980.00|
  12|1233 |  800|128|20.0|50x|970.00|
  
LAPTOP TABLE

code|model|speed|ram|hd  |price  |screen|
----+-----+-----+---+----+-------+------+
   1|1298 |  350| 32| 4.0| 700.00|    11|
   2|1321 |  500| 64| 8.0| 970.00|    12|
   3|1750 |  750|128|12.0|1200.00|    14|
   4|1298 |  600| 64|10.0|1050.00|    15|
   5|1752 |  750|128|10.0|1150.00|    14|
   6|1298 |  450| 64|10.0| 950.00|    12|




SELECT model, speed, hd
FROM PC
WHERE price < 500



Exercise: 2 (Serge I: 2002-09-21)
List all printer makers. Result set: maker. 


SELECT maker
FROM Product
WHERE type = 'Printer'
GROUP BY maker

maker|
-----+
A    |
D    |
E    |


Exercise: 3 (Serge I: 2002-09-30)
Find the model number, RAM and screen size of the laptops with prices over $1000. 


SELECT model, ram, screen
FROM Laptop
WHERE price > 1000

model|ram|screen|
-----+---+------+
1750 |128|    14|
1298 | 64|    15|
1752 |128|    14|


Exercise: 4 (Serge I: 2002-09-21)
Find all records from the Printer table containing data about color printers. 

SELECT * FROM Printer WHERE color = 'y'


code|model|color|type|price |
----+-----+-----+----+------+
   2|1433 |y    |Jet |270.00|
   3|1434 |y    |Jet |290.00|

Exercise: 5 (Serge I: 2002-09-30)
Find the model number, speed and hard drive capacity of PCs cheaper than $600 having a 12x or a 24x CD drive. 

SELECT model, speed, hd
FROM PC
WHERE (price < 600) AND (cd = '12x' OR cd = '24x');

model|speed|hd  |
-----+-----+----+
1232 |  500|10.0|
1232 |  450| 8.0|
1232 |  450|10.0|
1260 |  500|10.0|


Exercise: 6 (Serge I: 2002-10-28)
For each maker producing laptops with a hard drive capacity of 10 Gb or higher, find the speed of such laptops. Result set: maker, speed. 

SELECT Product.maker, Laptop.speed 
FROM Product
INNER JOIN Laptop
ON Product.model = Laptop.model
WHERE Laptop.hd >= 10
GROUP BY Product.maker, Laptop.speed;

maker|speed|
-----+-----+
B    |  750|
A    |  600|
A    |  750|
A    |  450|


Exercise: 7 (Serge I: 2002-11-02)
Get the models and prices for all commercially available products (of any type) produced by maker B. 


SELECT PC.model AS model, PC.price AS price 
FROM PC
INNER JOIN Product
ON PC.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT Laptop.model AS model, Laptop.price AS price
FROM Laptop
INNER JOIN Product
ON Laptop.model = Product.model
WHERE Product.maker = 'B'
UNION
SELECT Printer.model AS model, Printer.price AS price
FROM Printer
INNER JOIN Product
ON Product.model = Printer.model 
WHERE Product.maker = 'B'
ORDER BY price DESC

model|price  |
-----+-------+
1750 |1200.00|
1121 | 850.00|




Exercise: 8 (Serge I: 2003-02-03)
Find the makers producing PCs but not laptops. 

SELECT maker
FROM Product 
WHERE maker NOT IN(
SELECT maker
FROM Product
WHERE Product.type = 'Laptop') AND type = 'PC'
GROUP BY maker;


maker|
-----+
E    |


Exercise: 9 (Serge I: 2002-11-02)
Find the makers of PCs with a processor speed of 450 MHz or more. Result set: maker. 

SELECT maker
FROM Product
INNER JOIN PC 
ON Product.model = PC.model 
WHERE PC.speed >= 450 AND Product.`type` = 'PC'
GROUP BY maker;

maker|
-----+
A    |
B    |
E    |


Exercise: 10 (Serge I: 2002-09-23)
Find the printer models having the highest price. Result set: model, price. 

SELECT Printer.model, Printer.price
FROM Printer
WHERE Printer.price IN (SELECT MAX(Printer.price) FROM Printer)
GROUP BY Printer.model, Printer.price;


model|price |
-----+------+
1276 |400.00|
1288 |400.00|

Exercise: 11 (Serge I: 2002-11-02)
Find out the average speed of PCs. 


SELECT AVG(PC.speed) 
FROM PC;

AVG(PC.speed)|
-------------+
     608.3333|
     
Exercise: 12 (Serge I: 2002-11-02)
Find out the average speed of the laptops priced over $1000. 

SELECT AVG(Laptop.speed) 
FROM Laptop
WHERE Laptop.price > 1000;

AVG(Laptop.speed)|
-----------------+
         700.0000|
         
         
Exercise: 13 (Serge I: 2002-11-02)
Find out the average speed of the PCs produced by maker A.

SELECT AVG(PC.speed) 
FROM PC
INNER JOIN Product 
ON Product.model = PC.model
WHERE Product.maker = 'A';


AVG(PC.speed)|
-------------+
     606.2500|

The database of naval ships that took part in World War II is under consideration. The database consists of the following relations:
Classes(class, type, country, numGuns, bore, displacement)
Ships(name, class, launched)
Battles(name, date)
Outcomes(ship, battle, result)
Ships in classes all have the same general design. A class is normally assigned either the name of the first ship built according to the corresponding design, or a name that is different from any ship name in the database. The ship whose name is assigned to a class is called a lead ship.
The Classes relation includes the name of the class, type (can be either bb for a battle ship, or bc for a battle cruiser), country the ship was built in, the number of main guns, gun caliber (bore diameter in inches), and displacement (weight in tons). The Ships relation holds information about the ship name, the name of its corresponding class, and the year the ship was launched. The Battles relation contains names and dates of battles the ships participated in, and the Outcomes relation - the battle result for a given ship (may be sunk, damaged, or OK, the last value meaning the ship survived the battle unharmed).
Notes: 1) The Outcomes relation may contain ships not present in the Ships relation. 2) A ship sunk can’t participate in later battles. 3) For historical reasons, lead ships are referred to as head ships in many exercises.4) A ship found in the Outcomes table but not in the Ships table is still considered in the database. This is true even if it is sunk.

CLASSES TABLE 

class         |type|country   |numGuns|bore|displacement|
--------------+----+----------+-------+----+------------+
Bismarck      |bb  |Germany   |      8|15.0|       42000|
Iowa          |bb  |USA       |      9|16.0|       46000|
Kongo         |bc  |Japan     |      8|14.0|       32000|
North Carolina|bb  |USA       |     12|16.0|       37000|
Renown        |bc  |Gt.Britain|      6|15.0|       32000|
Revenge       |bb  |Gt.Britain|      8|15.0|       29000|
Tennessee     |bb  |USA       |     12|14.0|       32000|
Yamato        |bb  |Japan     |      9|18.0|       65000|


OUTCOMES TABLE

ship           |battle        |result |
---------------+--------------+-------+
Bismarck       |North Atlantic|sunk   |
California     |Guadalcanal   |damaged|
California     |Surigao Strait|OK     |
Duke of York   |North Cape    |OK     |
Fuso           |Surigao Strait|sunk   |
Hood           |North Atlantic|sunk   |
King George V  |North Atlantic|OK     |
Kirishima      |Guadalcanal   |sunk   |
Prince of Wales|North Atlantic|damaged|
Rodney         |North Atlantic|OK     |
Schamhorst     |North Cape    |sunk   |
South Dakota   |Guadalcanal   |damaged|
Tennessee      |Surigao Strait|OK     |
Washington     |Guadalcanal   |OK     |
West Virginia  |Surigao Strait|OK     |
Yamashiro      |Surigao Strait|sunk   |


SHIPS TABLE

name           |class         |launched|
---------------+--------------+--------+
California     |Tennessee     |    1921|
Haruna         |Kongo         |    1916|
Hiei           |Kongo         |    1914|
Iowa           |Iowa          |    1943|
Kirishima      |Kongo         |    1915|
Kongo          |Kongo         |    1913|
Missouri       |Iowa          |    1944|
Musashi        |Yamato        |    1942|
New Jersey     |Iowa          |    1943|
North Carolina |North Carolina|    1941|
Ramillies      |Revenge       |    1917|
Renown         |Renown        |    1916|
Repulse        |Renown        |    1916|
Resolution     |Renown        |    1916|
Revenge        |Revenge       |    1916|
Royal Oak      |Revenge       |    1916|
Royal Sovereign|Revenge       |    1916|
South Dakota   |North Carolina|    1941|
Tennessee      |Tennessee     |    1920|
Washington     |North Carolina|    1941|
Wisconsin      |Iowa          |    1944|
Yamato         |Yamato        |    1941|


BATTLES TABLE


name          |date               |
--------------+-------------------+
#Cuba62a      |1962-10-20 00:00:00|
#Cuba62b      |1962-10-25 00:00:00|
Guadalcanal   |1942-11-15 00:00:00|
North Atlantic|1941-05-25 00:00:00|
North Cape    |1943-12-26 00:00:00|
Surigao Strait|1944-10-25 00:00:00|


Exercise: 14 (Serge I: 2002-11-05)
For the ships in the Ships table that have at least 10 guns, get the class, name, and country.
     
     
SELECT Ships.class, Ships.name, Classes.country 
FROM Ships
INNER JOIN Classes ON Classes.class = Ships.class
WHERE Classes.numGuns >= 10; 


class         |name          |country|
--------------+--------------+-------+
North Carolina|North Carolina|USA    |
North Carolina|South Dakota  |USA    |
North Carolina|Washington    |USA    |
Tennessee     |California    |USA    |
Tennessee     |Tennessee     |USA    |

Exercise: 15 (Serge I: 2003-02-03)
Get hard drive capacities that are identical for two or more PCs.
Result set: hd. 

SELECT PC.hd 
FROM PC
GROUP BY PC.hd
HAVING COUNT(*) > 1; 

hd  |
----+
 5.0|
14.0|
 8.0|
20.0|
10.0|

Exercise: 17 (Serge I: 2003-02-03)
Get the laptop models that have a speed smaller than the speed of any PC.
Result set: type, model, speed. 

SELECT Product.`type`, Product.model, Laptop.speed 
	FROM Product
	INNER JOIN Laptop ON Product.model = Laptop.model 
	WHERE Laptop.speed < ALL(
		SELECT PC.speed 
		FROM PC)
	GROUP BY Product.`type`, Product.model, Laptop.speed; 
	
type  |model|speed|
------+-----+-----+
Laptop|1298 |  350|



Exercise: 19 (Serge I: 2003-02-13)
For each maker having models in the Laptop table, find out the average screen size of the laptops he produces.
Result set: maker, average screen size. 

SELECT Product.maker, ANY_VALUE(AVG(Laptop.screen))
FROM Product
INNER JOIN Laptop ON Product.model = Laptop.model
WHERE Product.`type` = 'Laptop'
GROUP BY Product.maker;

maker|ANY_VALUE(AVG(Laptop.screen))|
-----+-----------------------------+
A    |                      13.0000|
C    |                      12.0000|
B    |                      14.0000|


Exercise: 20 (Serge I: 2003-02-13)
Find the makers producing at least three distinct models of PCs.
Result set: maker, number of PC models.

SELECT Product.maker, COUNT(DISTINCT Product.model) AS Models
FROM Product
WHERE Product.`type` = 'PC'
GROUP BY Product.maker
HAVING COUNT(DISTINCT Product.model) > 2; 

maker|Models|
-----+------+
E    |     3|


Exercise: 21 (Serge I: 2003-02-13)
Find out the maximum PC price for each maker having models in the PC table. Result set: maker, maximum price. 


SELECT Product.maker, MAX(PC.price) AS Max_price
FROM Product
INNER JOIN PC ON PC.model = Product.model 
GROUP BY Product.maker


maker|Max_price|
-----+---------+
A    |   980.00|
B    |   850.00|
E    |   350.00|






