
INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('496be445-8701-4718-a4c0-c9a2d5f5676c', '6726025c-c216-4846-a277-7c4474860331', 'lesson', N'Python is an interpreted, high-level programming language known for its readability and 
simplicity. Unlike languages such as C or Java, Python relies on indentation (whitespace) to 
define blocks of code, rather than braces {}. 
Variables 
• Variables in Python are created when a value is assigned to a name. 
• Python is dynamically typed, meaning you don’t declare a variable type in advance. 
*insert code example below* 
x = 5       # int 
y = 3.14    # float 
name = "Ali" # string 
Data Types 
• int → whole numbers (e.g., 10, -3) 
• float → decimal numbers (e.g., 3.14, -2.5) 
• str → text (e.g., "hello") 
• bool → logical values True / False 
• NoneType → absence of a value (None) 
*insert code example below* 
a = True 
b = None 
print(type(a), type(b))  # <class ''bool''> <class ''NoneType''> 
  

Input & Output 
• input() → reads input as a string. 
• print() → displays output; supports arguments like sep and end. 
*insert code example below* 
name = input("Enter your name: ") 
print("Hello,", name) 
Type Conversion 
Convert between types using constructors: 
*insert code example below* 
age = int("20")     # string → int 
pi = float("3.14")  # string → float 
s = str(42)         # int → string 
Strings & Slicing 
• Strings are sequences → can be indexed and sliced. 
• Negative indexing allows access from the end. 
*insert code example below* 
s = "Python" 
print(s[0])     # P 
print(s[-1])    # n 
print(s[1:4])   # yth 
Comments 
• Single-line: # comment 
• Multi-line: triple quotes """ comment """');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('f9579fd7-08e2-403f-8cfd-988d5b9dd0f1', '6726025c-c216-4846-a277-7c4474860331', 'flashcard', 'Basics (Syntax, Variables, Data Types, I/O) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('8e001a06-149e-474b-becf-67b8849e5306', '6726025c-c216-4846-a277-7c4474860331', 'mcq', 'Basics (Syntax, Variables, Data Types, I/O) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('b7f52ad6-aa2d-4aed-8c2f-61f3bba869a0', '88a180a2-2c08-42a7-a890-1e8747b30031', 'lesson', N'Control flow determines how Python executes code based on conditions or repetition. 
Conditional Statements 
• if/elif/else → used for decision making. 
*insert code example below* 
age = 20 
if age >= 18: 
    print("Adult") 
elif age >= 13: 
    print("Teen") 
else: 
    print("Child") 
Loops 
• for loop → iterates over iterables (lists, strings, dicts). 
*insert code example below* 
for i in range(3): 
    print(i)   # 0,1,2 
• while loop → continues until condition is False. 
*insert code example below* 
n = 3 
while n > 0: 
    print(n) 
    n -= 1 

Loop Control Keywords 
• break → exit loop early. 
• continue → skip current iteration. 
• pass → placeholder, does nothing. 
Truthy and Falsy Values 
• Falsy: 0, "", None, [], {}, set(). 
• Truthy: most non-empty values. 
Comprehensions 
• Short syntax for building lists, sets, or dicts. 
*insert code example below* 
nums = [1,2,3,4,5] 
squares = [n*n for n in nums if n % 2 == 0] 
print(squares)  # [4, 16]');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('62412cc5-beeb-447d-ac6b-8cd0faae1237', '88a180a2-2c08-42a7-a890-1e8747b30031', 'flashcard', 'Control Flow (if/elif, loops, comprehensions) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('1964b3eb-b0a6-4082-b31d-6b9d88f66baa', '88a180a2-2c08-42a7-a890-1e8747b30031', 'mcq', 'Control Flow (if/elif, loops, comprehensions) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('1ef72c17-8604-405a-8fb3-9e68519bd889', '4a1ba0c6-6dc2-4ca9-8e77-c34ca3ae8f35', 'lesson', N'Functions let you organise code into reusable blocks, while modules allow you to reuse 
code across programs. 
Defining Functions 
• Use def keyword: 
*insert code example below* 
def greet(name): 
    return f"Hello, {name}!" 
Parameters & Arguments 
• Positional arguments → passed in order. 
• Keyword arguments → passed by name. 
• Default values → used when not provided. 
*insert code example below* 
def area_circle(r, pi=3.14): 
    return pi * r * r 
print(area_circle(2))       # 12.56 
print(area_circle(2, 3.14159))  # 12.56636 
• *args → packs extra positional arguments as a tuple. 
• **kwargs → packs extra keyword arguments as a dict. 
*insert code example below* 
def demo(*args, **kwargs): 
    print(args, kwargs) 
demo(1,2,3, a=10, b=20) 

Return Values 
• Functions may return single or multiple values. 
*insert code example below* 
def swap(a, b): 
    return b, a 
x, y = swap(1,2)   # x=2, y=1 
Scope 
• Local: inside function. 
• Global: outside any function. 
• Use global keyword to modify global variables (not recommended often). 
Docstrings 
• Triple quotes after def describe the function. 
• Accessible via help(function). 
Modules 
• A Python file (.py) containing code. 
• Importing: 
*insert code example below* 
import math 
print(math.sqrt(16)) 
• Aliases: import math as m. 
• Selective import: from math import sqrt. 
Virtual Environments & pip 
• Virtual environment → isolated Python environment for projects. 
• pip installs packages: 

*insert code example below* 
pip install requests');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('a943620d-1aa7-46ab-9dbc-629f2853b9ea', '4a1ba0c6-6dc2-4ca9-8e77-c34ca3ae8f35', 'flashcard', 'Functions & Modules Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('f9f6169b-91c6-453a-a7a8-8c01c82049dd', '4a1ba0c6-6dc2-4ca9-8e77-c34ca3ae8f35', 'mcq', 'Functions & Modules Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('1bdc00f9-cf7c-4a5c-8317-b9bbb2adf6a7', 'd03876a5-8c5d-46b4-bdb8-f416f291cae0', 'lesson', N'Data structures are containers that store and organise data. Python provides powerful built-
ins: 
Lists 
• Ordered, mutable sequences. 
• Common operations: 
*insert code example below* 
nums = [1,2,3] 
nums.append(4)       # [1,2,3,4] 
nums.pop()           # [1,2,3] 
nums.sort()          # in-place 
Tuples 
• Ordered, immutable sequences. 
• Used for fixed data or as keys in dictionaries. 
*insert code example below* 
point = (3,4) 
print(point[0])   # 3 
Dictionaries 
• Key-value mappings. 
• Fast lookups. 
*insert code example below* 
ages = {"Ali":20, "Bala":22} 
print(ages["Ali"])         # 20 

print(ages.get("Chong",0)) # safe access 
Sets 
• Unordered collection of unique elements. 
*insert code example below* 
letters = set("balloon") 
print(letters)   # {''b'',''a'',''l'',''o'',''n''} 
• Operations: union (|), intersection (&), difference (-). 
Copying 
• list(a) / a[:] → shallow copy. 
• copy.deepcopy() → deep copy (nested structures).');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('91ae0acd-81df-4ee7-ac73-169b7d0dc8ef', 'd03876a5-8c5d-46b4-bdb8-f416f291cae0', 'flashcard', 'Data Structures (Lists, Tuples, Dicts, Sets) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('81a8d3c7-c96f-42af-a618-601baad05c41', 'd03876a5-8c5d-46b4-bdb8-f416f291cae0', 'mcq', 'Data Structures (Lists, Tuples, Dicts, Sets) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('2cf9fde3-b5c4-4b1e-84b6-2028479193b1', '52e3d2b6-b7a2-46a7-9a9c-99e80cef3275', 'lesson', N'Object-Oriented Programming (OOP) in Python helps you model real-world entities using 
classes and objects. Exceptions let you handle errors gracefully. 
Classes & Objects 
• Class → blueprint for objects. 
• Object → instance of a class. 
*insert code example below* 
class Dog: 
    def __init__(self, name): 
        self.name = name 
    def bark(self): 
        print(f"{self.name} says woof!") 
 
d = Dog("Buddy") 
d.bark() 
Methods 
• Instance methods → take self. 
• Class methods → take cls, defined with @classmethod. 
• Static methods → no self or cls, defined with @staticmethod. 
Encapsulation 
• Hide details using naming conventions: 
o _var → protected (convention). 
o __var → name-mangled. 
 

Inheritance & Polymorphism 
• Inheritance → create new classes from existing ones. 
• Polymorphism → same method name, different behaviours. 
*insert code example below* 
class Animal: 
    def speak(self): print("Generic sound") 
 
class Cat(Animal): 
    def speak(self): print("Meow") 
Exceptions 
• try/except → catch errors. 
• else → runs if no error. 
• finally → always runs. 
*insert code example below* 
try: 
    x = 10/0 
except ZeroDivisionError: 
    print("You can’t divide by zero!") 
finally: 
    print("Done") 
• Custom exceptions can be created by inheriting from Exception.');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('4be11bbe-7a3c-4325-b300-70211cb39be9', '52e3d2b6-b7a2-46a7-9a9c-99e80cef3275', 'flashcard', 'OOP & Exceptions Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('eb67e2b9-1cea-4161-a49f-d315d939f80d', '52e3d2b6-b7a2-46a7-9a9c-99e80cef3275', 'mcq', 'OOP & Exceptions Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('649a85a2-1a6f-49cd-829b-3dddf7012e9a', '32026dab-05cf-411c-8688-9e820d7f81a8', 'lesson', N'In Python, you can read and write files easily by using the open() function. This allows your 
programs  to  store  information  permanently,  instead  of  losing  data  each  time  the  program 
stops.   Exception   handling   helps   you   prevent   your   program   from   crashing   when   an 
unexpected error occurs, such as a missing file or invalid input. 
 
Opening Files 
The open() function  is  used  to  open  a  file.  It  requires  the  file  name  and  the  mode  of 
operation. 
*insert code example below* 
Example: 
f = open("data.txt", "r") 
Common Modes: 
Mode Description 
"r" 
Opens the file for reading. The file must already exist. 
"w" 
Opens the file for writing. If the file exists, it will be overwritten. 
"a" 
Opens the file for appending. New data will be added to the end of the file. 
"r+" 
Opens the file for both reading and writing. 
"b" 
Used with other modes for binary files, for example "rb" or "wb". 
 
Reading Files 
You can read the contents of a file using the read() method: 

*insert code example below* 
f = open("data.txt", "r") 
content = f.read() 
print(content) 
f.close() 
Other useful methods: 
• f.readline() reads a single line. 
• f.readlines() reads all lines and returns them as a list. 
 
Writing to Files 
The "w" mode allows you to write data to a file. If the file does not exist, it will be created. If 
it does exist, the contents will be replaced. 
*insert code example below* 
f = open("data.txt", "w") 
f.write("Hello World!\n") 
f.close() 
If you want to add new data without deleting the old data, use the "a" mode: 
*insert code example below* 
with open("log.txt", "a") as f: 
    f.write("New entry added.\n") 
 
Using “with open()” 
The with statement  is  a  better  and  safer  way  to  handle  files.  It  automatically  closes  the  file 
once you are done, even if an error occurs. 
*insert code example below* 

Example: 
with open("notes.txt", "r") as f: 
    data = f.read() 
print("File closed automatically.") 
 
Working with Binary Files 
Binary files store data such as images or audio. To work with them, use binary mode ("rb" or 
"wb"). 
*insert code example below* 
with open("image.png", "rb") as f: 
    bytes_data = f.read() 
 
Exception Handling 
When  a  Python  program  faces  an  error,  it  normally  stops  running  and  shows  an  error 
message.  This  can  be  avoided  using  exception  handling.  The try and except blocks  allow 
you to “catch” and handle errors gracefully. 
*insert code example below* 
Example: 
try: 
    f = open("missing.txt") 
except FileNotFoundError: 
    print("The file does not exist.") 
 
Handling Multiple Exceptions 
You  can  catch  different  types  of  errors  in  the  same try block  by  separating  them  with 
commas. 

*insert code example below* 
try: 
    x = int("hi") 
except (ValueError, TypeError) as e: 
    print("Error:", e) 
 
Using else and finally 
• The else block runs only when no errors occur. 
• The finally block always runs, even if there is an error. 
*insert code example below* 
Example: 
try: 
    f = open("data.txt") 
except FileNotFoundError: 
    print("File missing!") 
else: 
    print("File opened successfully.") 
finally: 
    print("Operation completed.") 
 
Raising Exceptions Manually 
You can create your own error message using the raise keyword. 
*insert code example below* 
x = -1 
if x < 0: 
    raise ValueError("x cannot be negative") 
 
Creating Custom Exceptions 

You can create your own exception class by inheriting from the Exception class. 
*insert code example below* 
class MyError(Exception): 
    pass 
 
raise MyError("A custom error occurred.")');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('ae886e69-f8e1-40fe-83d5-113d470e4ac8', '32026dab-05cf-411c-8688-9e820d7f81a8', 'flashcard', 'File Handling and Exceptions Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('7d5b28b1-f6d3-4934-8f12-06b07fecf5a3', '32026dab-05cf-411c-8688-9e820d7f81a8', 'mcq', 'File Handling and Exceptions Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('b1ec5811-ea22-4919-8553-84fb3969e652', '8e4fa95b-511c-4ecd-9759-8b60c1dd4c11', 'lesson', N'Python  has  many  built-in  and  external  libraries  that  make  coding  easier  and  more  powerful. 
A library is  a  collection  of  ready-made  functions  and  modules  that  help  you  perform  tasks 
without writing all the code yourself. 
You can import these libraries using the import statement. 
 
Using the math Library 
The math library   provides   mathematical   functions   such   as   square   roots,   powers, 
trigonometric functions, and constants like π (pi) and e. 
*insert code example below* 
Example: 
import math 
 
print(math.sqrt(16))     # 4.0 
print(math.pow(2, 3))    # 8.0 
print(math.pi)           # 3.141592653589793 
print(math.ceil(4.2))    # 5 
print(math.floor(4.8))   # 4 
Common math functions: 
Function Description Example 
math.sqrt(x) 
Returns the square root √25 → 5 
math.pow(a, b) 
Raises a to the power of b 2³ → 8 
math.floor(x) 
Rounds down to nearest integer 4.8 → 4 
math.ceil(x) 
Rounds up to nearest integer 4.2 → 5 
math.pi 
Constant for π (3.14159) 
 

Function Description Example 
math.e 
Constant for Euler’s number (2.718) 
 
 
Using the random Library 
The random library is used to generate random numbers, shuffle data, and pick random items. 
It is useful in games, simulations, and data sampling. 
*insert code example below* 
Example: 
import random 
 
print(random.random())         # Random float between 0 and 1 
print(random.randint(1, 10))   # Random integer between 1 and 10 
print(random.choice([''red'',  ''green'',  ''blue'']))    #  Randomly  picks  one 
element 
Common random functions: 
Function Description 
random.random() 
Returns a random float between 0 and 1 
random.randint(a, b) 
Returns a random integer between a and b 
random.choice(list) 
Picks a random element from a list 
random.shuffle(list) 
Randomly shuffles the items in a list 
random.uniform(a, b) 
Returns a random float between a and b 
*insert code example below* 
Example: 
colors = [''red'', ''green'', ''blue''] 
random.shuffle(colors) 
print(colors) 
 

Using the NumPy Library 
NumPy (Numerical  Python)  is  a  powerful  library  for  numerical  computation  and  array 
manipulation. It is widely used in data science, AI, and machine learning. 
To use NumPy, it must first be installed using the command: 
*insert code example below* 
pip install numpy 
Then import it: 
*insert code example below* 
import numpy as np 
Creating Arrays 
Arrays in NumPy are similar to lists but faster and more efficient. 
*insert code example below* 
import numpy as np 
 
arr = np.array([1, 2, 3, 4]) 
print(arr) 
Array Operations 
NumPy supports mathematical operations directly on arrays: 
*insert code example below* 
arr = np.array([1, 2, 3]) 
print(arr + 5)      # [6 7 8] 
print(arr * 2)      # [2 4 6] 
print(np.sum(arr))  # 6 
Multi-dimensional Arrays 

NumPy supports 2D and 3D arrays: 
*insert code example below* 
matrix = np.array([[1, 2], [3, 4]]) 
print(matrix) 
print(matrix.shape)   # (2, 2) 
print(np.transpose(matrix))  # swaps rows and columns 
Useful NumPy Functions 
Function Description 
np.zeros(n) 
Creates an array of zeros 
np.ones(n) 
Creates an array of ones 
np.arange(start, stop, step) 
Creates a range of numbers 
np.mean(arr) 
Finds the average value 
np.max(arr) 
Returns the maximum value 
np.min(arr) 
Returns the minimum value 
 
Importing with Aliases 
You can rename a library to make it shorter: 
*insert code example below* 
import numpy as np 
import random as rnd 
import math as m 
This makes the code easier to read and type. 
 
Installing External Libraries 
Some libraries (like NumPy or Pandas) are not built into Python. You can install them using: 

*insert code example below* 
pip install library_name 
Example: 
*insert code example below* 
pip install numpy');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('3d2d15f9-40b4-493b-bfb3-35912d0f0d80', '8e4fa95b-511c-4ecd-9759-8b60c1dd4c11', 'flashcard', 'Using Python Libraries (Math, Random, and NumPy) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('ee422531-c77a-41e6-8efe-02308031828c', '8e4fa95b-511c-4ecd-9759-8b60c1dd4c11', 'mcq', 'Using Python Libraries (Math, Random, and NumPy) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('5f17077d-96e7-4371-9a3b-fb4cefd40f6d', '7e7d010e-97a9-4689-91f2-fc8ed2bbdc31', 'lesson', N'Object-Oriented  Programming  (OOP)  helps  organize  code  by  grouping  data  and  behaviors 
into reusable structures called classes. 
Objects  are  created  from  these  classes  and  can  interact  with  each  other,  just  like  real-world 
entities. 
In  this  chapter,  we  will  look  deeper  into  advanced  OOP  concepts  such  as inheritance, 
polymorphism, encapsulation, and abstraction. 
 
1. Classes and Objects 
A class is  a  blueprint  for  creating  objects.  It  defines  properties  (variables)  and  methods 
(functions). 
An object is an instance of a class — a real “thing” based on that blueprint. 
*insert code example below* 
Example: 
class Dog: 
    def __init__(self, name): 
        self.name = name 
 
    def bark(self): 
        print(f"{self.name} says Woof!") 
 
dog1 = Dog("Buddy") 
dog1.bark() 
Output: 
Buddy says Woof! 
 

2. Inheritance 
Inheritance allows    one    class    to    use    the    properties    and    methods    of    another. 
The new class (called the child class) inherits from the parent class. 
*insert code example below* 
Example: 
class Animal: 
    def speak(self): 
        print("This animal makes a sound.") 
 
class Dog(Animal): 
    def speak(self): 
        print("The dog barks.") 
 
d = Dog() 
d.speak() 
Here, Dog inherits from Animal but overrides the speak() method. 
Benefits of Inheritance: 
• Reduces code repetition. 
• Makes it easier to add new types without rewriting old code. 
 
3. Polymorphism 
Polymorphism means  “many  forms.”  It  allows  different  objects  to  use  the  same  method 
name but behave differently. 
*insert code example below* 
Example: 
class Cat: 
    def sound(self): 

        print("Meow") 
 
class Cow: 
    def sound(self): 
        print("Moo") 
 
for animal in [Cat(), Cow()]: 
    animal.sound() 
Even though both classes use the same method name sound(), each behaves differently. 
 
4. Encapsulation 
Encapsulation means  hiding  the  internal  details  of  an  object  and  only  exposing  what  is 
necessary. 
It helps protect data from being modified accidentally. 
*insert code example below* 
Example: 
class BankAccount: 
    def __init__(self, balance): 
        self.__balance = balance  # private variable 
 
    def deposit(self, amount): 
        self.__balance += amount 
 
    def get_balance(self): 
        return self.__balance 
 
account = BankAccount(100) 
account.deposit(50) 
print(account.get_balance())  # 150 
The double underscore __ before a variable makes it private and cannot be accessed directly 
outside the class. 

 
5. Abstraction 
Abstraction means  showing  only  the  essential  features  of  an  object  while  hiding  the 
unnecessary details. 
It can be achieved using abstract classes and methods. 
*insert code example below* 
Example: 
from abc import ABC, abstractmethod 
 
class Shape(ABC): 
    @abstractmethod 
    def area(self): 
        pass 
 
class Circle(Shape): 
    def __init__(self, radius): 
        self.radius = radius 
 
    def area(self): 
        return 3.14 * self.radius * self.radius 
 
c = Circle(5) 
print(c.area()) 
The class Shape is abstract and cannot be used directly. The Circle class inherits from it and 
implements the area() method. 
 
6. Class Methods and Static Methods 
• Instance methods use self and belong to an object. 
• Class methods use cls and belong to the class itself. 
• Static methods don’t use self or cls; they act like normal functions inside a class. 

*insert code example below* 
Example: 
class Example: 
    @classmethod 
    def show_class(cls): 
        print("This is a class method.") 
 
    @staticmethod 
    def greet(): 
        print("Hello from static method!") 
 
Example.show_class() 
Example.greet() 
 
7. The super() Function 
super() is used to call methods from the parent class. 
*insert code example below* 
Example: 
class Animal: 
    def __init__(self, name): 
        self.name = name 
 
class Dog(Animal): 
    def __init__(self, name, breed): 
        super().__init__(name) 
        self.breed = breed 
 
dog = Dog("Buddy", "Beagle") 
print(dog.name, dog.breed) 
Output: 
Buddy Beagle 
 

8. Dunder (Magic) Methods 
“Dunder” means “double underscore.” These are special methods that begin and end with __, 
like __init__ or __str__. 
*insert code example below* 
Example: 
class Person: 
    def __init__(self, name): 
        self.name = name 
 
    def __str__(self): 
        return f"My name is {self.name}" 
 
p = Person("Ali") 
print(p) 
Output: 
My name is Ali 
 
9. Composition 
Composition means     that     one     class     contains     an     object     of     another     class. 
It represents a “has-a” relationship. 
  

*insert code example below* 
Example: 
class Engine: 
    def start(self): 
        print("Engine started") 
 
class Car: 
    def __init__(self): 
        self.engine = Engine() 
 
    def start(self): 
        self.engine.start() 
        print("Car is running") 
 
my_car = Car() 
my_car.start()');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('99407aec-73aa-4660-ab26-c1927f29937a', '7e7d010e-97a9-4689-91f2-fc8ed2bbdc31', 'flashcard', 'Advanced Object-Oriented Programming (OOP) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('a12c50e5-dc55-4d56-a51c-668f8a5e934d', '7e7d010e-97a9-4689-91f2-fc8ed2bbdc31', 'mcq', 'Advanced Object-Oriented Programming (OOP) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('70fc31cf-1503-48d6-95d2-ca82c1abfab0', '6e3d42c0-7adf-4c39-8206-38c4b4dc2e27', 'lesson', N'Modern  Python  programs  often  need  to store, read,  and exchange data  between  different 
systems or applications. 
The most common formats for this purpose are JSON (JavaScript Object Notation), CSV 
(Comma-Separated Values), and APIs (Application Programming Interfaces). 
These  tools  allow  Python  programs  to  communicate  with  files,  databases,  or  web  servers 
efficiently. 
 
1. Working with JSON 
JSON    is    a    lightweight    data    format    used    to    store    and    exchange    information. 
It looks similar to a Python dictionary, with key-value pairs. 
*insert code example below* 
Example of JSON data: 
{ 
  "name": "Ali", 
  "age": 20, 
  "city": "Kuala Lumpur" 
} 
 
Reading JSON in Python 
The json module allows you to load and save JSON data easily. 
*insert code example below* 
Example: 
import json 
 
# Reading JSON data from a file 

with open("data.json", "r") as file: 
    data = json.load(file) 
 
print(data["name"]) 
Explanation: 
json.load() converts JSON text into a Python dictionary. 
 
Writing JSON in Python 
You can also write data to a JSON file: 
*insert code example below* 
import json 
 
student = {"name": "Aida", "age": 22, "course": "AI"} 
 
with open("student.json", "w") as file: 
    json.dump(student, file, indent=4) 
Explanation: 
json.dump() converts a Python dictionary into JSON format and saves it to a file. 
 
Converting Between Python and JSON Strings 
You     can     convert     Python     objects     into     JSON     strings     using json.dumps(), 
and convert JSON strings back to Python using json.loads(). 
*insert code example below* 
Example: 
import json 
 
data = {"name": "John", "age": 30} 

json_str = json.dumps(data) 
print(json_str)  # ''{"name": "John", "age": 30}'' 
 
python_data = json.loads(json_str) 
print(python_data["name"])  # John 
 
2. Working with CSV Files 
CSV files store data in rows and columns separated by commas. 
They are commonly used for spreadsheets and databases. 
*insert code example below* 
Example (data.csv): 
Name,Age,Course 
Ali,21,AI 
Aida,22,Data Science 
 
Reading CSV Files 
You can use the csv module to read CSV files easily. 
*insert code example below* 
Example: 
import csv 
 
with open("data.csv", "r") as file: 
    reader = csv.reader(file) 
    for row in reader: 
        print(row) 
Explanation: 
Each line is read as a list of values. 
 

Writing CSV Files 
*insert code example below* 
import csv 
 
with open("output.csv", "w", newline="") as file: 
    writer = csv.writer(file) 
    writer.writerow(["Name", "Age"]) 
    writer.writerow(["Ali", 21]) 
Explanation: 
The writerow() function writes one row at a time into the CSV file. 
 
Using DictReader and DictWriter 
These classes allow reading and writing CSV files as dictionaries. 
*insert code example below* 
Example: 
import csv 
 
with open("students.csv", "r") as file: 
    reader = csv.DictReader(file) 
    for row in reader: 
        print(row["Name"], row["Age"]) 
 
3. Working with APIs 
An API (Application Programming Interface) allows programs to interact with other software 
or online services. 
For  example,  a  weather  API  can  provide  weather  information  when  requested  by  your 
program. 

To access APIs, Python uses the requests library (needs installation): 
*insert code example below* 
pip install requests 
Example: 
*insert code example below* 
import requests 
 
response = requests.get("https://api.github.com") 
print(response.status_code)  # 200 means success 
print(response.json())       # Converts JSON response to Python dict 
 
Sending Data to an API 
You can send data to APIs using the POST method: 
*insert code example below* 
import requests 
 
data = {"username": "Ali", "password": "12345"} 
response = requests.post("https://example.com/login", data=data) 
print(response.status_code) 
Explanation: 
requests.post() sends data to a web service. 
If the API returns a response, you can access it using .json() or .text. 
 
Common HTTP Response Codes 
Code Meaning 
200 OK – The request succeeded 

Code Meaning 
404 Not Found – The resource doesn’t exist 
401 Unauthorized – Login required 
500 Internal Server Error – Problem on the server side 
 
Summary 
• JSON → Used for structured data and easy exchange between systems. 
• CSV → Used for tables, rows, and columns. 
• APIs →   Allow   data   to   be   retrieved   or   sent   over   the   internet. 
Together, these tools help Python interact with the real world beyond your computer.');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('7368c838-6c64-460f-b6f4-58e8e73aa1e0', '6e3d42c0-7adf-4c39-8206-38c4b4dc2e27', 'flashcard', 'Working with Data (JSON, CSV, and APIs) Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('2855b473-0d75-4d2c-b7e1-798a3d298dbc', '6e3d42c0-7adf-4c39-8206-38c4b4dc2e27', 'mcq', 'Working with Data (JSON, CSV, and APIs) Quiz');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('fcfe0d57-44da-4115-92c0-17ccaba07f93', 'b7360b9c-a840-40f9-af2d-40e9e3b14be8', 'lesson', N'Python  is  not  limited  to  text-based  programs — you  can  also  build  visual  applications  and 
games. 
Two popular tools for this are Tkinter, which is used for creating Graphical User Interfaces 
(GUIs), and Pygame, which is used for making simple 2D games. 
 
1. Introduction to GUI 
A Graphical User Interface (GUI) allows users to interact with programs using buttons, text 
boxes, menus, and other visual elements instead of typing commands. 
In     Python,     the     most     common     library     for     GUI     development     is Tkinter. 
Tkinter comes built into Python, so no installation is needed. 
*insert code example below* 
To start: 
import tkinter as tk 
 
window = tk.Tk() 
window.title("My First GUI") 
window.geometry("300x200") 
 
label = tk.Label(window, text="Hello, World!") 
label.pack() 
 
window.mainloop() 
Explanation: 
• tk.Tk() creates the main window. 
• Label displays text. 

• pack() arranges the widget on the screen. 
• mainloop() keeps the window open until the user closes it. 
 
2. Common Tkinter Widgets 
Widget Description Example 
Label 
Displays text or images 
Label(window, text="Hi!") 
Button 
Adds a clickable button 
Button(window, text="Click") 
Entry 
Creates a text input field 
Entry(window) 
Frame 
Organizes other widgets 
Frame(window) 
Canvas 
Draws shapes or graphics 
Canvas(window) 
*insert code example below* 
Example: 
import tkinter as tk 
 
def greet(): 
    print("Button clicked!") 
 
window = tk.Tk() 
button = tk.Button(window, text="Click Me", command=greet) 
button.pack() 
window.mainloop() 
When the button is clicked, the greet() function runs. 
 
3. Adding Input and Output 
You can collect user input with the Entry widget: 
*insert code example below* 

import tkinter as tk 
 
def show_name(): 
    name = entry.get() 
    label.config(text=f"Hello, {name}!") 
 
window = tk.Tk() 
entry = tk.Entry(window) 
entry.pack() 
 
label = tk.Label(window) 
label.pack() 
 
button = tk.Button(window, text="Submit", command=show_name) 
button.pack() 
 
window.mainloop() 
When the user types their name and clicks the button, the label updates with a greeting. 
 
4. Introduction to Pygame 
Pygame is a Python library used for developing 2D games. 
It  provides  tools  to  display  graphics,  handle  keyboard  and  mouse  input,  and  add  sound 
effects. 
To install Pygame: 
*insert code example below* 
pip install pygame 
 
5. Starting a Basic Game Window 
Example: 
*insert code example below* 

import pygame 
pygame.init() 
 
screen = pygame.display.set_mode((400, 300)) 
pygame.display.set_caption("My First Game") 
 
running = True 
while running: 
    for event in pygame.event.get(): 
        if event.type == pygame.QUIT: 
            running = False 
    screen.fill((0, 0, 255))  # Fills screen with blue 
    pygame.display.update() 
 
pygame.quit() 
Explanation: 
• pygame.init() starts Pygame. 
• set_mode() creates the game window. 
• The game loop runs continuously until the player exits. 
• event.type == pygame.QUIT lets you close the window. 
• fill() changes the background color. 
• update() refreshes the screen. 
 
6. Drawing Shapes 
You can draw rectangles, circles, and lines using built-in functions: 
*insert code example below* 
pygame.draw.rect(screen, (255, 0, 0), (50, 50, 100, 60))  # Red rectangle 
pygame.draw.circle(screen, (0, 255, 0), (200, 150), 40)   # Green circle 
pygame.display.update() 
 
7. Handling Keyboard Input 

Example: 
*insert code example below* 
keys = pygame.key.get_pressed() 
if keys[pygame.K_LEFT]: 
    print("Left arrow pressed") 
 
8. Displaying Images and Sounds 
Images can be loaded using: 
*insert code example below* 
player = pygame.image.load("player.png") 
screen.blit(player, (100, 100)) 
pygame.display.update() 
Sound effects can be added using: 
*insert code example below* 
sound = pygame.mixer.Sound("click.wav") 
sound.play() 
 
9. Game Loop Concept 
Every Pygame program runs inside a main loop. 
This loop handles: 
1. Events (keyboard, mouse) 
2. Updates (movement, collision) 
3. Drawing (redraw the screen) 
Example (simplified): 
*insert code example below* 

while running: 
    handle_input() 
    update_game_objects() 
    draw_screen() 
This makes the game interactive and dynamic. 
 
10. Combining GUI and Game Development 
You   can   use Tkinter for   menus   or   settings   and Pygame for   the   actual   gameplay. 
For example, a Tkinter window could collect player names before starting a Pygame level.');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('cc042033-fb05-4117-86cb-41c9cd29e25d', 'b7360b9c-a840-40f9-af2d-40e9e3b14be8', 'flashcard', 'Graphical  User  Interface  (GUI)  and  Game  Basics  using  Tkinter  and Flashcards');
GO

INSERT INTO Resources (ResourceId, ChapterId, Type, Content) 
VALUES ('6f9b15a0-2c89-4eee-9caa-4d046939509c', 'b7360b9c-a840-40f9-af2d-40e9e3b14be8', 'mcq', 'Graphical  User  Interface  (GUI)  and  Game  Basics  using  Tkinter  and Quiz');
GO