//
//  DMDataOperaotr.h
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMDataModeling.h"

@interface DMDataOperaotr : NSObject

- (instancetype)initWithDbPath:(NSString *)dbPath;

- (BOOL)saveObject:(id<DMDataModeling>)object;

- (BOOL)saveObject:(id<DMDataModeling>)object withTestBlock:(DMSavingTestBlock)block;

- (BOOL)isObjectExistsForId:(id)objectId;

// 存储一个对象，如果对象存在会根据主键更新，如果对象不存在会进行插入
- (void)storageObject:(id <DMDataModeling>)object block:(DMSavingTestBlock)block db:(FMDatabase *)db;

@end
