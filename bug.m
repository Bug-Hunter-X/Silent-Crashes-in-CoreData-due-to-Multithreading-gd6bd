In Objective-C, a common yet subtle error arises when dealing with `NSManagedObjectContext` and its interaction with threads.  Specifically, attempting to modify a context from a thread other than the one it was created on can lead to unexpected crashes or data corruption. This often manifests without clear error messages, making debugging difficult.  For example:

```objectivec
// Incorrect - Modifying the context from a background thread
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ 
    [managedObjectContext insertObject:newEntity]; // Crash or data corruption likely
});
```