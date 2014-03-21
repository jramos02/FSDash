//
//  RequestModel.m
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import "RequestModel.h"

@implementation RequestModel

-(void)httpRequest
{
    
    
    NSLog(@"in http request");
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    [manager POST:@"https://api.foursquare.com/v2/venues/search?ll=40.7,-74&oauth_token=0XH12W3AKB3V1AR5YR15H00EWYTTZGCV5NZ5UUCSQJUKL5OE&v=20140320" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         //NSLog(@"JSON: %@", responseObject);
         
         self.results = (NSDictionary *)responseObject;
         
         self.venuesResults = [[self.results objectForKey:@"response"] objectForKey:@"venues"];
         
       
         
         NSLog(@"results count: %@", [[self.results objectForKey:@"response"] objectForKey:@"venues"]);
         
         NSLog(@"array count: %d", self.venuesResults.count);
         
         for(int i = 0; i < self.venuesResults.count; i++)
         {
             NSLog(@"the venue: %@", [[self.venuesResults objectAtIndex:i] objectForKey:@"name"]);
         }
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
    

}

#pragma  mark - Helper Methods

-(NSArray *)getVenuesResults
{
    return self.venuesResults;
}

@end
