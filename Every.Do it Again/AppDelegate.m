//
//  AppDelegate.m
//  Every.Do it Again
//
//  Created by Thiago Hissa on 2017-07-19.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "AppDelegate.h"
#import "Movies+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    // My Code
    _context = self.persistentContainer.viewContext;
//    [self createMovie];
//    [self deleteObject];
//    [self basicFetch];
    
    
    return YES;
}



- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}





#pragma  Creating Movies for testing

-(void)createMovie{
    Movies *matrix = [[Movies alloc]initWithContext:self.context];
    matrix.name = @"The Matrix";
    matrix.briefDescription = @"This movie is awesome";
    matrix.priority = 1;
    [self saveContext];
}


#pragma Basic Fetch

- (NSArray <Movies*>*)basicFetch {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movies"];
    NSArray <Movies *>*movies = [self.context executeFetchRequest:request error:nil];
    [self printMovies:movies];
    return movies;
}

#pragma Fetch With Sort

- (void)fetchWithSort {
    NSSortDescriptor *prioritySort = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movies"];
    request.sortDescriptors = @[prioritySort];
    NSArray <Movies *>*movies = [self.context executeFetchRequest:request error:nil];
    [self printMovies:movies];
}

#pragma Fetch With Filter

- (Movies *)fetchWithFilter {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"priority > -1"];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movies"];
    request.predicate = predicate;
    NSArray <Movies *>*movies = [self.context executeFetchRequest:request error:nil];
    [self printMovies:movies];
    return movies.firstObject;
}

#pragma Delete Object

- (void)deleteObject {
    Movies *deleteMovie = [self fetchWithFilter];
    NSLog(@"'%@' Movie was deleted",deleteMovie.name);
    [self.context deleteObject:deleteMovie];
    [self saveContext];
//    [self printMovies:[self basicFetch]];
}

#pragma Update Object

- (void)updatePerson {
    Movies *updateMoviePriority = [self fetchWithFilter];
    updateMoviePriority.priority += 1;
    [self saveContext];
}




- (void)printMovies:(NSArray <Movies *>*)movies {
    for (Movies *mov in movies) {
        NSLog(@"%d: %@", __LINE__,[NSString stringWithFormat:@"%@ has priority %@",mov.name, @(mov.priority)]);
    }
}









#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Every_Do_it_Again"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
