//
//  AddDataViewController.m
//  ExamCoreData
//
//  Created by paradigm creatives on 10/7/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import "AddDataViewController.h"
#import "DataFile.h"
#import "AppDelegate.h"
#import "MainTableViewController.h"

@interface AddDataViewController ()
{
    AppDelegate *appdelegate;
    
}
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *bomburlField;
@property (weak, nonatomic) IBOutlet UITextField *photoField;
@property (weak, nonatomic) IBOutlet UITextField *ptotourlField;
@property (weak, nonatomic) IBOutlet UITextField *privacyField;
- (IBAction)addToCoreData:(id)sender;

@end

@implementation AddDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    _managedobjectcontext=[appdelegate managedObjectContext];
    _fetchedresultcontroller=[self getfetchedresultcontroller];
    _fetchedresultcontroller.delegate=self;

    NSError *error=nil;
    [_fetchedresultcontroller performFetch:&error];

    // Do any additional setup after loading the view.
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addToCoreData:(id)sender {
    
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"DataFile"];
    DataFile *data=[[_managedobjectcontext executeFetchRequest:fetchRequest error:nil] lastObject];

    data.idd=_idField.text;
    data.name=_nameField.text;
    data.bomburl=_bomburlField.text;
    data.photo=_photoField.text;
    data.photo=_privacyField.text;
    data.email=_emailField.text;
    data.photourl=_ptotourlField.text;
    NSError *error=nil;
    [_managedobjectcontext save:&error];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

@end
