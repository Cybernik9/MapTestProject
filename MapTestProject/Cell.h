//
//  Cell.h
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UISegmentedControl *JSONOrPlisteSgmented;
- (IBAction)actionJSONPlistSegmented:(id)sender;

@end
