//
//  UpdateViewController.h
//  ExamCoreData
//
//  Created by paradigm creatives on 10/6/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataFile.h"
#import <CoreData/CoreData.h>

@interface UpdateViewController : UIViewController<NSFetchedResultsControllerDelegate>

@property(nonatomic,strong) NSFetchedResultsController *fetchedresultcontroller;
@property(nonatomic,strong) NSManagedObjectContext *managedobjectcontext;

@property(nonatomic,strong)DataFile *selected;
    

@end
