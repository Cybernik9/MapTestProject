//
//  MasterViewController.m
//  MapTestProject
//
//  Created by Yurii Huber on 02.11.15.
//  Copyright (c) 2015 Yurii Huber. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Cell.h"

@interface MasterViewController ()

@property NSMutableArray *objectsJSON;
@property NSMutableArray *objectsPlist;

@end

@implementation MasterViewController

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
    self.objectsJSON = [[NSMutableArray alloc] init];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
    
    self.objectsJSON = [[NSMutableArray alloc] initWithArray:[self getJSON]];
    self.objectsPlist = [[NSMutableArray alloc] initWithArray:[self getPlist]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
//    if (!self.objects) {
//        self.objects = [[NSMutableArray alloc] init];
//    }
//    [self.objects insertObject:[NSDate date] atIndex:0];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objectsJSON[indexPath.row];
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
    return self.objectsJSON.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* identifier = @"Cell";
    
    Cell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSDictionary* dictionary = [self.objectsJSON objectAtIndex:indexPath.row];
    
    cell.cityTextLable.text = [dictionary objectForKey:@"name"];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objectsJSON removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
