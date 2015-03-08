//
//  ViewController.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-06.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNHackerListViewController.h"
#import "HTNDataProvider.h"
#import "HTNUser.h"
#import "HTNSkill.h"
#import "HTNUserTableViewCell.h"

@implementation HTNHackerListViewController {
	NSArray *_users;
	UITableView *_tableView;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationItem setTitle:@"Hackers"];
	[self setUpTableView];
	[[HTNDataProvider dataProvider] getUsersWith:^(NSArray *users) {
		NSLog(@"%@", users[0]);
		NSSortDescriptor *sortDescriptor =
		[NSSortDescriptor sortDescriptorWithKey:@"name"
									  ascending:YES
									   selector:@selector(caseInsensitiveCompare:)];
		users = [users sortedArrayUsingDescriptors:@[sortDescriptor]];
		_users = users;
		[_tableView reloadData];
	} andFailure:^(NSDictionary *responseDictionary, NSError *error) {
		
	}];
}

- (void)setUpTableView
{
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame];
	[_tableView registerClass:[HTNUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	[_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.allowsSelection = NO;
	[self.view addSubview:_tableView];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 137.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTNUser *user = _users[indexPath.row];
	CGFloat height = 45.0f + (32.5 * user.skills.count);
	return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return _users.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTNUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTNUserTableViewCell class]) forIndexPath:indexPath];
	[cell updateWithUser:_users[indexPath.row]];
	return cell;
}

@end
