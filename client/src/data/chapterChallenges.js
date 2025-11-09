const baseQuestions = {
  easy: [
    {
      id: 'easy-1',
      prompt: 'What keyword lets you repeat code while a condition stays true?',
      options: ['if', 'while', 'repeat', 'loop'],
      answer: 1,
      explanation: 'The `while` keyword keeps running the block until the condition is false.',
      xp: 10,
    },
    {
      id: 'easy-2',
      prompt: 'Which symbol is used for comments in Python?',
      options: ['//', '#', '--', '/* */'],
      answer: 1,
      explanation: 'Python uses the hash symbol (`#`) to mark a single-line comment.',
      xp: 10,
    },
    {
      id: 'easy-3',
      prompt: 'Which function prints text to the console in Python?',
      options: ['echo()', 'print()', 'say()', 'log()'],
      answer: 1,
      explanation: '`print()` outputs the provided value to the console.',
      xp: 10,
    },
    {
      id: 'easy-4',
      prompt: 'Strings in Python are enclosed with which characters?',
      options: ['< >', '` `', '" " or \' \'', '( )'],
      answer: 2,
      explanation: 'Strings are typically wrapped in single or double quotes.',
      xp: 10,
    },
    {
      id: 'easy-5',
      prompt: 'What value does Python use to represent “nothing” or empty?',
      options: ['0', 'None', 'Null', 'void'],
      answer: 1,
      explanation: '`None` is the singleton that represents the absence of a value.',
      xp: 10,
    },
  ],
  medium: [
    {
      id: 'medium-1',
      prompt: 'Given `nums = [2, 4, 6]`, what does `nums.append(8)` do?',
      options: [
        'Creates a new list with 8 added',
        'Adds 8 to the front of the list',
        'Adds 8 to the end of the list',
        'Returns 8 but leaves the list unchanged',
      ],
      answer: 2,
      explanation: '`append` mutates the list by adding the value to the end.',
      xp: 20,
    },
    {
      id: 'medium-2',
      prompt: 'What does `range(3)` produce in a for-loop?',
      options: ['0, 1, 2, 3', '1, 2, 3', '0, 1, 2', '3, 2, 1'],
      answer: 2,
      explanation: 'When given one argument, range generates numbers from 0 up to but not including the argument.',
      xp: 20,
    },
    {
      id: 'medium-3',
      prompt: 'What is the result of `len({"a":1, "b":2})`?',
      options: ['1', '2', '"ab"', 'TypeError'],
      answer: 1,
      explanation: '`len()` on a dict returns the count of key/value pairs.',
      xp: 20,
    },
    {
      id: 'medium-4',
      prompt: 'Which method removes the last item from a list and returns it?',
      options: ['remove()', 'pop()', 'shift()', 'delete()'],
      answer: 1,
      explanation: '`pop()` without an index removes and returns the last element.',
      xp: 20,
    },
    {
      id: 'medium-5',
      prompt: 'What is a correct way to open a file safely and ensure it closes?',
      options: [
        '`open("file.txt")`',
        '`file = read("file.txt")`',
        '`with open("file.txt") as f:`',
        '`safe_open("file.txt")`',
      ],
      answer: 2,
      explanation: 'A `with` statement creates a context that automatically closes the file.',
      xp: 20,
    },
  ],
  hard: [
    {
      id: 'hard-1',
      prompt: 'Which statement best describes list comprehensions?',
      options: [
        'They are faster loops that only work with numbers',
        'They generate lists using an expression, optional condition, and an iterable',
        'They are functions that automatically return generators',
        'They only work when combined with lambda expressions',
      ],
      answer: 1,
      explanation:
        'List comprehensions let you build a new list from an expression and optional condition evaluated over an iterable.',
      xp: 35,
    },
    {
      id: 'hard-2',
      prompt: 'What is the output of `print({x: x**2 for x in range(2,5)}[3])`?',
      options: ['6', '9', '16', 'KeyError'],
      answer: 1,
      explanation: 'The dictionary comprehension maps 3 to 9, so accessing key 3 prints 9.',
      xp: 35,
    },
    {
      id: 'hard-3',
      prompt: 'Which built-in function converts any iterable into an iterator object?',
      options: ['iter()', 'next()', 'enumerate()', 'zip()'],
      answer: 0,
      explanation: '`iter()` returns an iterator over the given iterable.',
      xp: 35,
    },
    {
      id: 'hard-4',
      prompt: 'What keyword allows you to yield control back to the caller in a generator?',
      options: ['return', 'yield', 'break', 'continue'],
      answer: 1,
      explanation: '`yield` pauses the generator and returns a value to the caller.',
      xp: 35,
    },
    {
      id: 'hard-5',
      prompt: 'Which module is commonly used for working with JSON in Python?',
      options: ['pickle', 'json', 'marshal', 'data'],
      answer: 1,
      explanation: 'The `json` module provides functions to encode and decode JSON data.',
      xp: 35,
    },
    {
      id: 'hard-6',
      prompt: 'How can you merge two dictionaries `a` and `b` into a new one in Python 3.9+?',
      options: ['`a + b`', '`dict(a, **b)`', '`a | b`', '`merge(a, b)`'],
      answer: 2,
      explanation: 'The union operator `|` creates a new dict containing keys from both operands.',
      xp: 35,
    },
    {
      id: 'hard-7',
      prompt: 'What does the walrus operator `:=` do?',
      options: [
        'Assigns a value within an expression',
        'Checks equality between two values',
        'Declares a constant',
        'Specifies function return type',
      ],
      answer: 0,
      explanation: 'The walrus operator assigns a value to a variable as part of an expression.',
      xp: 35,
    },
    {
      id: 'hard-8',
      prompt: 'Which of these creates a set with the values 1, 2, 3?',
      options: ['`(1, 2, 3)`', '`[1, 2, 3]`', '`{1, 2, 3}`', '`set[1,2,3]`'],
      answer: 2,
      explanation: 'Curly braces with comma-separated values create a set literal.',
      xp: 35,
    },
    {
      id: 'hard-9',
      prompt: 'What exception is raised when you access a missing key in a dictionary?',
      options: ['MissingKeyError', 'LookupError', 'KeyError', 'ValueError'],
      answer: 2,
      explanation: 'Python raises a KeyError when the requested key is not present.',
      xp: 35,
    },
    {
      id: 'hard-10',
      prompt: 'Which decorator ensures a method receives the class as the first argument?',
      options: ['@staticmethod', '@classmethod', '@property', '@abstractmethod'],
      answer: 1,
      explanation: '`@classmethod` methods receive the class (`cls`) as the first argument.',
      xp: 35,
    },
  ],
};

// Allow tailoring per chapter later; default to baseQuestions
const chapterChallengeBank = {
  default: baseQuestions,
  1: baseQuestions,
};

export const getChapterChallenges = (chapterId) => {
  return chapterChallengeBank[chapterId] || chapterChallengeBank.default;
};


