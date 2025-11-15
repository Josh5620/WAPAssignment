// Fake notes data for each chapter to display in GuestChapterViewer
// Structured to match backend Resource model with type='note'

export const chapterNotes = {
  1: [
    {
      resourceId: 'note-ch1-1',
      title: 'Getting Started with Python',
      type: 'note',
      content: `
        <h2>🌱 Welcome to Python</h2>
        <p>Python is a high-level, interpreted programming language known for its readability and versatility. It's used in web development, data science, automation, artificial intelligence, and more.</p>
        
        <h3>Why Python?</h3>
        <ul>
          <li><strong>Easy to Learn:</strong> Clean syntax that reads like English</li>
          <li><strong>Versatile:</strong> Works for web apps, data analysis, automation, AI/ML</li>
          <li><strong>Large Community:</strong> Extensive libraries and helpful resources</li>
          <li><strong>Career Ready:</strong> High demand in tech industry</li>
        </ul>

        <h3>Your First Python Program</h3>
        <pre><code>print("Hello, Garden!")</code></pre>
        <p>The <code>print()</code> function displays text to the console. Try it in the Python interpreter!</p>

        <h3>The REPL (Read-Evaluate-Print Loop)</h3>
        <p>Python's interactive shell lets you type code and see results immediately:</p>
        <pre><code>>>> 2 + 2
4
>>> name = "Emma"
>>> print(f"Hello, {name}")
Hello, Emma</code></pre>

        <h3>Comments</h3>
        <p>Use <code>#</code> for single-line comments to document your code:</p>
        <pre><code># This is a comment
print("This runs")  # This explains the code</code></pre>
      `
    },
    {
      resourceId: 'note-ch1-2',
      title: 'Setting Up Your Environment',
      type: 'note',
      content: `
        <h2>🛠️ Python Installation & Setup</h2>
        
        <h3>Installing Python</h3>
        <ol>
          <li>Visit <a href="https://python.org" target="_blank">python.org</a></li>
          <li>Download the latest version (3.11+ recommended)</li>
          <li>Run the installer (check "Add Python to PATH")</li>
          <li>Verify installation: <code>python --version</code></li>
        </ol>

        <h3>Popular Code Editors</h3>
        <ul>
          <li><strong>VS Code:</strong> Lightweight with Python extension</li>
          <li><strong>PyCharm:</strong> Full-featured Python IDE</li>
          <li><strong>Jupyter Notebook:</strong> Great for data science</li>
          <li><strong>Online:</strong> Replit, Google Colab for browser-based coding</li>
        </ul>

        <h3>Running Python Scripts</h3>
        <p>Create a file <code>garden.py</code>:</p>
        <pre><code>print("Welcome to the Python Garden!")
print("Let's grow together 🌿")</code></pre>
        <p>Run it from terminal:</p>
        <pre><code>python garden.py</code></pre>

        <h3>Package Management with pip</h3>
        <p>Install third-party libraries:</p>
        <pre><code>pip install requests
pip list  # See installed packages</code></pre>
      `
    }
  ],

  2: [
    {
      resourceId: 'note-ch2-1',
      title: 'Variables and Data Types',
      type: 'note',
      content: `
        <h2>📦 Variables in Python</h2>
        <p>Variables are containers that store data. Python uses dynamic typing, meaning you don't declare the type.</p>

        <h3>Creating Variables</h3>
        <pre><code>name = "Liam"          # String
age = 25               # Integer
height = 5.9           # Float
is_student = True      # Boolean
garden = None          # NoneType</code></pre>

        <h3>Naming Rules</h3>
        <ul>
          <li>Start with letter or underscore</li>
          <li>Can contain letters, numbers, underscores</li>
          <li>Case-sensitive (<code>Name</code> ≠ <code>name</code>)</li>
          <li>Use snake_case convention: <code>user_name</code></li>
        </ul>

        <h3>Data Types</h3>
        <table border="1" cellpadding="8">
          <tr><th>Type</th><th>Example</th><th>Use Case</th></tr>
          <tr><td><code>int</code></td><td>42</td><td>Whole numbers</td></tr>
          <tr><td><code>float</code></td><td>3.14</td><td>Decimals</td></tr>
          <tr><td><code>str</code></td><td>"hello"</td><td>Text</td></tr>
          <tr><td><code>bool</code></td><td>True/False</td><td>Logic</td></tr>
          <tr><td><code>None</code></td><td>None</td><td>Empty value</td></tr>
        </table>

        <h3>Type Checking and Conversion</h3>
        <pre><code>x = 10
print(type(x))      # <class 'int'>

# Type conversion
age_str = "25"
age_int = int(age_str)    # Convert to integer
pi_str = str(3.14159)     # Convert to string</code></pre>
      `
    },
    {
      resourceId: 'note-ch2-2',
      title: 'Working with Strings',
      type: 'note',
      content: `
        <h2>🔤 String Operations</h2>

        <h3>String Creation</h3>
        <pre><code>single = 'Hello'
double = "World"
multiline = """This is
a multiline
string"""</code></pre>

        <h3>String Formatting</h3>
        <pre><code>name = "Sophia"
age = 22

# f-strings (recommended)
message = f"{name} is {age} years old"

# .format() method
message = "{} is {} years old".format(name, age)

# % formatting (older)
message = "%s is %d years old" % (name, age)</code></pre>

        <h3>Common String Methods</h3>
        <pre><code>text = "  Python Garden  "

text.strip()        # Remove whitespace: "Python Garden"
text.lower()        # Lowercase: "  python garden  "
text.upper()        # Uppercase: "  PYTHON GARDEN  "
text.replace("Garden", "Park")  # Replace text
text.split()        # Split into list: ["Python", "Garden"]
"_".join(["a", "b"])  # Join with separator: "a_b"</code></pre>

        <h3>String Indexing and Slicing</h3>
        <pre><code>word = "Python"
print(word[0])      # P (first character)
print(word[-1])     # n (last character)
print(word[1:4])    # yth (slice from index 1 to 3)
print(word[:3])     # Pyt (first 3)
print(word[3:])     # hon (from index 3 to end)</code></pre>
      `
    }
  ],

  3: [
    {
      resourceId: 'note-ch3-1',
      title: 'Lists and Tuples',
      type: 'note',
      content: `
        <h2>📋 Lists - Ordered Collections</h2>
        <p>Lists are mutable (changeable) sequences that can hold any data type.</p>

        <h3>Creating Lists</h3>
        <pre><code>plants = ["rose", "tulip", "daisy"]
numbers = [1, 2, 3, 4, 5]
mixed = [1, "two", 3.0, True]
empty = []</code></pre>

        <h3>List Operations</h3>
        <pre><code>plants = ["rose", "tulip"]

# Add items
plants.append("daisy")        # Add to end
plants.insert(0, "lily")      # Insert at position
plants.extend(["orchid"])     # Add multiple

# Remove items
plants.remove("tulip")        # Remove by value
last = plants.pop()           # Remove and return last
first = plants.pop(0)         # Remove and return at index

# Access
print(plants[0])              # First item
print(plants[-1])             # Last item
print(len(plants))            # Number of items</code></pre>

        <h3>Tuples - Immutable Lists</h3>
        <pre><code>coordinates = (10, 20)
single = (42,)  # Note the comma for single-item tuple

# Tuples cannot be modified
# coordinates[0] = 15  # Error!

# But you can unpack them
x, y = coordinates
print(x, y)  # 10 20</code></pre>

        <h3>List Slicing</h3>
        <pre><code>numbers = [0, 1, 2, 3, 4, 5]
print(numbers[1:4])    # [1, 2, 3]
print(numbers[:3])     # [0, 1, 2]
print(numbers[3:])     # [3, 4, 5]
print(numbers[::2])    # [0, 2, 4] (every 2nd)</code></pre>
      `
    },
    {
      resourceId: 'note-ch3-2',
      title: 'Dictionaries and Sets',
      type: 'note',
      content: `
        <h2>🗂️ Dictionaries - Key-Value Pairs</h2>
        <p>Dictionaries store data as key-value pairs, allowing fast lookups.</p>

        <h3>Creating Dictionaries</h3>
        <pre><code>student = {
    "name": "Noah",
    "age": 20,
    "courses": ["Python", "JavaScript"]
}

# Access values
print(student["name"])           # Noah
print(student.get("age"))        # 20
print(student.get("grade", "N/A"))  # N/A (default)</code></pre>

        <h3>Dictionary Operations</h3>
        <pre><code>student = {"name": "Noah", "age": 20}

# Add or update
student["email"] = "noah@edu.com"
student["age"] = 21

# Remove
del student["age"]
email = student.pop("email")

# Check existence
if "name" in student:
    print("Name found!")

# Iterate
for key, value in student.items():
    print(f"{key}: {value}")</code></pre>

        <h3>Sets - Unique Collections</h3>
        <pre><code>fruits = {"apple", "banana", "orange"}
fruits.add("grape")
fruits.add("apple")  # No duplicates, still 4 items

# Set operations
set1 = {1, 2, 3}
set2 = {3, 4, 5}

print(set1 | set2)   # Union: {1, 2, 3, 4, 5}
print(set1 & set2)   # Intersection: {3}
print(set1 - set2)   # Difference: {1, 2}</code></pre>
      `
    }
  ],

  4: [
    {
      resourceId: 'note-ch4-1',
      title: 'Conditional Statements',
      type: 'note',
      content: `
        <h2>🔀 Making Decisions with If/Else</h2>
        <p>Conditional statements allow your program to make decisions based on conditions.</p>

        <h3>Basic If Statement</h3>
        <pre><code>temperature = 75

if temperature > 70:
    print("It's warm outside!")
    print("Wear light clothing.")</code></pre>

        <h3>If-Else</h3>
        <pre><code>age = 17

if age >= 18:
    print("You can vote!")
else:
    print("You're not old enough yet.")</code></pre>

        <h3>If-Elif-Else Chain</h3>
        <pre><code>score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
elif score >= 60:
    grade = "D"
else:
    grade = "F"

print(f"Your grade is: {grade}")</code></pre>

        <h3>Comparison Operators</h3>
        <ul>
          <li><code>==</code> Equal to</li>
          <li><code>!=</code> Not equal to</li>
          <li><code>&gt;</code> Greater than</li>
          <li><code>&lt;</code> Less than</li>
          <li><code>&gt;=</code> Greater than or equal</li>
          <li><code>&lt;=</code> Less than or equal</li>
        </ul>

        <h3>Logical Operators</h3>
        <pre><code>age = 25
has_license = True

# and - both conditions must be True
if age >= 18 and has_license:
    print("You can drive!")

# or - at least one condition must be True
is_weekend = True
is_holiday = False
if is_weekend or is_holiday:
    print("No work today!")

# not - inverts the boolean
is_raining = False
if not is_raining:
    print("Let's go outside!")</code></pre>
      `
    }
  ],

  5: [
    {
      resourceId: 'note-ch5-1',
      title: 'For Loops',
      type: 'note',
      content: `
        <h2>🔁 Iteration with For Loops</h2>
        <p>For loops let you repeat code for each item in a sequence.</p>

        <h3>Basic For Loop</h3>
        <pre><code>plants = ["rose", "tulip", "daisy"]

for plant in plants:
    print(f"Watering the {plant}")</code></pre>

        <h3>Using Range</h3>
        <pre><code># range(stop) - from 0 to stop-1
for i in range(5):
    print(i)  # 0, 1, 2, 3, 4

# range(start, stop)
for i in range(2, 6):
    print(i)  # 2, 3, 4, 5

# range(start, stop, step)
for i in range(0, 10, 2):
    print(i)  # 0, 2, 4, 6, 8</code></pre>

        <h3>Enumerate - Index and Value</h3>
        <pre><code>fruits = ["apple", "banana", "orange"]

for index, fruit in enumerate(fruits):
    print(f"{index}: {fruit}")
# 0: apple
# 1: banana
# 2: orange

# Start enumeration at 1
for num, fruit in enumerate(fruits, start=1):
    print(f"{num}. {fruit}")</code></pre>

        <h3>Zip - Loop Multiple Lists</h3>
        <pre><code>names = ["Olivia", "Ethan", "Ava"]
scores = [95, 87, 92]

for name, score in zip(names, scores):
    print(f"{name} scored {score}")</code></pre>

        <h3>List Comprehensions</h3>
        <pre><code># Traditional way
squares = []
for x in range(5):
    squares.append(x ** 2)

# List comprehension (more Pythonic)
squares = [x ** 2 for x in range(5)]
# [0, 1, 4, 9, 16]

# With condition
evens = [x for x in range(10) if x % 2 == 0]
# [0, 2, 4, 6, 8]</code></pre>
      `
    },
    {
      resourceId: 'note-ch5-2',
      title: 'While Loops and Loop Control',
      type: 'note',
      content: `
        <h2>⏰ While Loops</h2>
        <p>While loops repeat as long as a condition is true.</p>

        <h3>Basic While Loop</h3>
        <pre><code>count = 0

while count < 5:
    print(f"Count is {count}")
    count += 1  # Increment by 1</code></pre>

        <h3>Break - Exit Loop Early</h3>
        <pre><code>while True:
    answer = input("Enter 'quit' to exit: ")
    if answer == "quit":
        break
    print(f"You entered: {answer}")</code></pre>

        <h3>Continue - Skip to Next Iteration</h3>
        <pre><code>for num in range(10):
    if num % 2 == 0:
        continue  # Skip even numbers
    print(num)  # Only prints odd: 1, 3, 5, 7, 9</code></pre>

        <h3>Else Clause with Loops</h3>
        <pre><code># Else runs if loop completes without break
numbers = [1, 3, 5, 7, 9]

for num in numbers:
    if num % 2 == 0:
        print("Found an even number!")
        break
else:
    print("No even numbers found")  # This runs</code></pre>

        <h3>Nested Loops</h3>
        <pre><code>for i in range(3):
    for j in range(3):
        print(f"({i}, {j})", end=" ")
    print()  # New line

# Output:
# (0, 0) (0, 1) (0, 2)
# (1, 0) (1, 1) (1, 2)
# (2, 0) (2, 1) (2, 2)</code></pre>

        <h3>Avoiding Infinite Loops</h3>
        <pre><code># Bad - infinite loop
# while True:
#     print("This never stops!")

# Good - has exit condition
attempts = 0
max_attempts = 3

while attempts < max_attempts:
    print(f"Attempt {attempts + 1}")
    attempts += 1</code></pre>
      `
    }
  ],

  6: [],  // Empty for now
  7: [],
  8: [],
  9: [],
  10: []
};

// Helper function to get notes for a specific chapter
export const getChapterNotes = (chapterId) => {
  const id = parseInt(chapterId) || parseInt(chapterId.split('-')[0]);
  return chapterNotes[id] || [];
};
