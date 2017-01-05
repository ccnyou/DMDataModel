//
//  DMDataModelTests.m
//  DMDataModelTests
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DMModelObject.h"
#import "Sample.h"
#import "FMDB.h"

@interface DMDataModelTests : XCTestCase
@property (nonatomic, strong) Sample* sut;
@end

@implementation DMDataModelTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.sut = [[Sample alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.sut = nil;
    [super tearDown];
}

- (void)testSaveObjectShouldCreateTable {
    NSString* dbPath = [self.sut.class dm_dbPath];
    NSString* tableName = [self.sut.class dm_tableName];
    XCTAssert(dbPath, @"db path should not be nil");
    XCTAssert(tableName, @"table name should not be nil");
    FMDatabase* db = [FMDatabase databaseWithPath:dbPath];
    BOOL tableExists = [db tableExists:tableName];
    if (tableExists) {
        BOOL dropSuccess = [db executeUpdate:@"drop table ?", tableName];
        XCTAssert(dropSuccess, @"drop table fail");
    }
    
    self.sut.sampleId = 1;
    self.sut.string = @"str1";
    self.sut.date = [NSDate date];
    self.sut.timeInterval = [[NSDate date] timeIntervalSince1970];
    self.sut.data = [@"Data" dataUsingEncoding:NSUTF8StringEncoding];
    BOOL saveSuccess = [self.sut dm_save];
    XCTAssert(saveSuccess, @"save object fail");
    
    tableExists = [db tableExists:tableName];
    XCTAssert(tableExists, @"save object should create table");
}

@end
