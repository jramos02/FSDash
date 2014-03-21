//
//  VenueDetailsViewController.h
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>

@interface VenueDetailsViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *venueMainImage;
@property (nonatomic, strong)NSString *venueID;
@property (nonatomic, strong)NSString *venueName;


@property (weak, nonatomic) IBOutlet UILabel *streetLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@end
