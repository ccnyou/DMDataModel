//
//  Sample.m
//  DMDataModel
//
//  Created by ervinchen on 17/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import "Sample.h"

@implementation Sample

+ (NSString *)dm_primaryKey {
    return NSStringFromSelector(@selector(sampleId));
}

+ (NSString *)dm_dbName {
    return @"Test.db";
}

// 表名
+ (NSString *)dm_tableName {
    return NSStringFromClass([self class]);
}

// 要持久化的属性
+ (NSArray<NSString *> *)dm_persistentProperties {
    static NSArray* properties = nil;
    if (!properties) {
        properties = @[
                       @"sampleId",
                       @"string",
                       @"date",
                       @"timeInterval",
                       @"data"
                       ];
    }
    
    return properties;
}


@end
