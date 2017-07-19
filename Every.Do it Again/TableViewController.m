//
//  TableViewController.m
//  Every.Do it Again
//
//  Created by Thiago Hissa on 2017-07-19.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "TableViewController.h"
#import "MyTableViewCell.h"
#import "AppDelegate.h"
#import "Movies+CoreDataClass.h"

@interface TableViewController ()
@property (strong, nonatomic) NSManagedObjectContext *context;
@property (nonatomic) NSArray<Movies*> *movies;
@property (weak, nonatomic) AppDelegate *appDelegate;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context = self.appDelegate.context;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self fetchWithSort];
}


#pragma Set Array of Movies

- (void)setMovies:(NSArray<Movies *> *)movies {
    _movies = movies;
    [self.tableView reloadData];
}

#pragma Fetch for priority

- (void)fetchWithSort {
    NSSortDescriptor *prioritySort = [NSSortDescriptor sortDescriptorWithKey:@"priority" ascending:NO];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Movies"];
    request.sortDescriptors = @[prioritySort];
    NSArray <Movies*>*result = [self.context executeFetchRequest:request error:nil];
    self.movies = result;
}









#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    Movies *thisMovie = self.movies[indexPath.row];
    
    cell.cellLabelTitle.text = thisMovie.name;
    cell.cellLabelSub.text = thisMovie.briefDescription;
    cell.cellPriorityLabel.text = [NSString stringWithFormat:@"%d", thisMovie.priority];
    
    return cell;
}




// Delete Function

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.context deleteObject:self.movies[indexPath.row]];
    [self.appDelegate saveContext];
    [self.tableView reloadData];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
