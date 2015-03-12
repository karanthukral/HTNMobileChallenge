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
#import "HTNMyTeamViewController.h"

@implementation HTNHackerListViewController {
	NSArray *_users;
	NSArray *_filteredUsers;
	UITableView *_tableView;
	UISearchController *_searchController;
	UITableViewController *_searchResultsTableViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self.navigationItem setTitle:@"Hackers"];
	if (_delgate == nil) {

		[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Team" style:UIBarButtonItemStylePlain target:self action:@selector(myTeamButtonPressed)]];
	}
	[self setUpTableView];
	[self setUpResultsTableView];
	[self setUpSearchController];
	self.definesPresentationContext = YES;
	[[HTNDataProvider dataProvider] getUsersWith:^(NSArray *users) {
		NSLog(@"%@", users[0]);
		NSSortDescriptor *sortDescriptor =
		[NSSortDescriptor sortDescriptorWithKey:@"name"
									  ascending:YES
									   selector:@selector(caseInsensitiveCompare:)];
		users = [users sortedArrayUsingDescriptors:@[sortDescriptor]];
		_users = users;
		[_tableView reloadData];
	} andFailure:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:YES];
	_searchController.searchBar.text = @"";
}


- (void)setUpTableView
{
	_tableView = [[UITableView alloc] initWithFrame:self.view.frame];
	[_tableView registerClass:[HTNUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	[_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	if (_delgate == nil) {
		_tableView.allowsSelection = NO;
	}
	[self.view addSubview:_tableView];
}

- (void)setUpResultsTableView
{
	UITableView *resultsTableView = [[UITableView alloc] initWithFrame:_tableView.frame];
	[resultsTableView registerClass:[HTNUserTableViewCell class] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	[resultsTableView registerNib:[UINib nibWithNibName:NSStringFromClass([HTNUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([HTNUserTableViewCell class])];
	_searchResultsTableViewController = [[UITableViewController alloc] init];
	_searchResultsTableViewController.tableView = resultsTableView;
	_searchResultsTableViewController.tableView.dataSource = self;
	_searchResultsTableViewController.tableView.delegate = self;
	if (_delgate == nil) {
		_searchResultsTableViewController.tableView.allowsSelection = NO;
	}
}

- (void)setUpSearchController
{
	_searchController = [[UISearchController alloc]initWithSearchResultsController:_searchResultsTableViewController];
	_searchController.searchResultsUpdater = self;
	_searchController.delegate = self;
	[_searchController.searchBar sizeToFit];
	_tableView.tableHeaderView = _searchController.searchBar;
}

- (void)myTeamButtonPressed
{
	HTNMyTeamViewController *myTeamVC = [[HTNMyTeamViewController alloc] initWithNibName:NSStringFromClass([HTNMyTeamViewController class]) bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:myTeamVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 137.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	HTNUser *user = tableView == _tableView ? _users[indexPath.row] : _filteredUsers[indexPath.row];
	CGFloat height = 45.0f + (32.5 * user.skills.count);
	return height;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == _tableView) {
		return _users.count;
	} else {
		return _filteredUsers.count;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	HTNUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HTNUserTableViewCell class]) forIndexPath:indexPath];
	if (tableView == _tableView) {
		[cell updateWithUser:_users[indexPath.row]];
	} else {
		[cell updateWithUser:_filteredUsers[indexPath.row]];
	}
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if ([_delgate respondsToSelector:@selector(userDidSelectHacker:)]) {
		HTNUser *user = tableView == _tableView ? _users[indexPath.row] : _filteredUsers[indexPath.row];
		[_delgate userDidSelectHacker:user];
		[self.navigationController popViewControllerAnimated:YES];
	}
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
	NSString *searchBarText = _searchController.searchBar.text;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@ OR ANY skills.name CONTAINS[c] %@", searchBarText, searchBarText];
	_filteredUsers = [_users filteredArrayUsingPredicate:predicate];
	[_searchResultsTableViewController.tableView reloadData];
}

@end
