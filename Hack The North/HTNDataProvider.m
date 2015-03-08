//
//  HTNDataProvider.m
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import "HTNDataProvider.h"
#import "HTNUser.h"

@implementation HTNDataProvider
{
	AFHTTPRequestOperationManager *_manager;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		_manager = [AFHTTPRequestOperationManager manager];
	}
	return self;
}

+ (HTNDataProvider *)dataProvider
{
	static HTNDataProvider * dataProvider = nil;
	if (!dataProvider) {
		dataProvider = [[super allocWithZone:nil] init];
	}
	return dataProvider;
}

- (void)getUsersWith:(void (^)(NSArray *users))success
			andFailure:(void (^)(NSDictionary *responseDictionary, NSError *error))failure
{
	__block NSMutableArray *users = [NSMutableArray new];
	[_manager GET:@"https://htn15-interviews.firebaseio.com/.json" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
		NSArray *allUsersArray = responseObject[@"users"];
		for (NSDictionary *dict in allUsersArray) {
			HTNUser *user = [[HTNUser alloc]initWithDictionary:dict];
			[users addObject:user];
		}
		success(users);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options:kNilOptions error:&error];
		failure(responseDict, error);
	}];
}

- (void)getImageForURL:(NSString *)imageURLString
			   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
			   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
	
	NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLString]];
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
	requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Response: %@", responseObject);
		success(operation, responseObject);
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Image error: %@", error);
		failure(operation, error);
	}];
	[requestOperation start];
}

@end
