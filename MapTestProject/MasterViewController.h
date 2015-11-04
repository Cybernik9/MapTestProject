//
//  MasterViewController.h
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapAnnotation.h"

@class DetailViewController;

@protocol LogicCalculatorProtocol <NSObject>

- (void) calculatorLogicDidChangeValue:(MapAnnotation *)value;
- (void) clearButtonDidChange:(NSString*)value;

@end

@interface MasterViewController : UITableViewController

@property (nonatomic, weak) NSObject <LogicCalculatorProtocol> *logicCalculatorDelegate;

@property (strong, nonatomic) DetailViewController *detailViewController;

- (MapAnnotation*)getObjectToMaps:(NSInteger)count;

@end

