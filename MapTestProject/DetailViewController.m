//
//  DetailViewController.m
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import "DetailViewController.h"
#import "MasterViewController.h"
#import "MapAnnotation.h"

@interface DetailViewController () <LogicCalculatorProtocol>

@property MasterViewController* logicCalculator;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        //self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.logicCalculator = [[MasterViewController alloc] init];
    self.logicCalculator.logicCalculatorDelegate = self;
    
    //[self.logicCalculator getObjectToMaps:0];
    
    MasterViewController* mvc = [[MasterViewController alloc] init];
    
    MapAnnotation* ma = [[MapAnnotation alloc] init];
    ma = [mvc getObjectToMaps:0];
    
    [self.mapView addAnnotation:ma];
    
    ma = [mvc getObjectToMaps:1];
    
    [self.mapView addAnnotation:ma];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapProtocol -

- (void)calculatorLogicDidChangeValue:(MapAnnotation*)value {
    
    [self.mapView addAnnotation:value];
}

- (void)clearButtonDidChange:(NSString*)value {
    
    
}


@end
