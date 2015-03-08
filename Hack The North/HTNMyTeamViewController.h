//
//  HTNMyTeamViewController.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-08.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTNHackerListViewController.h"

@interface HTNMyTeamViewController : UIViewController <HTNHackerListControllerDelegate, UITableViewDelegate, UITableViewDataSource>
- (IBAction)didTapAddMember:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end
