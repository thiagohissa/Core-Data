//
//  AddItemViewController.h
//  Every.Do it Again
//
//  Created by Thiago Hissa on 2017-07-19.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Movies+CoreDataClass.h"

@interface AddItemViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *labelTitle;

@property (weak, nonatomic) IBOutlet UITextField *labelDescription;

@property (weak, nonatomic) IBOutlet UITextField *priorityLabel;

@property (weak, nonatomic) IBOutlet UIStepper *myStepper;

@end
