//
//  LoginViewController.m
//  ExamCoreData
//
//  Created by paradigm creatives on 10/7/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import "LoginViewController.h"
#import "MainTableViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
- (IBAction)loginClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_username becomeFirstResponder];
    
    // Do any additional setup after loading the view.
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


- (IBAction)loginClicked:(id)sender {
    [_password resignFirstResponder];
    NSString *name=_username.text;
    NSString *pwd=_password.text;
    NSString *msg;
    
    
    if(([name isEqualToString:@""])&&([pwd isEqualToString:@""]))
    {
        msg=@"USERNAME AND PASSWORD ARE EMPTY";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
        [alert show];
    }
    else if(([name isEqualToString:@""]))
    {
        msg=@"user name is empty";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
        [alert show];
    }
    else if(([pwd isEqualToString:@""]))
    {
        msg=@"password is empty";
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"error" message:msg delegate:self cancelButtonTitle:@"ok" otherButtonTitles:@"cancel", nil];
        [alert show];
    }
    else
    {
        UIStoryboard *stryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        MainTableViewController *nvc =[stryBoard instantiateViewControllerWithIdentifier:@"MainMain"];
        [self.navigationController pushViewController:nvc animated:YES];
    }
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


@end
