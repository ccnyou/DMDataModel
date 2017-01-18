//
//  DMDataModelTests.m
//  DMDataModelTests
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FMDB.h"
#import "Sample.h"
#import "DMModelObject.h"

@interface DMDataModelTests : XCTestCase
@property (nonatomic, strong) Sample* sut;
@property (nonatomic, strong) NSString* dbPath;
@property (nonatomic, strong) FMDatabase* db;
@end

@implementation DMDataModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sut = [[Sample alloc] init];
    
    NSString* directory = [self.sut.class dbDirectory];
    NSString* dbName = [self.sut.class dbName];
    self.dbPath = [directory stringByAppendingPathComponent:dbName];
    self.db = [FMDatabase databaseWithPath:self.dbPath];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.sut = nil;
    self.dbPath = nil;
    [self.db close];
    [super tearDown];
}

// 首次保存对象应该会创建表
- (void)testFirstSaveObjectShouldCreateTable {
    NSString* tableName = [self.sut.class tableName];
    XCTAssert(self.dbPath, @"db path should not be nil");
    XCTAssert(tableName, @"table name should not be nil");
    BOOL tableExists = [self.db tableExists:tableName];
    if (tableExists) {
        BOOL dropSuccess = [self.db executeUpdate:@"drop table ?", tableName];
        XCTAssert(dropSuccess, @"drop table fail");
    }
    
    self.sut.sampleId = 1;
    self.sut.string = @"str1";
    self.sut.date = [NSDate date];
    self.sut.timeInterval = [[NSDate date] timeIntervalSince1970];
    self.sut.data = [@"Data" dataUsingEncoding:NSUTF8StringEncoding];
    BOOL saveSuccess = [self.sut save];
    XCTAssert(saveSuccess, @"save object fail");
    
    tableExists = [self.db tableExists:tableName];
    XCTAssert(tableExists, @"save object should create table");
}

@end
