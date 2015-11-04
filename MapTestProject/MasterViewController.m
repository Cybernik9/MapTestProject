//
//  MasterViewController.m
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "MapAnnotation.h"
#import "Cell.h"
#import <MapKit/MapKit.h>

@interface MasterViewController ()

//@property NSMutableArray *objectsJSON;
//@property NSMutableArray *objectsPlist;

@end

@implementation MasterViewController

static NSMutableArray *objectsJSON;
static NSMutableArray *objectsPlist;

- (void)awakeFromNib {
    [super awakeFromNib];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    objectsJSON = [[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    objectsJSON = [[NSMutableArray alloc] initWithArray:[self getJSON]];
    objectsPlist = [[NSMutableArray alloc] initWithArray:[self getPlist]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {

//    for (int i=0; i<[self.objectsJSON count]; i++) {
//        [self getObjectToMaps:i];
//    }
    
    
//    ASMapAnnotation* annotation = [[ASMapAnnotation alloc] init];
//    
//    annotation.title = @"Test Title";
//    annotation.subtitle = @"Test Subtitle";
//    annotation.coordinate = self.mapView.region.center;
//    
//    [self.mapView addAnnotation:annotation];
    
    
}

- (void)setJSON:(NSString*)name  lat:(CGFloat)lat long:(CGFloat)longg {
    
    NSMutableArray* array = [[NSMutableArray alloc] initWithArray:[self getJSON]];
    
    NSDictionary* dictionary =
    [NSDictionary dictionaryWithObjectsAndKeys:
     @"name", name,
     @"lat", @(lat),
     @"long", @(longg), nil];
    
    [array addObject:dictionary];
    
    NSURL *path =  [[NSBundle mainBundle] URLForResource:@"Directions" withExtension:@"geojson"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:array options:0 error:nil];
    [data writeToURL:path atomically:YES];
//    NSData *data = [NSData dataWithContentsOfURL:path];
//    NSError *error = nil;
//    NSJSONSerialization *JSONObjectWithData = [[NSJSONSerialization alloc] init];

}

- (NSArray*)getJSON {
    
    NSURL *path =  [[NSBundle mainBundle] URLForResource:@"Directions" withExtension:@"geojson"];
    NSData *data = [NSData dataWithContentsOfURL:path];
    NSError *error = nil;
    NSArray * array = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    
    if (error == nil) {
        NSLog(@"Json:\n%@", array);
    }
    else {
        NSLog(@"error %@", [error localizedDescription]);
    }
    
    return array;
}

- (NSArray*)getPlist {
    
    NSURL *path =  [[NSBundle mainBundle] URLForResource:@"Directions" withExtension:@"geojson"];
    path = [[NSBundle mainBundle] URLForResource:@"PropertyList" withExtension:@"plist"];
    NSArray *dict = [NSArray arrayWithContentsOfURL:path];
    NSLog(@"Plist:\n%@", dict);
    
    return dict;
}

- (MapAnnotation*)getObjectToMaps:(NSInteger)count {
    
    //[self.objectsJSON addObjectsFromArray:[self getJSON]];
    
    //for (int i = 0; i < [self.objectsJSON count]; i++) {
    
    NSDictionary* dictionary = [objectsJSON objectAtIndex:count];
    
    //CGFloat latitude = [[dictionary objectForKey:@"lat"] doubleValue];
    //CGFloat longitude = [[dictionary objectForKey:@"long"] doubleValue];
    
    //DetailViewController* detailViewController = [[DetailViewController alloc] init];
    
    MapAnnotation* annotation = [[MapAnnotation alloc] init];
    
    
    //annotation.coordinate = detailViewController.mapView.region.center;
    
    CLLocationDegrees latitude = [[dictionary objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[dictionary objectForKey:@"long"] doubleValue];
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = latitude;
    coordinate.longitude = longitude;
    
    annotation.title = [NSString stringWithFormat:@"latitude = %f", latitude];
    annotation.subtitle = [NSString stringWithFormat:@"longitude = %f", longitude];
    
    annotation.coordinate = coordinate;
    
    //[self.logicCalculatorDelegate calculatorLogicDidChangeValue:annotation];
    
    //}
    //[detailViewController.mapView addAnnotation:annotation];
    
    return annotation;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = objectsJSON[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return objectsJSON.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell && indexPath.row != 0) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        
        Cell* cell = [[Cell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
        
        cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
        
        return cell;
    }
    else {
        
        NSDictionary* dictionary = [objectsJSON objectAtIndex:indexPath.row-1];
        
        cell.textLabel.text = [dictionary objectForKey:@"name"];
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [objectsJSON removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
