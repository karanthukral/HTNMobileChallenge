//
//  HTNUser.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNUser.h"
#import "HTNSkill.h"

@implementation HTNUser

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if (self) {
		_name = dictionary[@"name"];
		_pictureURL = dictionary[@"picture"];
		_company = dictionary[@"company"];
		_email = dictionary[@"email"];
		_phone = dictionary[@"phone"];
		_latitude = dictionary[@"latitude"];
		_longitude = dictionary[@"longitude"];
		
		NSArray *allSkills = dictionary[@"skills"];
		NSMutableArray *skillsArray = [NSMutableArray new];
		for (NSDictionary *skillDictionary in allSkills) {
			HTNSkill *skill = [[HTNSkill alloc] initWithDictionary:skillDictionary];
			NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@",skill.name];
			NSArray *result = [skillsArray filteredArrayUsingPredicate:predicate];
			if (result.count == 0) {
				[skillsArray addObject:skill];
			} else {
				HTNSkill *repeatedSkill = [result firstObject];
				if (repeatedSkill.rating < skill.rating) {
					[skillsArray removeObject:repeatedSkill];
					[skillsArray addObject:skill];
				}
			}
		}
		
		_skills = [NSArray arrayWithArray:skillsArray];
		
	}
	return self;
}

@end
