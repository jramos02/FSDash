//
//  VenueDetailsViewController.m
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import "VenueDetailsViewController.h"

@interface VenueDetailsViewController ()

@end

@implementation VenueDetailsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.venueName;
    [self getVenueImages];
    [self getVenueDetails];
    
    
    
}

-(void)getVenueImages
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    
    NSString *post = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/photos?limit=1&oauth_token=QCDYZZ2YUFAUHTXTW0SXNGDZCA45OBDADIHFX2WB2NKZYGYD&v=20140320", self.venueID];
    [manager GET:post parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *imageThumbnail = (NSDictionary *)responseObject;
         
        NSArray *thumbnails = [[[imageThumbnail objectForKey:@"response"] objectForKey:@"photos"] objectForKey:@"items"];
       
        
     
         if(thumbnails.count > 0)
         {
             NSString *urlPart1 = [[thumbnails objectAtIndex:0] objectForKey:@"prefix"];
             NSString *urlPart2 = [[thumbnails objectAtIndex:0] objectForKey:@"suffix"];
             NSString *imageURL = [NSString stringWithFormat:@"%@100x100%@", urlPart1, urlPart2];
             
             UIImage *theImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
            
             self.venueMainImage.image = theImage;
            // [self.images addObject: theImage];
             
             
             
             //NSLog(@"thumbnail: %@", imageURL);
         }
         
       
         
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
         
     

    
}

-(void)getVenueDetails
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    
    NSString *post = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/?oauth_token=QCDYZZ2YUFAUHTXTW0SXNGDZCA45OBDADIHFX2WB2NKZYGYD&v=20140320", self.venueID];
    [manager GET:post parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *venueDetails = (NSDictionary *)responseObject;
         
         NSDictionary *theContactDetails = [[[venueDetails objectForKey:@"response"] objectForKey:@"venue"] objectForKey:@"contact"];
         
         
         if(theContactDetails.count > 0)
         {
           
             self.phoneLabel.text = [NSString stringWithFormat:@"%@", [theContactDetails objectForKey:@"formattedPhone"]];
       
         }
         
         NSDictionary *theLocationDetails = [[[venueDetails objectForKey:@"response"] objectForKey:@"venue"] objectForKey:@"location"];
         
         if(theLocationDetails.count > 0)
         {
            
             self.streetLabel.text = [NSString stringWithFormat:@"%@", [theLocationDetails objectForKey:@"address"]];
             
             NSString *cityState = [NSString stringWithFormat:@"%@, %@", [theLocationDetails objectForKey:@"city"], [theLocationDetails objectForKey:@"state"]];
             self.cityStateLabel.text = cityState;
             //we need: phone, address,
         }
         
         
         
         
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
