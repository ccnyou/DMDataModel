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

@end
