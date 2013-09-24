//
//  ZJMasterViewController.m
//  AdvancedDynamic
//
//  Created by Zhu J on 9/23/13.
//  Copyright (c) 2013 Zhu J. All rights reserved.
//

#import "ZJMasterViewController.h"

//#import "ZJDetailViewController.h"
#import "ZJDynamicsViewController.h"
#import "ZJCollisionsViewController.h"
#import "ZJCollectionViewController.h"

@interface ZJMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation ZJMasterViewController

- (void)awakeFromNib
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        self.clearsSelectionOnViewWillAppear = NO;
        self.preferredContentSize = CGSizeMake(320.0, 600.0);
    }
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    if (!_objects) {
        _objects = [[NSMutableArray alloc] initWithObjects:@"Spring Attachment",@"Collision Objects",@"Collections", nil];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = nil;
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }

    NSString *object = _objects[indexPath.row];
    cell.textLabel.text = object;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *obj = _objects[indexPath.row];
    switch (indexPath.row)
    {
        case 0:
        {
            ZJDynamicsViewController *dynamicsVC = [[ZJDynamicsViewController alloc] initWithNibName:nil bundle:nil];
            dynamicsVC.title = obj;
            [self.navigationController pushViewController:dynamicsVC animated:YES];
            break;
        }
        case 1:
        {
            ZJCollisionsViewController *dynamicsVC = [[ZJCollisionsViewController alloc] initWithNibName:nil bundle:nil];
            dynamicsVC.title = obj;
            [self.navigationController pushViewController:dynamicsVC animated:YES];
            break;
        }
        case 2:
        {
            ZJCollectionViewController  *collectionsVC = [[ZJCollectionViewController alloc] initWithSampleLayout];
            collectionsVC.title = obj;
            [self.navigationController pushViewController:collectionsVC animated:YES];
            break;
        }
        default:
            break;
    }
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
//        NSDate *object = _objects[indexPath.row];
//        self.detailViewController.detailItem = object;
//    }
}

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([[segue identifier] isEqualToString:@"showDetail"]) {
//        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//        NSDate *object = _objects[indexPath.row];
//        [[segue destinationViewController] setDetailItem:object];
//    }
//}

@end
