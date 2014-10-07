
//
//  UpdateViewController.m
//  ExamCoreData
//
//  Created by paradigm creatives on 10/6/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import "UpdateViewController.h"
#import "AppDelegate.h"

@interface UpdateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *privacyField;
@property (weak, nonatomic) IBOutlet UITextField *photo_urlField;
- (IBAction)UpdateClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *bomburlField;
@property (weak, nonatomic) IBOutlet UILabel *idlbl;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *idField;
@property (weak, nonatomic) IBOutlet UITextField *iddField;

@end

@implementation UpdateViewController
{
    AppDelegate *appdelegate;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _iddField.text=_selected.idd;
    _nameField.text=_selected.name;
    _emailField.text=_selected.email;
    _photo_urlField.text=_selected.photourl;
    _privacyField.text=_selected.privacy;
    _bomburlField.text=_selected.bomburl;
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

- (IBAction)UpdateClicked:(id)sender {
   
    NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"DataFile"];
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"idd==%@",_selected.idd];
    fetchRequest.predicate=predicate;
    DataFile *newdata=[[_managedobjectcontext executeFetchRequest:fetchRequest error:nil] lastObject];
    
    newdata.idd=_iddField.text;
    newdata.name=_nameField.text;
    newdata.email=_emailField.text;
    newdata.photourl=_photo_urlField.text;
    newdata.privacy=_privacyField.text;
    newdata.bomburl=_bomburlField.text;
    
    NSError *error=nil;
    [_managedobjectcontext save:&error];
    [self.navigationController popViewControllerAnimated:YES];
    
}
@end
