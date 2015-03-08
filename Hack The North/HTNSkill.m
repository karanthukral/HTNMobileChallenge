//
//  HTNSkill.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNSkill.h"

@implementation HTNSkill

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		_name = dictionary[@"name"];
		_rating = dictionary[@"rating"];
	}
	return self;
}

@end
