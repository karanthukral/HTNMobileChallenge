//
//  HTNSkill.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTNSkill : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSDecimalNumber *rating;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
