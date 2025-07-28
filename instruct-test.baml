// BAML configuration for student lesson instruction system
// This file defines the structure for delivering educational content through chat
//
// Citation:
// @software{baml,
//   author = {Vaibhav Gupta, Aaron Villalpando and Boundary ML team},
//   title = {BAML},
//   url = {https://github.com/boundaryml/baml},
//   year = {2024}
// }

// Define the structure of a lesson
class Lesson {
  title string @description("The main topic or title of the lesson")
  objectives string[] @description("Learning objectives for this lesson")
  prerequisites string[] @description("Prior knowledge required")
  content LessonContent @description("Main lesson content")
  activities Activity[] @description("Interactive activities or exercises")
  assessment Assessment @description("How to evaluate student understanding")
  resources string[] @description("Additional learning resources")
}

class LessonContent {
  introduction string @description("Brief introduction to the topic")
  mainConcepts Concept[] @description("Key concepts to be taught")
  examples Example[] @description("Practical examples")
  summary string @description("Lesson summary and key takeaways")
}

class Concept {
  name string
  explanation string
  importance string @description("Why this concept matters")
  relatedTopics string[] @description("Connected concepts")
}

class Example {
  description string
  code string? @description("Optional code example if applicable")
  explanation string
  commonMistakes string[] @description("Common errors to avoid")
}

class Activity {
  type string @description("quiz, exercise, discussion, project")
  instructions string
  expectedDuration int @description("Time in minutes")
  difficulty string @description("beginner, intermediate, advanced")
}

class Assessment {
  type string @description("formative or summative")
  criteria string[] @description("Success criteria")
  rubric string? @description("Optional grading rubric")
}

// Define student interaction structure
class StudentQuery {
  question string
  context string? @description("Optional context about where they're stuck")
  lessonTopic string
  difficultyLevel string @description("Current understanding level")
}

class InstructorResponse {
  answer string @description("Direct answer to the question")
  explanation string @description("Detailed explanation")
  examples string[] @description("Relevant examples")
  followUpQuestions string[] @description("Questions to check understanding")
  nextSteps string[] @description("What to study next")
}

// Function to generate a lesson plan
function GenerateLessonPlan(topic: string, level: string, duration: int) -> Lesson {
  client GPT4o
  
  prompt #"
    Create a comprehensive lesson plan for teaching {{ topic }} to {{ level }} level students.
    The lesson should be designed for {{ duration }} minutes.
    
    Include:
    1. Clear learning objectives
    2. Prerequisite knowledge needed
    3. Main concepts with explanations
    4. Practical examples
    5. Interactive activities
    6. Assessment methods
    7. Additional resources
    
    Make the content engaging and appropriate for the skill level.
    
    {{ ctx.output_format }}
  "#
}

// Function to respond to student questions
function RespondToStudent(query: StudentQuery) -> InstructorResponse {
  client GPT4o
  
  prompt #"
    A student has asked the following question about {{ query.lessonTopic }}:
    
    Question: {{ query.question }}
    {% if query.context %}
    Context: {{ query.context }}
    {% endif %}
    Student Level: {{ query.difficultyLevel }}
    
    Provide a helpful response that:
    1. Directly answers their question
    2. Explains the concept clearly at their level
    3. Provides concrete examples
    4. Includes follow-up questions to check understanding
    5. Suggests next learning steps
    
    Be encouraging and supportive in your tone.
    
    {{ ctx.output_format }}
  "#
}

// Function to adapt lesson content based on student progress
function AdaptLesson(
  originalLesson: Lesson, 
  studentPerformance: string, 
  strugglingAreas: string[]
) -> Lesson {
  client GPT4o
  
  prompt #"
    Given the original lesson plan and student performance data, adapt the lesson to better meet the student's needs.
    
    Original Lesson: {{ originalLesson.title }}
    Student Performance: {{ studentPerformance }}
    Areas of Difficulty: {{ strugglingAreas | join(", ") }}
    
    Modify the lesson to:
    1. Provide additional support in struggling areas
    2. Adjust the pace if needed
    3. Add more examples where concepts are unclear
    4. Simplify or expand explanations as appropriate
    
    {{ ctx.output_format }}
  "#
}

// Test case for generating a Python lesson
test PythonLessonTest {
  functions [GenerateLessonPlan]
  args {
    topic "Python Functions and Parameters"
    level "beginner"
    duration 45
  }
}

// Test case for student interaction
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

// Test case for lesson adaptation
test AdaptLessonTest {
  functions [AdaptLesson]
  args {
    originalLesson {
      title "Introduction to Python Lists"
      objectives ["Understand list basics", "Learn list methods", "Practice list manipulation"]
      prerequisites ["Basic Python syntax", "Variables"]
      content {
        introduction "Lists are ordered collections in Python"
        mainConcepts [{
          name "List Creation"
          explanation "Lists are created using square brackets"
          importance "Fundamental data structure in Python"
          relatedTopics ["Arrays", "Tuples"]
        }]
        examples [{
          description "Creating a simple list"
          code "my_list = [1, 2, 3, 4, 5]"
          explanation "This creates a list of integers"
          commonMistakes ["Forgetting square brackets", "Mixing data types unintentionally"]
        }]
        summary "Lists are versatile containers for storing multiple values"
      }
      activities [{
        type "exercise"
        instructions "Create a list of your favorite foods and print each item"
        expectedDuration 10
        difficulty "beginner"
      }]
      assessment {
        type "formative"
        criteria ["Can create lists", "Can access list elements", "Understands list indexing"]
        rubric "Full marks for correct syntax and understanding"
      }
      resources ["Python documentation on lists", "Interactive Python tutorial"]
    }
    studentPerformance "Struggling with list indexing and methods"
    strugglingAreas ["Understanding zero-based indexing", "Remembering list method syntax"]
  }
}

// Comprehensive test for PromptFiddle - Data Structures Lesson
test PromptFiddleTest {
  functions [GenerateLessonPlan]
  args {
    topic #"
      Data Structures in Programming: Arrays, Lists, and Dictionaries
      
      This lesson should cover:
      - What data structures are and why they're important
      - Arrays: fixed-size, indexed collections
      - Lists: dynamic collections (using Python as example)
      - Dictionaries: key-value pairs
      - When to use each data structure
      - Basic operations (add, remove, access, iterate)
      - Real-world applications
    "#
    level "intermediate"
    duration 60
  }
}

// Interactive test for student struggling with recursion
test RecursionHelpTest {
  functions [RespondToStudent]
  args {
    query {
      question #"
        I'm trying to write a recursive function to calculate factorial but I keep getting a stack overflow error. 
        Here's my code:
        def factorial(n):
            return n * factorial(n-1)
        
        What am I doing wrong?
      "#
      context "Working on recursion exercises in my CS class"
      lessonTopic "Recursion and Recursive Functions"
      difficultyLevel "intermediate"
    }
  }
}
