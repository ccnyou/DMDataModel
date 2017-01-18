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
+ (instancetype)objectWithId:(id)objectId;

// 通过 where 获取对象
+ (NSArray *)objectsWhere:(NSString *)where arguments:(NSArray *)arguments;

// 数据库名字
+ (NSString *)dbName;

// 表名
+ (NSString *)tableName;

// 要持久化的属性
+ (NSArray<NSString *> *)persistentProperties;

// 主键
+ (NSString *)primaryKey;

// 保存到数据库
- (BOOL)save;

// 部分保存，空字段不会更新到数据库
- (BOOL)partiallySave;

// 用 block 判断每个字段是否应该保存
- (BOOL)partiallySaveWithTestBlock:(DMSavingTestBlock)block;

// 每一列对应的名字
+ (NSString *)columnForProperty:(NSString *)property;

// 数据库存储目录
+ (NSString *)dbDirectory;

// 数据库路径
+ (NSString *)dbPath;

@end
