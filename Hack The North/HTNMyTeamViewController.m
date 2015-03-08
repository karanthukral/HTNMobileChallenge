//
//  HTNMyTeamViewController.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-08.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNMyTeamViewController.h"
#import "HTNUser.h"
#import "HTNUserTableViewCell.h"

@implementation HTNMyTeamViewController {
	HTNHackerListViewController *_listController;
	UITableView *_tableView;
	NSMutableArray *_teamUsers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	_listController = [[HTNHackerListViewController alloc] init];
	_listController.delgate = self;
	_teamUsers = [NSMutableArray new];
	[self setUpTableView];
}

- (void)setUpTableView
{
	CGRect tableViewFrame = CGRectMake(0, 64, 320, 411);
	_tableView = [[UITableView alloc] initWithFrame:tableViewFrame];
	[_tableView registerClass:[HTNUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	[_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
}


- (IBAction)didTapAddMember:(id)sender {
	[self.navigationController pushViewController:_listController animated:YES];
}

- (void)userDidSelectHacker:(HTNUser *)user
{
	[_teamUsers addObject:user];
	if (_teamUsers.count == 3) {
		_addButton.hidden = YES;
	}
	[_tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 137.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	HTNUser *user = _teamUsers[indexPath.row];
	CGFloat height = 45.0f + (32.5 * user.skills.count);
	return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _teamUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTNUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTNUserTableViewCell class]) forIndexPath:indexPath];
	[cell updateWithUser:_teamUsers[indexPath.row]];
	return cell;
}


@end
