const emptyQuestions = () => ({
  easy: [],
  medium: [],
  hard: [],
});

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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
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
    flashcards: [],
    questions: emptyQuestions(),
  },
};

export const getChapterDetails = (id) => chapterDetails[id] ?? null;

