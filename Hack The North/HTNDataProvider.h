//
//  HTNDataProvider.h
//  Hack The North
//
//  Created by Karan Thukral on 2015-03-07.
//  Copyright (c) 2015 Karan Thukral. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

@interface HTNDataProvider : NSObject

+ (HTNDataProvider *)dataProvider;
- (void)getUsersWith:(void (^)(NSArray *users))success
			andFailure:(void (^)(NSDictionary *responseDictionary, NSError *error))failure;
- (void)getImageForURL:(NSString *)imageURLString
			   success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
			   failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
