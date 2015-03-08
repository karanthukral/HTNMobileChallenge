//
//  ViewController.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-06.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HTNUser;

@protocol HTNHackerListControllerDelegate <NSObject>
- (void)userDidSelectHacker:(HTNUser *)user;
@end

@interface HTNHackerListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating>
@property (nonatomic, weak) id <HTNHackerListControllerDelegate> delgate;
@end

