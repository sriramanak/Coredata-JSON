//
//  MainTableViewController.h
//  ExamCoreData
//
//  Created by paradigm creatives on 10/6/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface MainTableViewController : UITableViewController<NSURLConnectionDataDelegate,NSFetchedResultsControllerDelegate,UIAlertViewDelegate>

@property(nonatomic,strong) NSFetchedResultsController *fetchedresultcontroller;
@property(nonatomic,strong) NSManagedObjectContext *managedobjectcontext;

//+ (MainTableViewController*)sharedInstance;

@end