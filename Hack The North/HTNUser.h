//
//  HTNUser.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTNUser : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *pictureURL;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSDecimalNumber *latitude;
@property (strong, nonatomic) NSDecimalNumber *longitude;
@property (strong, nonatomic) NSArray *skills;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
