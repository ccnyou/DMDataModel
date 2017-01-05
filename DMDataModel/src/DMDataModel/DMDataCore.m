//
//  DMDataCore.m
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import "DMDataCore.h"

@implementation DMDataCore

+ (instancetype)sharedInstance {
    static DMDataCore* sharedInstance = nil;
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        sharedInstance = [[DMDataCore alloc] init];
    });
    
    return sharedInstance;
}

- (DMDataOperaotr *)operatorForDbPath:(NSString *)dbPath {
    return nil;
}

@end
