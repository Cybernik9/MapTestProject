//
//  MasterViewController.h
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

