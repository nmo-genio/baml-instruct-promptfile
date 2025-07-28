# baml-instruct-promptfile
BAML file example for instructing students on lessons through chat.

## Overview

This project provides a structured approach to educational content delivery through AI-powered chat interactions. It includes:

- 📚 **Lesson Generation**: Automatically create comprehensive lesson plans
- 💬 **Student Q&A**: Intelligent responses to student questions
- 🔄 **Adaptive Learning**: Modify lessons based on student performance
- 🎯 **Structured Content**: Well-organized educational materials with clear objectives

## Quick Start with PromptFiddle

### 1. Access PromptFiddle
Go to [https://www.promptfiddle.com/](https://www.promptfiddle.com/)

### 2. Create a New Project
Click on "New project" button in the PromptFiddle interface

![PromptFiddle New Project](https://github.com/user-attachments/assets/promptfiddle-new-project.png)

### 3. Copy the BAML Code
Copy the entire contents of `instruct-test.baml` from this repository

### 4. Paste and Run
1. Paste the code into the PromptFiddle editor
2. Select a test to run from the dropdown menu
3. Click "Run" to execute

![PromptFiddle Interface](https://github.com/user-attachments/assets/promptfiddle-interface.png)

## Available Test Cases

### 🐍 **PythonLessonTest**
Generates a beginner-friendly 45-minute lesson on Python functions and parameters.
```baml
test PythonLessonTest {
  functions [GenerateLessonPlan]
  args {
    topic "Python Functions and Parameters"
    level "beginner"
    duration 45
  }
}
```

### ❓ **StudentQuestionTest**
Simulates a student asking about the difference between parameters and arguments.
```baml
test StudentQuestionTest {
  functions [RespondToStudent]
  args {
    query {
      question "I don't understand the difference between parameters and arguments in functions"
      context "I'm working on a function that calculates the area of a rectangle"
      lessonTopic "Python Functions"
      difficultyLevel "beginner"
    }
  }
}
```

### 📊 **PromptFiddleTest** (Recommended)
Comprehensive 60-minute lesson on data structures including arrays, lists, and dictionaries.
```baml
test PromptFiddleTest {
  functions [GenerateLessonPlan]
  args {
    topic "Data Structures in Programming: Arrays, Lists, and Dictionaries"
    level "intermediate"
    duration 60
  }
}
```

### 🔄 **RecursionHelpTest**
Interactive help for a student struggling with recursive functions and debugging.
```baml
test RecursionHelpTest {
  functions [RespondToStudent]
  args {
    query {
      question "I'm trying to write a recursive function..."
      context "Working on recursion exercises in my CS class"
      lessonTopic "Recursion and Recursive Functions"
      difficultyLevel "intermediate"
    }
  }
}

### 🎯 **AdaptLessonTest**
Demonstrates how to adapt a lesson based on student performance and struggling areas.

## Features

### Lesson Structure
Each generated lesson includes:
- **Title & Objectives**: Clear learning goals
- **Prerequisites**: Required prior knowledge
- **Main Content**: Concepts, explanations, and examples
- **Activities**: Interactive exercises with time estimates
- **Assessment**: Methods to evaluate understanding
- **Resources**: Additional learning materials

### Student Interaction
The system provides:
- Direct answers to questions
- Detailed explanations at appropriate levels
- Relevant code examples
- Follow-up questions to check understanding
- Suggested next steps for continued learning

## Example Output

When running the `RecursionHelpTest`, you'll receive a response like:

```json
{
  "answer": "You're getting a stack overflow because your recursive function lacks a base case to stop the recursion.",
  "explanation": "In recursion, a base case is essential to terminate the recursive calls...",
  "examples": [
    "def factorial(n):\n    if n <= 1:  # Base case\n        return 1\n    return n * factorial(n-1)"
  ],
  "followUpQuestions": [
    "What would happen if we called factorial(5)?",
    "Can you identify the base case in the corrected version?"
  ],
  "nextSteps": [
    "Practice writing more recursive functions",
    "Learn about tail recursion optimization"
  ]
}
```

## Customization

You can customize the BAML file for your specific needs:

1. **Add New Classes**: Create structures for different educational content types
2. **Modify Functions**: Adjust the prompts to match your teaching style
3. **Create New Tests**: Add test cases for your specific subjects
4. **Extend Activities**: Include more interactive elements
