//
//  RequestModel.h
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface RequestModel : NSObject

@property (nonatomic, strong)NSDictionary *results;
@property (nonatomic, strong)NSArray *venuesResults;


-(void)httpRequest;
-(NSArray *)getVenuesResults;


@end
