//
// Created by ervinchen on 17/1/24.
// Copyright (c) 2017 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FMDatabase;
@protocol DMDataModeling;

typedef BOOL(^DMSavingTestBlock)(NSString* _Nonnull key, id _Nullable value);
typedef BOOL(^DMExistsTestBlock)(id<DMDataModeling> object, FMDatabase *db);
