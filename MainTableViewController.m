//
//  MainTableViewController.m
//  ExamCoreData
//
//  Created by paradigm creatives on 10/6/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import "MainTableViewController.h"
#import "AppDelegate.h"
#import "DataFile.h"
#import "UpdateViewController.h"
#import "SingletonClass.h"

@interface MainTableViewController ()
{
    AppDelegate *appdelegate;
    
}
@end


@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedobjectcontext=[appdelegate managedObjectContext];
    _fetchedresultcontroller=[self getfetchedresultcontroller];
    _fetchedresultcontroller.delegate=self;
    
    NSError *error=nil;
    SingletonClass *singleton_obj=[SingletonClass sharedInstance];
    [singleton_obj parseJson];
    [self.tableView reloadData];
    [_fetchedresultcontroller performFetch:&error];
}


-(NSFetchedResultsController *)getfetchedresultcontroller{
    
    if (_fetchedresultcontroller!=nil) {
        return _fetchedresultcontroller;
    }
    
    NSFetchRequest *fetchRequest=[[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"DataFile" inManagedObjectContext:_managedobjectcontext];
    
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescript=[[NSSortDescriptor alloc]initWithKey:@"idd" ascending:YES];
    NSArray *descriptArray=[[NSArray alloc] initWithObjects:sortDescript, nil];
    [fetchRequest setSortDescriptors:descriptArray];
    
    
    NSFetchedResultsController *fetchedResultsContrl=[[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedobjectcontext sectionNameKeyPath:nil cacheName:nil];
    return fetchedResultsContrl;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if([_fetchedresultcontroller sections]>0)
    {
        return [[_fetchedresultcontroller sections] count];
    }
    return 0;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo=[[_fetchedresultcontroller sections] objectAtIndex:section];
   // NSLog(@"row are %d",[sectionInfo numberOfObjects]);

    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Mycell" forIndexPath:indexPath];
    
    DataFile *data=[_fetchedresultcontroller objectAtIndexPath:indexPath];

    cell.textLabel.text=data.idd;
    cell.detailTextLabel.text=data.lastmodified;
    return cell;
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        case NSFetchedResultsChangeUpdate:
            if (newIndexPath==nil) {
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationNone];
            }
            else{
                
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                
                [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            
            break;
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
    }
    
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    
    [self.tableView endUpdates];
    
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"updateSegue"])
    {
        //UINavigationController *nav=[segue destinationViewController];
        UpdateViewController *update=[segue destinationViewController];
        
        //transaction.managedobjectcontext=_managedobjectcontext;
        
        NSIndexPath *selectedIndexPath=[self.tableView indexPathForSelectedRow];
        update.selected=[_fetchedresultcontroller objectAtIndexPath:selectedIndexPath];
        
    }

}


@end
