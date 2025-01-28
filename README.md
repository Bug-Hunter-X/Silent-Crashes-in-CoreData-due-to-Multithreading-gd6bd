# Objective-C CoreData Multithreading Bug

This repository demonstrates a common, yet difficult-to-debug issue in Objective-C related to CoreData and thread safety.  Attempting to modify an `NSManagedObjectContext` from a thread other than the one it was created on can lead to silent crashes or data corruption. This example highlights the problem and provides a solution.

## Bug
The `bug.m` file contains code that attempts to insert a new entity into a managed object context from a background thread. This violates CoreData's thread safety rules and results in unpredictable behavior. 

## Solution
The `bugSolution.m` file demonstrates the correct approach using NSManagedObjectContext's concurrency features. It utilizes a dedicated context for background operations, ensuring thread safety and preventing crashes.

## How to Reproduce
1. Clone the repository.
2. Open the project in Xcode.
3. Run the app. Observe the unpredictable behavior in the original buggy version.
4. Switch to the `bugSolution.m` and run again; the app should run without error.