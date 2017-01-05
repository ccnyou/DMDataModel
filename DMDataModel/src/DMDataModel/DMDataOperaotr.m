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

@end
