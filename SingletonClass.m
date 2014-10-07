//
//  SingletonClass.m
//  ExamCoreData
//
//  Created by paradigm creatives on 10/7/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import "SingletonClass.h"
#import "DataFile.h"
#import "AppDelegate.h"


@implementation SingletonClass

 NSFetchedResultsController *fetchedresultcontroller;
 NSManagedObjectContext *managedobjectcontext;
 AppDelegate *appdelegate;
NSMutableData *jsondata;
NSMutableArray *arr;


static SingletonClass *sharedInstance=nil;
+(SingletonClass *)sharedInstance{
    if(sharedInstance==nil)
    {
        sharedInstance=[[super allocWithZone:NULL]init];
    }
    return sharedInstance;
}
-(void)parseJson
{
    appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    managedobjectcontext=[appdelegate managedObjectContext];
    jsondata=[[NSMutableData alloc]init];
    arr=[[NSMutableArray alloc]init];
    NSURL *url=[NSURL URLWithString:@"http://fotobom.it/ws/feed/fotobom/all/all/all/friends/all/10/1"];
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    NSURLConnection *con=[NSURLConnection connectionWithRequest:req delegate:self];
    [con start];
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    NSLog(@"%@",[error localizedDescription]);
    
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    NSLog(@"Recieved Response");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [jsondata appendData:data];
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    id jsonObject=[NSJSONSerialization JSONObjectWithData:jsondata options:0 error:nil];
    arr=(NSMutableArray *)jsonObject;
    DataFile *data;
    for(NSMutableDictionary *jsondict in arr)
    {
        //NSFetchRequest *fetchRequest=[NSFetchRequest fetchRequestWithEntityName:@"DataFile"];

        data=[NSEntityDescription insertNewObjectForEntityForName:@"DataFile" inManagedObjectContext:managedobjectcontext];
       // data=[[managedobjectcontext executeFetchRequest:fetchRequest error:nil] lastObject];

        NSLog(@" id is %@",[jsondict valueForKey:@"id"]) ;
        data.idd=[jsondict valueForKey:@"id"];
        data.name=[jsondict valueForKey:@"name"];
        data.bomburl=[jsondict valueForKey:@"bomburl"];
        data.target=[jsondict valueForKey:@"target"];
        data.targeturl=[jsondict valueForKey:@"targeturl"];
        data.title=[jsondict valueForKey:@"title"];
        data.privacy=[jsondict valueForKey:@"privacy"];
        data.descriptions=[jsondict valueForKey:@"description"];
        data.lastmodified=[jsondict valueForKey:@"last_modified"];
        data.username=[jsondict valueForKey:@"username"];
        data.email=[jsondict valueForKey:@"email"];
        data.photourl=[jsondict valueForKey:@"photourl"];
        NSError *error=nil;
        [managedobjectcontext save:&error];
    }
    data=nil;
}
@end
