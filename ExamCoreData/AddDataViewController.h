//
//  AddDataViewController.h
//  ExamCoreData
//
//  Created by paradigm creatives on 10/7/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AddDataViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong) NSFetchedResultsController *fetchedresultcontroller;
@property(nonatomic,strong) NSManagedObjectContext *managedobjectcontext;
@end
