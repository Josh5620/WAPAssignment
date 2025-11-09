const emptyQuestions = () => ({
  easy: [],
  medium: [],
  hard: [],
});

const chapterFlashcardBank = {
  1: [
    { frontText: 'What does the acronym REPL stand for in Python?', backText: 'Read–Evaluate–Print Loop.' },
    { frontText: 'Which statement displays a message on screen?', backText: 'Use `print("message")`.' },
    { frontText: 'What file extension do Python scripts use?', backText: 'Python scripts end with `.py`.' },
    { frontText: 'How do you start the Python interpreter from the terminal?', backText: 'Run `python` or `python3`.' },
    { frontText: 'How can you exit the interactive interpreter?', backText: 'Type `exit()` or press `Ctrl+D` (`Ctrl+Z` on Windows).' },
    { frontText: 'Which built-in shows quick documentation for a function?', backText: 'Call `help(function_name)`.' },
    { frontText: 'What symbol begins a single-line comment?', backText: 'Use the hash symbol `#`.' },
    { frontText: 'Which tool installs third-party packages?', backText: '`pip install package_name`.' },
    { frontText: 'Is Python interpreted or compiled?', backText: 'Python is an interpreted language.' },
    { frontText: 'What command runs a script named `garden.py`?', backText: '`python garden.py` (or `python3 garden.py`).' },
  ],
  2: [
    { frontText: 'What characters are allowed in Python variable names?', backText: 'Letters, numbers, and underscores (no leading digit).' },
    { frontText: 'What does “dynamic typing” mean in Python?', backText: 'Variables can hold values of any type and can be reassigned to different types.' },
    { frontText: 'Which function tells you a value’s type?', backText: '`type(value)`.' },
    { frontText: 'How do you convert a number to a string?', backText: 'Call `str(number)`.' },
    { frontText: 'What are the two boolean values in Python?', backText: '`True` and `False`.' },
    { frontText: 'What does `int("7")` return?', backText: 'The integer `7`.' },
    { frontText: 'How do you swap two variables in a single statement?', backText: '`a, b = b, a`.' },
    { frontText: 'How do you check if a variable points to `None`?', backText: 'Use `if value is None:`.' },
    { frontText: 'Which method removes surrounding whitespace from a string?', backText: '`text.strip()`.' },
    { frontText: 'How do you interpolate variables into a sentence cleanly?', backText: 'Use an f-string, e.g., `f"{name} waters the garden."`.' },
  ],
  3: [
    { frontText: 'How do you create a list literal in Python?', backText: 'Use square brackets: `[1, 2, 3]`.' },
    { frontText: 'Which method adds an item to the end of a list?', backText: '`list.append(item)`.' },
    { frontText: 'What distinguishes a tuple from a list?', backText: 'Tuples are immutable (written with parentheses).' },
    { frontText: 'How do you access dictionary values by key?', backText: '`my_dict["key"]`.' },
    { frontText: 'Which collection automatically removes duplicates?', backText: 'A `set` keeps unique items.' },
    { frontText: 'How do you get the number of items in a collection?', backText: '`len(collection)`.' },
    { frontText: 'How can you slice the first three items of a list named `plants`?', backText: '`plants[:3]`.' },
    { frontText: 'Which method returns only the keys of a dictionary?', backText: '`my_dict.keys()`.' },
    { frontText: 'How do you check if `"rose"` is inside a list named `garden`?', backText: '`"rose" in garden`.' },
    { frontText: 'How do you convert a list to a tuple?', backText: '`tuple(my_list)`.' },
  ],
  4: [
    { frontText: 'What keywords build a basic decision in Python?', backText: '`if`, `elif`, and `else`.' },
    { frontText: 'Which operator checks equality?', backText: '`==` compares values for equality.' },
    { frontText: 'Why is indentation critical in conditionals?', backText: 'Indentation defines the blocks of code controlled by each condition.' },
    { frontText: 'How do you combine conditions that must both be true?', backText: 'Use the logical operator `and`.' },
    { frontText: 'Which operator inverts a boolean value?', backText: '`not` flips truthiness.' },
    { frontText: 'How do you check multiple ranges cleanly, such as 0 <= x < 10?', backText: 'Use chained comparisons: `if 0 <= x < 10:`.' },
    { frontText: 'What function collects user input as a string?', backText: '`input("Prompt")`.' },
    { frontText: 'What function converts a string to a float for comparisons?', backText: '`float(text)`.' },
    { frontText: 'How do you execute code only when a condition is false?', backText: 'Use the `else` block attached to the `if` statement.' },
    { frontText: 'What keyword lets you supply a fallback when an `if` isn’t needed but a block must run afterward?', backText: '`elif` handles extra conditional branches.' },
  ],
  5: [
    { frontText: 'What loop visits each item in a collection?', backText: 'A `for` loop, e.g., `for item in items:`.' },
    { frontText: 'Which function produces a sequence of numbers for looping?', backText: '`range()` generates integer sequences.' },
    { frontText: 'What loop repeats while a condition remains true?', backText: 'A `while` loop.' },
    { frontText: 'Which keyword immediately exits the current loop?', backText: '`break` stops the loop.' },
    { frontText: 'Which keyword skips the rest of the loop body and continues with the next iteration?', backText: '`continue`.' },
    { frontText: 'How do you loop with index and value together?', backText: 'Use `enumerate(collection)`.' },
    { frontText: 'How can you loop over two lists simultaneously?', backText: 'Use `zip(list1, list2)` in a `for` loop.' },
    { frontText: 'What structure quickly builds a list from an iterator?', backText: 'A list comprehension: `[expr for item in items]`.' },
    { frontText: 'Which keyword gives a fallback block when a loop finishes without `break`?', backText: 'Use `else` after a loop.' },
    { frontText: 'How do you accumulate a running total inside a loop?', backText: 'Initialize a variable before the loop, then update it inside each iteration.' },
  ],
};

