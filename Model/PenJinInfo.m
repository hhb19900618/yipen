//
//  PenJinInfo.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "PenJinInfo.h"

@implementation PenJinInfo

- (id)initWithKVCDictionary:(NSDictionary *)KVCDic{
    
    if (self = [super init]) {
        //使用kvc进行赋值
        @try {
            [self setValuesForKeysWithDictionary:KVCDic];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    //    NSLog(@"key = %@, value = %@", key, value);
    
}


@end
