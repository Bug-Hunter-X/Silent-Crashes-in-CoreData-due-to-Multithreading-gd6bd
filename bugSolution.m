To rectify the thread safety issue, use a private queue and a separate context for background operations. This ensures that the main context is only modified on the main thread. 

```objectivec
NSManagedObjectContext *privateContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
[privateContext performBlock:^{ 
    NSManagedObject *newEntity = [NSEntityDescription insertNewObjectForEntityForName:@"YourEntityName" inManagedObjectContext:privateContext];
    // ... modify newEntity ...
    NSError *error = nil; 
    if (![privateContext save:&error]) {
        NSLog("Error saving private context: %@
", error);
    }
    // Save the changes to the main context
    dispatch_async(dispatch_get_main_queue(), ^{ 
        NSError *error = nil; 
        if (![managedObjectContext save:&error]) {
            NSLog("Error saving main context: %@
", error); 
        }
    });
}];
```
This approach uses a private context on a background thread to perform the changes and saves it. Then it uses dispatch_async to push the changes to the main thread and perform another save operation to persist the changes.