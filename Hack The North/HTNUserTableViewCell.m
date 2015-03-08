//
//  HTNUserTableViewCell.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNUserTableViewCell.h"
#import "HTNUser.h"
#import "HTNSkill.h"
#import "HTNDataProvider.h"

@implementation HTNUserTableViewCell

- (void)prepareForReuse
{
	_profileImageView.image = [UIImage imageNamed:@"defaultImage"];
	_userSkillOne.hidden = NO;
	_skillOneProgress.hidden = NO;
	_userSkillTwo.hidden = NO;
	_skillTwoProgress.hidden = NO;
	_userSkillThree.hidden = NO;
	_skillThreeProgress.hidden = NO;
}

- (void)updateWithUser:(HTNUser *)user
{
	_profileImageView.layer.cornerRadius = 27.5f;
	_profileImageView.layer.masksToBounds = YES;
	_userNameLabel.text = user.name;
	if (user.skills.count >= 1) {
		_userSkillOne.text = [NSString stringWithFormat:@"%@", [user.skills[0] name]];
		_skillOneProgress.progress = [[user.skills[0] rating] floatValue] / 10.0f;
	} else {
		_userSkillOne.hidden = YES;
		_skillOneProgress.hidden = YES;
	}
	if (user.skills.count >= 2) {
		_userSkillTwo.text = [NSString stringWithFormat:@"%@", [user.skills[1] name]];
		_skillTwoProgress.progress = [[user.skills[1] rating] floatValue] / 10.0f;
	} else {
		_userSkillTwo.hidden = YES;
		_skillTwoProgress.hidden = YES;
	}
	if (user.skills.count >= 3) {
		_userSkillThree.text = [NSString stringWithFormat:@"%@", [user.skills[2] name]];
		_skillThreeProgress.progress = [[user.skills[2] rating] floatValue] / 10.0f;
	} else {
		_userSkillThree.hidden = YES;
		_skillThreeProgress.hidden = YES;
	}
	if (user.pictureURL) {
		dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
			[self downloadImageWithURL:user.pictureURL];
		});
	}
}

- (void)downloadImageWithURL:(NSString *)urlString
{
	[[HTNDataProvider dataProvider] getImageForURL:urlString success:^(AFHTTPRequestOperation *operation, id responseObject) {
		dispatch_async(dispatch_get_main_queue(), ^{
			_profileImageView.image = responseObject;
		});
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
	}];
}

@end
