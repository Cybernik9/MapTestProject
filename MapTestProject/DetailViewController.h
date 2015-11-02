//
//  DetailViewController.h
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