const buildFlashcards = (chapterId) => {
  const cards = chapterFlashcardBank[chapterId] || chapterFlashcardBank[1];
  return cards.map((card, index) => ({
    id: `${chapterId}-flashcard-${index + 1}`,
    ...card,
  }));
};

export const chapterDetails = {
  1: {
    overview:
      'Discover what Python is used for and write your very first lines of code in the interactive shell.',
    learningObjectives: [
      'Describe why Python is popular for beginners and professionals.',
      'Set up a local or online Python environment.',
      'Run basic print statements and understand interpreter feedback.',
    ],
    sections: [
      {
        heading: 'Meet Python',
        body: [
          'Python is a versatile language that powers web apps, data science, automation, and games.',
          'Its readable syntax makes it perfect for your first programming experience.',
        ],
      },
      {
        heading: 'Your First Program',
        body: [
          'Open a REPL (Read Evaluate Print Loop) such as VS Code, IDLE, or an online sandbox.',
          'Type `print("Hello, garden!")` and press Enter to see instant output.',
        ],
      },
    ],
    practice: [
      'Personalize the hello message with your name.',
      'Experiment with printing numbers and simple math expressions.',
    ],
    flashcards: buildFlashcards(1),
    questions: emptyQuestions(),
  },
  2: {
    overview: 'Store information using variables and explore how Python keeps track of different values.',
    learningObjectives: [
      'Create variables with friendly names.',
      'Understand dynamic typing and reassignment.',
      'Explain the difference between integers, floats, strings, and booleans.',
    ],
    sections: [
      {
        heading: 'Naming Garden Tools',
        body: [
          'Variables are labels you attach to data, such as `watering_can = "Full"`.',
          'Python variables can be reassigned without declaring their type first.',
        ],
      },
      {
        heading: 'Data Snapshots',
        body: [
          'Use `type()` to check the underlying data type.',
          'Practice converting between types with helpers like `int()` and `str()`.',
        ],
      },
    ],
    practice: [
      'Create three variables representing plants, their age in weeks, and whether they have been watered today.',
      'Print a friendly summary sentence using f-strings.',
    ],
    flashcards: buildFlashcards(2),
    questions: emptyQuestions(),
  },
  3: {
    overview:
      'Organize data with Python collections such as lists, tuples, dictionaries, and sets.',
    learningObjectives: [
      'Choose the right collection for a problem.',
      'Iterate through and modify list items.',
      'Store key information in dictionaries for quick lookup.',
    ],
    sections: [
      {
        heading: 'List Your Seedlings',
        body: [
          'Lists keep items in order. Append, insert, and slice to manage garden tasks.',
          'Tuples lock values in place when you need read-only data.',
        ],
      },
      {
        heading: 'A Map of the Garden',
        body: [
          'Dictionaries map keys to values, perfect for pairing plant names to care instructions.',
          'Sets track unique values like pest sightings without duplicates.',
        ],
      },
    ],
    practice: [
      'Build a dictionary named `garden_bed` with plant names as keys and their sunlight needs as values.',
      'Loop through the dictionary and print a formatted checklist.',
    ],
    flashcards: buildFlashcards(3),
    questions: emptyQuestions(),
  },
  4: {
    overview: 'Teach Python to make decisions using comparison operators and conditional logic.',
    learningObjectives: [
      'Write `if`, `elif`, and `else` blocks to control program flow.',
      'Combine conditions with logical operators.',
      'Avoid common pitfalls like indentation errors.',
    ],
    sections: [
      {
        heading: 'Garden Decisions',
        body: [
          'Use conditions to decide whether plants need watering or fertilizer.',
          'Combine rules with `and`, `or`, and `not` for nuanced checks.',
        ],
      },
      {
        heading: 'Guarding Against Frost',
        body: [
          'Add user input to gather temperature data.',
          'Alert the user when protective action is required.',
        ],
      },
    ],
    practice: [
      'Create a script that asks for soil moisture and weather forecasts, then prints advice for the gardener.',
      'Refactor the script to reuse repeated messages.',
    ],
    flashcards: buildFlashcards(4),
    questions: emptyQuestions(),
  },
  5: {
    overview: 'Automate repetitive work with loops that iterate through garden chores.',
    learningObjectives: [
      'Use `for` loops to step through collections.',
      'Control repetition with `while` and loop conditions.',
      'Apply `break` and `continue` to fine-tune loop execution.',
    ],
    sections: [
      {
        heading: 'March Through the Rows',
        body: [
          'Use `for plant in garden_bed:` to visit each plant in turn.',
          'Add counters and enumerate to track positions.',
        ],
      },
      {
        heading: 'Watchful Watering',
        body: [
          'Use `while` loops for actions that repeat until a condition changes.',
          'Safeguard against infinite loops with thoughtful updates.',
        ],
      },
    ],
    practice: [
      'Iterate over a list of chores and mark each as done.',
      'Write a `while` loop that keeps prompting for water levels until the value is within range.',
    ],
    flashcards: buildFlashcards(5),
    questions: emptyQuestions(),
  },
  6: {
    overview: 'Bundle reusable logic into functions with parameters, defaults, and return values.',
    learningObjectives: [
      'Define functions with descriptive names.',
      'Pass arguments positionally and by keyword.',
      'Return data for reuse in other parts of your program.',
    ],
    sections: [
      {
        heading: 'Create a Helper Library',
        body: [
          'Use `def` to group instructions such as scheduling watering reminders.',
          'Add docstrings to explain how the helper should be used.',
        ],
      },
      {
        heading: 'Nurture with Defaults',
        body: [
          'Give parameters default values so functions stay flexible.',
          'Return dictionaries or lists when you need to send multiple results back.',
        ],
      },
    ],
    practice: [
      'Write a function `needs_water(plant, rainfall=0)` that returns `True` or `False`.',
      'Call your function for several plants and print the results in a tidy table.',
    ],
    flashcards: buildFlashcards(6),
    questions: emptyQuestions(),
  },
  7: {
    overview: 'Work with files to record garden progress and read historical data.',
    learningObjectives: [
      'Open and close files safely using context managers.',
      'Read text line by line or all at once.',
      'Append new entries without overwriting old notes.',
    ],
    sections: [
      {
        heading: 'Recording the Harvest',
        body: [
          'Use `with open("journal.txt", "a") as file:` to log daily updates.',
          'Write formatted strings that capture the date, weather, and observations.',
        ],
      },
      {
        heading: 'Review Past Seasons',
        body: [
          'Read files with `.read()`, `.readline()`, or `.readlines()`.',
          'Split and parse data to compute summaries such as average harvest weight.',
        ],
      },
    ],
    practice: [
      'Append a new journal entry describing today\'s garden tasks.',
      'Read the journal and print only the entries that mention watering.',
    ],
    flashcards: buildFlashcards(7),
    questions: emptyQuestions(),
  },
  8: {
    overview: 'Model complex gardens with classes that capture both data and behavior.',
    learningObjectives: [
      'Define classes with attributes and methods.',
      'Instantiate objects and track their unique state.',
      'Use inheritance to reuse and extend behavior.',
    ],
    sections: [
      {
        heading: 'Design a Plant Class',
        body: [
          'Create a `Plant` class with properties like name, sunlight, and water frequency.',
          'Add methods such as `water()` and `needs_sunlight()` to encapsulate logic.',
        ],
      },
      {
        heading: 'Specialize with Inheritance',
        body: [
          'Derive a `Succulent` or `Herb` class that overrides watering routines.',
          'Call `super().__init__()` to reuse the base initialization.',
        ],
      },
    ],
    practice: [
      'Instantiate several plants and simulate a weekly care schedule.',
      'Track when each plant was last watered by updating instance attributes.',
    ],
    flashcards: buildFlashcards(8),
    questions: emptyQuestions(),
  },
  9: {
    overview: 'Bring in extra tools by importing Python modules and third-party packages.',
    learningObjectives: [
      'Import standard library modules like `math` and `datetime`.',
      'Create and reuse your own modules.',
      'Manage dependencies responsibly with virtual environments.',
    ],
    sections: [
      {
        heading: 'Toolbox Essentials',
        body: [
          'Use `import math` to calculate arc lengths for circular flower beds.',
          'Format timestamps with `datetime` when logging observations.',
        ],
      },
      {
        heading: 'Sharing Garden Wisdom',
        body: [
          'Split large programs into modules and packages.',
          'Protect module execution with `if __name__ == "__main__":`.',
        ],
      },
    ],
    practice: [
      'Create a `garden_utils.py` module with helper functions and import it into your notebook.',
      'Install a package like `requests` (if permitted) to fetch garden tips from an API.',
    ],
    flashcards: buildFlashcards(9),
    questions: emptyQuestions(),
  },
  10: {
    overview: 'Combine everything you have learned to deliver a polished final project.',
    learningObjectives: [
      'Plan a Python application with clear milestones.',
      'Break complex problems into manageable modules.',
      'Prepare a short demo or walkthrough of your work.',
    ],
    sections: [
      {
        heading: 'Project Planning',
        body: [
          'Choose a project idea such as a garden tracker, quiz game, or automation script.',
          'Draft user stories and sketch a minimal viable product.',
        ],
      },
      {
        heading: 'Iterate and Showcase',
        body: [
          'Implement features incrementally, testing as you go.',
          'Create a README or presentation to explain how to run and use your project.',
        ],
      },
    ],
    practice: [
      'Outline your project structure and identify reusable code from previous chapters.',
      'Schedule time for peer review or mentor feedback before submission.',
    ],
    flashcards: buildFlashcards(10),
    questions: emptyQuestions(),
  },
};

export const getChapterDetails = (id) => chapterDetails[id] ?? null;

