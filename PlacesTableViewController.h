//
//  PlacesTableViewController.h
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestModel.h"
#import <CoreLocation/CoreLocation.h>

@interface PlacesTableViewController : UITableViewController <CLLocationManagerDelegate>
{
    int count;
    float latitude;
    float longitude;
    
    bool requestingHTTP;
}

@property (nonatomic, strong)RequestModel *request;
@property (nonatomic, strong)NSArray *venuesResults;
@property (nonatomic, strong)NSMutableArray *images;
@property (nonatomic, strong)NSString *venueID;
@property (nonatomic, strong)NSString *venueName;

@property (nonatomic, strong)CLLocationManager *locationManager;

@property (nonatomic, strong)NSDictionary *results;

@end
