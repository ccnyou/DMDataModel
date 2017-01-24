//
//  DMDataModeling.h
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#ifndef DMDataModeling_h
#define DMDataModeling_h

#import "DMCommon.h"

@protocol DMDataModeling <NSObject>

// 通过主键获取对象
+ (nonnull instancetype)objectWithId:(nonnull id)objectId;

// 通过 where 获取对象
+ (nonnull NSArray *)objectsWhere:(nullable NSString *)where arguments:(nullable NSArray *)arguments;

// 数据库名字
+ (nonnull NSString *)dbName;

// 表名
+ (nonnull NSString *)tableName;

// 要持久化的属性
+ (nonnull NSArray<NSString *> *)persistentProperties;

// 主键
+ (nullable NSString *)primaryKey;

// 保存到数据库
- (BOOL)save;

@optional

// 每一列对应的名字
+ (nonnull NSString *)columnForProperty:(nonnull NSString *)property;

// 数据库存储目录
+ (nonnull NSString *)dbDirectory;

// 部分保存，空字段不会更新到数据库
- (BOOL)partiallySave;

// 用 block 判断每个字段是否应该保存
- (BOOL)partiallySaveWithTestBlock:(nonnull DMSavingTestBlock)block;

@end

#endif /* DMDataModeling_h */
