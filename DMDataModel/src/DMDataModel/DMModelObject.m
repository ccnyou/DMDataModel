//
//  DMModelObject.m
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import "DMModelObject.h"
#import "DMDataCore.h"

@implementation DMModelObject

// 通过主键获取对象
+ (instancetype)objectWithId:(id)objectId {
    return nil;
}

// 通过 where 获取对象
+ (NSArray *)objectsWhere:(NSString *)where arguments:(NSArray *)arguments {
    return nil;
}

// 保存到数据库
- (BOOL)save {
    DMDataCore* core = [DMDataCore sharedInstance];
    NSString* dbPath = [self.class dbPath];
    DMDataOperaotr* operator = [core operatorForDbPath:dbPath];
    BOOL result = [operator saveObject:self];
    return result;
}

// 每一列对应的名字
+ (NSString *)columnForProperty:(NSString *)property {
    NSString* columnName = [NSString stringWithFormat:@"f_%@", property];
    return columnName;
}

+ (NSString *)dbDirectory {
    static NSString* documentPath = nil;
    if (!documentPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        documentPath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    }
    
    return documentPath;
}

+ (NSString *)dbPath {
    NSString* directory = [self dbDirectory];
    NSString* dbName = [self dbName];
    NSString* dbPath = [directory stringByAppendingPathComponent:dbName];
    return dbPath;
}

// 数据库名字
+ (NSString *)dbName {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 表名
+ (NSString *)tableName {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 要持久化的属性
+ (NSArray<NSString *> *)persistentProperties {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 主键
+ (NSString *)primaryKey {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}


@end
