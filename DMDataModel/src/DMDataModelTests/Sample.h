//
//  Sample.h
//  DMDataModel
//
//  Created by ervinchen on 17/1/5.
//  Copyright © 2017年 ccnyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DMModelObject.h"

@interface Sample : DMModelObject
@property (nonatomic, assign) NSInteger sampleId;
@property (nonatomic, strong) NSString* string;
@property (nonatomic, strong) NSDate* date;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, strong) NSData* data;
@end
