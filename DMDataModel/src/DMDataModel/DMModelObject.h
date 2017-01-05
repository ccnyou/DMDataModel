//
//  DMModelObject.h
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMDataModeling.h"

@interface DMModelObject : NSObject<DMDataModeling>

// 通过主键获取对象
+ (instancetype)dm_objectWithId:(id)objectId;

// 通过 where 获取对象
+ (NSArray *)dm_objectsWhere:(NSString *)where arguments:(NSArray *)arguments;

// 数据库名字
+ (NSString *)dm_dbName;

// 表名
+ (NSString *)dm_tableName;

// 要持久化的属性
+ (NSArray<NSString *> *)dm_persistentPropertys;

// 主键
+ (NSString *)dm_primaryKey;

// 保存到数据库
- (BOOL)dm_save;

// 每一列对应的名字
+ (NSString *)dm_columnForProperty:(NSString *)property;

// 数据库的全路径
+ (NSString *)dm_dbPath;

@end
