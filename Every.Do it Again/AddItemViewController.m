//
//  AddItemViewController.m
//  Every.Do it Again
//
//  Created by Thiago Hissa on 2017-07-19.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import "AddItemViewController.h"

@interface AddItemViewController ()
@property (weak, nonatomic) AppDelegate *appDelegate;
@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic) Movies *newmovie;
@end

@implementation AddItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.context = self.appDelegate.context;
    [self.myStepper setMaximumValue:10];
    [self.myStepper setMinimumValue:1];
}

- (IBAction)stepperMethod:(id)sender {
    self.priorityLabel.text = [NSString stringWithFormat:@"Priority %d",(int)self.myStepper.value];
}

- (IBAction)saveItemButton:(id)sender {
    [self saveNewMovie];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)saveNewMovie{
    NSString *name = self.labelTitle.text;
    NSString *briefDescrp = self.labelDescription.text;
    int16_t priority = (int)self.myStepper.value;
    Movies *movie = [[Movies alloc]initWithContext:self.context];
    movie.name = name;
    movie.briefDescription = briefDescrp;
    movie.priority = priority;
    [self.appDelegate saveContext];
}




@end
