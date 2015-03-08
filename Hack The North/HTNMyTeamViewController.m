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
	UIButton *_emailTeam;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	_listController = [[HTNHackerListViewController alloc] init];
	_listController.delgate = self;
	_teamUsers = [NSMutableArray new];
	
	[self.navigationItem setTitle:@"My Team"];
	UIBarButtonItem *addTeamMember = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(didTapAddMember:)];
	UIBarButtonItem *emailTeam = [[UIBarButtonItem alloc] initWithTitle:@"Email" style:UIBarButtonItemStylePlain target:self action:@selector(didTapEmailTeamButton)];
	[self.navigationItem setRightBarButtonItems:@[addTeamMember, emailTeam]];
	
	[self setUpTableView];
}

- (void)setUpTableView
{
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_tableView registerClass:[HTNUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	[_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	[self.view addSubview:_tableView];
}


- (void)didTapAddMember:(id)sender {
	[self.navigationController pushViewController:_listController animated:YES];
}

- (void)userDidSelectHacker:(HTNUser *)user
{
	[_teamUsers addObject:user];
	if (_teamUsers.count == 3) {
		self.navigationItem.rightBarButtonItem = nil;
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

- (void)didTapEmailTeamButton
{
	// Email Subject
	NSString *emailTitle = @"Hack The North Team";
	// Email Content
	NSString *messageBody = @"Hey,";
	// To address
	NSMutableArray *toRecipents = [NSMutableArray new];
	
	for (HTNUser *user in _teamUsers) {
		[toRecipents addObject:user.email];
	}
	
	if (toRecipents.count > 0) {
		if ([MFMailComposeViewController canSendMail]) {
			MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
			mc.mailComposeDelegate = self;
			[mc setSubject:emailTitle];
			[mc setMessageBody:messageBody isHTML:NO];
			[mc setToRecipients:toRecipents];
			
			// Present mail view controller on screen
			[self presentViewController:mc animated:YES completion:NULL];
		} else {
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Email Setup" message:@"No email is setup on device." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
			[alertView show];
		}
	}
}


@end
