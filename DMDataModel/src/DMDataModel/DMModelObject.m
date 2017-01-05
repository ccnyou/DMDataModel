//
//  DMModelObject.m
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import "DMModelObject.h"

@implementation DMModelObject

// 通过主键获取对象
+ (instancetype)dm_objectWithId:(id)objectId {
    return nil;
}

// 通过 where 获取对象
+ (NSArray *)dm_objectsWhere:(NSString *)where arguments:(NSArray *)arguments {
    return nil;
}

// 保存到数据库
- (BOOL)dm_save {
    return NO;
}

// 每一列对应的名字
+ (NSString *)dm_columnForProperty:(NSString *)property {
    return nil;
}

// 数据库的全路径
+ (NSString *)dm_dbPath {
    return nil;
}

// 数据库名字
+ (NSString *)dm_dbName {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 表名
+ (NSString *)dm_tableName {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 要持久化的属性
+ (NSArray<NSString *> *)dm_persistentPropertys {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}

// 主键
+ (NSString *)dm_primaryKey {
    NSAssert(NO, @"Should use method of a subclass.");
    return nil;
}


@end
