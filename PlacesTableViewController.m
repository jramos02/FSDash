//
//  PlacesTableViewController.m
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import "PlacesTableViewController.h"
#import "VenueDetailsViewController.h"
#import "PlacesCell.h"


@interface PlacesTableViewController ()

@end

@implementation PlacesTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
    self.images = [[NSMutableArray alloc] init];
    
    requestingHTTP = NO;
   // self.request = [[RequestModel alloc] init];
   // [self.request httpRequest];
    [self getUserLocation];
   
    //[self httpRequest:location];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
   
    return self.venuesResults.count; //total count of objects in the "request"
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    PlacesCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if(cell == nil)
    {
        cell = [[PlacesCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    
    cell.venueName.text = [NSString stringWithFormat:@"%@", [[self.venuesResults objectAtIndex:indexPath.row] objectForKey:@"name"]];
    
    cell.venueImage.image = [self.images objectAtIndex:indexPath.row];
    
    
    
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.venueID= [NSString stringWithFormat:@"%@",[[self.venuesResults objectAtIndex:indexPath.row] objectForKey:@"id"]];
    
self.venueName = [NSString stringWithFormat:@"%@",[[self.venuesResults objectAtIndex:indexPath.row] objectForKey:@"name"]];
    [self performSegueWithIdentifier:@"showVenueDetails" sender:self];
}



#pragma mark -HTTP Requests

-(void)httpRequest:(NSString *)location
{
    
    
    NSLog(@"in http request");
    requestingHTTP = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *post = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?ll=%@&oauth_token=QCDYZZ2YUFAUHTXTW0SXNGDZCA45OBDADIHFX2WB2NKZYGYD&v=20140320", location];
    
    [manager POST:post parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
        
         
         self.results = (NSDictionary *)responseObject;
         
         self.venuesResults = [[self.results objectForKey:@"response"] objectForKey:@"venues"];
         
         
        
         
         [self initializeImages];
        
         

         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    
    
    
}



-(void)initializeImages
{
    count = 0;
  
        NSString *theID= [NSString stringWithFormat:@"%@",[[self.venuesResults objectAtIndex:0] objectForKey:@"id"]];
        [self theVenueThumbnail:theID atIndex:count];
    
}

-(void)theVenueThumbnail:(NSString *)venueId atIndex:(int)index
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
  
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *post = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/%@/photos?limit=1&oauth_token=QCDYZZ2YUFAUHTXTW0SXNGDZCA45OBDADIHFX2WB2NKZYGYD&v=20140320", venueId];
    [manager GET:post parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *imageThumbnail = (NSDictionary *)responseObject;
         
         NSArray *thumbnails = [[[imageThumbnail objectForKey:@"response"] objectForKey:@"photos"] objectForKey:@"items"];
        
         
         if(thumbnails.count > 0)
         {
             NSString *urlPart1 = [[thumbnails objectAtIndex:0] objectForKey:@"prefix"];
             NSString *urlPart2 = [[thumbnails objectAtIndex:0] objectForKey:@"suffix"];
             NSString *imageURL = [NSString stringWithFormat:@"%@50x50%@", urlPart1, urlPart2];
             
             UIImage *theImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]];
             
             [self.images insertObject:theImage atIndex:index];

        

             
             
             
         }
         else
         {
             UIImage *noImage = [UIImage imageNamed:@"no-available-image"];
             [self.images insertObject:noImage atIndex:index];
         }
         
         count++;
         
         if(count == self.venuesResults.count || count > self.venuesResults.count)
         {
             NSLog(@"TOTAL");
             [self.tableView reloadData];
         }
         else
         {
              NSString *theID= [NSString stringWithFormat:@"%@",[[self.venuesResults objectAtIndex:count] objectForKey:@"id"]];
             [self theVenueThumbnail:theID atIndex:count];
         }
     
         
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"Error: %@", error);
     }];
    

}

#pragma mark - Location Methods
-(void)getUserLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    NSLog(@"stopping location");
    [self.locationManager stopUpdatingLocation];
    
    latitude = self.locationManager.location.coordinate.latitude;
    longitude = self.locationManager.location.coordinate.longitude;
    
    NSString *location = [NSString stringWithFormat:@"%f,%f", latitude, longitude];
    
    if(!requestingHTTP) //verification so we don't call the httprequest more than once by mistake
        [self httpRequest:location];
    
}


#pragma  mark - Segue Methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showVenueDetails"])
    {
        
        NSLog(@"show venue details %@", self.venueID);
        VenueDetailsViewController *vc = (VenueDetailsViewController*)segue.destinationViewController;
        vc.venueID = self.venueID;
        vc.venueName = self.venueName;
        
    }
}



@end
