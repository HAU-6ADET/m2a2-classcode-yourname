# M2A2: Kilig: Compatibility Checker

**Kind:** take-home practice. Do it on your own time before the next meeting. Searching, AI and helping each other are allowed, because this is practice; record what you used in `SOURCES-AND-ASSISTANCE.md`. The lab exam is closed book, so make sure you understand every line you submit.

This is the first piece of **Kilig**, the anime matchmaking app you build all term: swipe right to like, left to pass, and a mutual like is a match. The demo handled one student's scores; this take-home compares two characters and decides if they are a match. It is syllabus Lab 2.

## Before you start

Follow the [setup guide](SETUP.md) to create and clone your private repository, exactly as in M1A0. The repository is named `m2a2-CLASSCODE-USERNAME`.

## What to build

Pick anime characters you like, from any series. In `lib/compat.dart`, write these functions, which the tests call directly:

- `int sharedInterests(List<String> a, List<String> b)`: how many interests appear in both lists, ignoring capital letters.
- `int ageGap(int ageA, int ageB)`: the difference in age, always zero or positive.
- `int compatibility(List<String> interestsA, int ageA, List<String> interestsB, int ageB)`: a score from 0 to 100. Start with 20 points per shared interest, up to 80, then add 20 if the age gap is 3 or less. Never return more than 100.
- `bool isMatch(int score)`: true from 60 upwards.

`bin/compat.dart` asks how many pairs to check, reads each pair's names, ages and comma-separated interests, and prints each score with **It's a match!** or **Keep swiping**. At the end it prints how many pairs matched.

## Concepts to research

- Repeating the same questions a number of times chosen by the user.
- Splitting text on commas and comparing it without caring about capital letters.
- Keeping a running total under a cap.
- Functions that return `bool`.

## How it is graded

10 test points for correctness: the functions are tested with edge cases such as no shared interests, an age gap of exactly 3 and a score that would pass 100. 10 rubric points for logical design (10, 7, 4 or 1).

Every activity also checks `student.json`: fill in your full name, student number, school email, class code, GitHub username, `room` and `pcNumber`, all as text.

## Check and save your work

```sh
dart analyze
dart test
```

The tests in your repository are a guide. The instructor grades from the course's own copy of the tests, so do not edit the tests to make them pass.

```sh
git status
git add bin/ lib/ student.json SOURCES-AND-ASSISTANCE.md
git commit -m "Complete M2A2"
```

In VS Code, open **Source Control** and choose **Push**, then check that the commit appears on GitHub.

## Submit the exact commit link in Canvas

Open your repository's commit history on GitHub, open the commit with your finished work, copy its full URL (it contains **/commit/**), and submit it in the Canvas assignment for M2A2 using the Website URL option. Submit the commit page, not the repository home page or a screenshot.
