//
//  DMDataOperaotr.m
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <sqlite3.h>
#import "FMDB.h"
#import "DMDataOperaotr.h"
#import "NSArray+Yoyo.h"

@interface DMDataOperaotr ()
@property (nonatomic, strong) NSString* dbPath;
@property (nonatomic, strong) FMDatabaseQueue* readQueue;
@property (nonatomic, strong) FMDatabaseQueue* writeQueue;
@end

@implementation DMDataOperaotr

- (instancetype)initWithDbPath:(NSString *)dbPath {
    self = [super init];
    if (self) {
        _dbPath = dbPath;
    }
    return self;
}

- (FMDatabaseQueue *)readQueue {
    if (!_readQueue) {
        _readQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath flags:SQLITE_OPEN_READONLY];
    }
    return _readQueue;
}

- (FMDatabaseQueue *)writeQueue {
    if (!_writeQueue) {
        _writeQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    }
    return _writeQueue;
}

- (BOOL)saveObject:(id<DMDataModeling>)object {
    BOOL result = [self saveObject:object withTestBlock:nil];
    return result;
}

- (BOOL)saveObject:(id <DMDataModeling>)object withTestBlock:(DMSavingTestBlock)block {
    __block BOOL result = NO;
    [self.writeQueue inDatabase:^(FMDatabase *db) {
        [self createTable:object db:db];
        [self updateScheme:object db:db];
        [self storageObject:object block:block db:db];
    }];

    return result;
}

- (BOOL)isObjectExistsForId:(id)objectId {
    return NO;
}

- (void)storageObject:(id <DMDataModeling>)object
      savingTestBlock:(DMSavingTestBlock)savingTestBlock
      existsTestBlock:(DMExistsTestBlock)existsTestBlock
                   db:(FMDatabase *)db
{
    NSString* primaryKey = nil;
    if ([object respondsToSelector:@selector(primaryKey)]) {
        primaryKey = object.primaryKey;
    }

    BOOL updateExistsObject = NO;
    NSDictionary *keyValues = [self _keyValuesOfObject:object];
    if (primaryKey.length > 0) {
        if (existsTestBlock) {
            updateExistsObject = existsTestBlock(object, db);
        } else {
            updateExistsObject = [self isObjectExistsForId:primaryKey];
        }
    }

    // TODO: using saving test block
    if (updateExistsObject) {
        [self _executeUpdateCommand:db table:object.tableName primaryKey:primaryKey keyValues:keyValues];
    } else {
        [self _executeInsertCommand:db table:object.tableName primaryKey:primaryKey keyValues:keyValues];
    }
}

- (void)createTable:(id<DMDataModeling>)tableName db:(FMDatabase *)db {
    
}

- (void)updateScheme:(id<DMDataModeling>)object db:(FMDatabase *)db {
    
}

#pragma mark - Private Method

- (NSDictionary *)_keyValuesOfObject:(id <DMDataModeling>)object {
    return nil;
}

/*
 * 用 NSDictionary 执行 sql 命令
 * example:
 *  sql = @“INSERT OR REPLACE INTO YYRole”
 *  keyValue = @{ @"key1": @"value1", @"key2": @"value2" }
 *  execute: INSERT OR REPLACE INTO YYRole(key1, key2) VALUES(value1, value2)
 */
- (BOOL)_executeInsertCommand:(FMDatabase *)db sql:(NSString *)sql keyValues:(NSDictionary *)keyValue {
    if (!db || !sql || !keyValue) {
        return NO;
    }
    
    NSArray* keys = [keyValue allKeys];
    NSArray* paramKeys = [keys yoyo_copyElements:^id(id element) {
        NSString* result = [NSString stringWithFormat:@":%@", element];
        return result;
    }];
    
    NSString* joinedKey = [keys componentsJoinedByString:@","];
    NSString* joinedValue = [paramKeys componentsJoinedByString:@","];
    NSString* formatedSql = [NSString stringWithFormat:@"%@(%@) values(%@)", sql, joinedKey, joinedValue];
    BOOL status = [db executeUpdate:formatedSql withParameterDictionary:keyValue];
    return status;
}

- (void)_executeInsertCommand:(FMDatabase *)database table:(NSString *)table primaryKey:(NSString *)key keyValues:(NSDictionary *)values {

}

- (BOOL)_executeUpdateCommand:(FMDatabase *)db
                        table:(NSString *)table
                   primaryKey:(NSString *)primaryKey
                    keyValues:(NSDictionary *)keyValues

{
    if (!db || !table || !primaryKey || !keyValues) {
        return NO;
    }
    
    NSArray* keys = [keyValues allKeys];
    NSArray* paramKeyValues = [keys yoyo_copyElements:^id(id element) {
        if ([element isEqualToString:primaryKey]) {
            return nil;
        }
        NSString* result = [NSString stringWithFormat:@"'%@'=:%@", element, element];
        return result;
    }];
    
    NSString* joinedKeyValue = [paramKeyValues componentsJoinedByString:@","];
    NSString* formatedSql = [NSString stringWithFormat:@"UPDATE %@ SET %@ where '%@'=:%@",
                             table, joinedKeyValue, primaryKey, primaryKey];
    BOOL status = [db executeUpdate:formatedSql withParameterDictionary:keyValues];
    return status;
}

@end
