//
//  MyTableViewCell.h
//  Every.Do it Again
//
//  Created by Thiago Hissa on 2017-07-19.
//  Copyright © 2017 Thiago Hissa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *cellLabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *cellLabelSub;

@property (weak, nonatomic) IBOutlet UILabel *cellPriorityLabel;

@end
