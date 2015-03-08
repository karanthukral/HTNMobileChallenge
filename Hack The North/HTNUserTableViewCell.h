//
//  HTNUserTableViewCell.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTNUser;

@interface HTNUserTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userSkillOne;
@property (weak, nonatomic) IBOutlet UILabel *userSkillTwo;
@property (weak, nonatomic) IBOutlet UILabel *userSkillThree;
@property (weak, nonatomic) IBOutlet UIProgressView *skillOneProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *skillTwoProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *skillThreeProgress;

- (void)updateWithUser:(HTNUser *)user;

@end
