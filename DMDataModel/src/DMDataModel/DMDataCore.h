//
//  DMDataCore.h
//  DMDataModel
//
//  Created by 聪宁陈 on 2017/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DMDataOperaotr.h"

@interface DMDataCore : NSObject

+ (nonnull instancetype)sharedInstance;

- (nonnull DMDataOperaotr *)operatorForDbPath:(nonnull NSString *)dbPath;

@end
