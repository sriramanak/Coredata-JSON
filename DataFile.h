//
//  DataFile.h
//  ExamCoreData
//
//  Created by paradigm creatives on 10/6/14.
//  Copyright (c) 2014 Paradigm Creatives. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DataFile : NSManagedObject

@property (nonatomic, retain) NSString * idd;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * bomburl;
@property (nonatomic, retain) NSString * target;
@property (nonatomic, retain) NSString * targeturl;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * privacy;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * lastmodified;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * photourl;

@end
