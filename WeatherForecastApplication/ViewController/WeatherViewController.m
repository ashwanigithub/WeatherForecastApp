//
//  WeatherViewController.m
//  WeatherForecastApplication
//
//  Created by Ashwin Sharma  on 03/09/17.
//  Copyright © 2017 asap. All rights reserved.
//

#import "WeatherViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "WeatherCustomTC.h"
#import "ForecastViewController.h"
#import "userProfileCustomTC.h"
#import "leftMenuCustomTC.h"
#import "AppDelegate.h"

@interface WeatherViewController ()
@end

@implementation WeatherViewController {
    NSArray *tableData;
    NSArray *itemArray;
    UISwipeGestureRecognizer *swipeLeft;
    NSMutableArray *descriptionArray;
    NSMutableArray *forecastDictionary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:TRUE];
    //Active GPS and get current location.
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    [self DetectGPSLocation];
    
    //NSMutableArray Allocate.
    descriptionArray = [[NSMutableArray alloc] init];
    forecastDictionary = [[NSMutableArray alloc] init];
    
    //NSArray value set.
    itemArray = [NSArray arrayWithObjects:@"",@"Forecast",@"Logout", nil];
    tableData = [NSArray arrayWithObjects:@"Wind", @"Cloudiness", @"Pressure", @"Humidity", @"Sunrise", @"Sunset", @"Geo coords", nil];
    
    //Gesture for left side menu.
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    //[swipeLeft setCancelsTouchesInView:NO];
    [leftSideView addGestureRecognizer:swipeLeft];
    
    //Remove blank cell seprator from UITableView.
    _leftSideTableView.tableFooterView = [UIView new];
    _openWeatherTableView.tableFooterView = [UIView new];

}

#pragma mark - Swipe Gesture on Left Side View
- (void)handleSwipe:(UISwipeGestureRecognizer *)gesture
{
    [UIView animateWithDuration:0.6
                     animations:^{
                         leftSideView.frame = CGRectMake(-(self.view.frame.size.width), 0, self.view.frame.size.width, self.view.frame.size.height);
                     }];
}

#pragma mark - UITableViewDelegate and UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _leftSideTableView) {
        return [itemArray count];
    }else{
        return [tableData count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftSideTableView) {
        if (indexPath.row == 0) {
            static NSString *simpleTableIdentifier = @"profileCell";
            userProfileCustomTC *cell = (userProfileCustomTC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"userProfileCustomTC" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
        else{
            static NSString *simpleTableIdentifier = @"itemCell";
            leftMenuCustomTC *cell = (leftMenuCustomTC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
            if (cell == nil)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"leftMenuCustomTC" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            }
            cell.itemHeadingLbl.text = [itemArray objectAtIndex:indexPath.row];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            return cell;
        }
    }else{
        static NSString *simpleTableIdentifier = @"cell";
        WeatherCustomTC *cell = (WeatherCustomTC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"WeatherCustomTC" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        cell.headingLbl.text = [tableData objectAtIndex:indexPath.row];
        if (descriptionArray.count > 0) {
            cell.descriptionLbl.text = [descriptionArray objectAtIndex:indexPath.row];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftSideTableView) {
        if (indexPath.row == 0) {
            return 225.0;
        }else{
            return 50.0;
        }
        return 0;
    }else{
        return 74.0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftSideTableView) {
        if (indexPath.row == 0) {
            return 225.0;
        }else{
            return 50.0;
        }
        return 0;
    }else{
        return 74.0;
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _leftSideTableView) {
        if (indexPath.row == 0) {
        }
        else if (indexPath.row == 1){
            leftSideView.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ForecastViewController *add = [storyboard instantiateViewControllerWithIdentifier:@"ForecastViewControllerID"];
                //add.forecastArrayID = forecastDictionary;
                [self presentViewController:add animated:YES completion:nil];
            });
        }
        else{
            leftSideView.hidden = YES;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"preferenceEmailID"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                    [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
    }else{
    }
}

#pragma mark - Left Side Menu Button
- (IBAction)leftSideMenuBtn:(id)sender {
    [self.view bringSubviewToFront:leftSideView];
    leftSideView.frame = CGRectMake(-(self.view.frame.size.width), 0, self.view.frame.size.width, self.view.frame.size.height);
    leftSideView.hidden = NO;
    [UIView animateWithDuration:0.6
                     animations:^{
                         leftSideView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
                     }];
}

#pragma mark - Hit Weather API.
- (void)fetchCurrentWeather;
{
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/weather?q=%@&units=metric&appid=458c90ca8473870a07d52b474c6dec66",_CountryArea];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             NSString * place = [greeting objectForKey:@"name"];
             NSDictionary * sysdict = [greeting objectForKey:@"sys"];
             NSString * country = [sysdict objectForKey:@"country"];
             NSDictionary * coordDict = [greeting objectForKey:@"coord"];
             NSString * lat = [coordDict objectForKey:@"lat"];
             NSString * lon = [coordDict objectForKey:@"lon"];
             NSString * sunrise = [sysdict objectForKey:@"sunrise"];
             NSString * sunset = [sysdict objectForKey:@"sunset"];
             NSArray * weatherarray = [greeting objectForKey:@"weather"];
             NSDictionary * sysdictmain = [weatherarray objectAtIndex:0];
             NSString * main = [sysdictmain objectForKey:@"main"];
             NSString * icon = [sysdictmain objectForKey:@"icon"];
             NSDictionary * mainDict = [greeting objectForKey:@"main"];
             NSString *temp = [mainDict objectForKey:@"temp"];
             NSString *tempMax = [mainDict objectForKey:@"temp_max"];
             NSString *tempMin = [mainDict objectForKey:@"temp_min"];
             
             NSString *tempMaxMin = [NSString stringWithFormat:@"%@%@%@|%@%@%@",@"Max: ",tempMax,@" °C",@"Min: ",tempMin,@" °C"];
             NSString *date = [greeting objectForKey:@"dt"];
             NSDictionary *windDict = [greeting objectForKey:@"wind"];
             NSString *windSpeed = [windDict objectForKey:@"speed"];
             NSString *humidity = [mainDict objectForKey:@"humidity"];
             NSString *pressure = [mainDict objectForKey:@"pressure"];
             NSString *tempStr = [NSString stringWithFormat:@"%@",temp];
             NSString *dateStr = [NSString stringWithFormat:@"%@",date];
             NSString *dateFormateConvertStr = [self convertToFraction:dateStr];
             NSString *url_I1 = @"http://openweathermap.org/img/w/";
             NSString *url_Img1 =  [NSString stringWithFormat:@"%@%@%@",url_I1,icon,@".png"];
             NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_Img1]];
             NSString *windSpeedStr = [NSString stringWithFormat:@"%@ %@",windSpeed,@"m/s"];
             NSString *humidityStr = [NSString stringWithFormat:@"%@ %@",humidity,@"%"];
             NSString *pressureStr = [NSString stringWithFormat:@"%@ %@",pressure,@"hpa"];
             NSString *lonlatStr = [NSString stringWithFormat:@"%@, %@",lat,lon];
             NSString *sunrisefraction = [self convertToFraction:sunrise];
             NSString *sunsetfraction = [self convertToFraction:sunset];
             
             [descriptionArray addObject:windSpeedStr];
             [descriptionArray addObject:@"Broken clouds"];
             [descriptionArray addObject:humidityStr];
             [descriptionArray addObject:pressureStr];
             [descriptionArray addObject:sunrisefraction];
             [descriptionArray addObject:sunsetfraction];
             [descriptionArray addObject:lonlatStr];
             
             locationLbl.text = [NSString stringWithFormat:@"%@%@, %@",@"Weather in ",place,country];
             tempLbl.text = [NSString stringWithFormat:@"%@%@",tempStr,@"°C"];
             weatherMainLbl.text = main;
             timeLbl.text = dateFormateConvertStr;
             tempImg.image = [UIImage imageWithData:data];
             tempMaxMinLbl.text = tempMaxMin;
             [_openWeatherTableView reloadData];
             dispatch_async(dispatch_get_main_queue(), ^{
                 //Forecast API call
                 [self fetchDailyForecastDetails];
             });
             
            
         }
     }];
}

#pragma mark - Hit Daily Forecast API.
- (void)fetchDailyForecastDetails;
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.openweathermap.org/data/2.5/forecast/daily?q=%@&units=metric&appid=458c90ca8473870a07d52b474c6dec66",_CountryArea];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response,
                                               NSData *data, NSError *connectionError)
     {
         if (data.length > 0 && connectionError == nil)
         {
             NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
             forecastDictionary = [greeting objectForKey:@"list"];
             AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication] delegate];
             appdel.username = forecastDictionary;
             
         }
     }];
}

#pragma mark - Date/Time Formate Converstion.
-(NSString*)convertToFraction:(NSString*)strintFormat {
    NSString *dateStr = [NSString stringWithFormat:@"%@",strintFormat];
    NSTimeInterval seconds = [dateStr doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm MMM dd"];
    NSString *dateFormateStr = [dateFormatter stringFromDate:epochNSDate];
    return dateFormateStr;
}

#pragma mark - Hit current location method.
-(void) DetectGPSLocation
{
    @try
    {
        self.locationManager = [[CLLocationManager alloc] init];
        if([CLLocationManager locationServicesEnabled]) {
            self.locationManager = [[CLLocationManager alloc] init];
            [[NSUserDefaults standardUserDefaults] setObject:@"DetectGPSLocation" forKey:@"Location"];
            self.locationManager.delegate = self;
            NSUInteger code = [CLLocationManager authorizationStatus];
            if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
                // choose one request according to your business.
                if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                    [self.locationManager requestAlwaysAuthorization];
                } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                    [self.locationManager  requestWhenInUseAuthorization];
                } else {
                }
            }
            self.locationManager.delegate = self;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [self.locationManager startUpdatingLocation];
        } else {
            // show error
        }
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception===%@", exception.reason);
    }
    @finally {
    }
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Not able to find location:Error");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    currentLocation = [locations objectAtIndex:0];
    [self.locationManager stopUpdatingLocation];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error)
     {
         if (!(error))
         {
             CLPlacemark *placemark = [placemarks objectAtIndex:0];
             NSString *Area = [[NSString alloc]initWithString:placemark.locality];
             Area = [Area stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
             NSString *Country = [[NSString alloc]initWithString:placemark.ISOcountryCode];
             _CountryArea = [NSString stringWithFormat:@"%@,%@", Area,Country];
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self fetchCurrentWeather];
             });
         }
         else
         {
             NSLog(@"Geocode failed with error %@", error);
         }
     }];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    @try
    {
        [self.locationManager stopUpdatingLocation];
    }
    @catch (NSException *exception) {
        NSLog(@"Exception===%@", exception.reason);
    }
    @finally {
    }
}

#pragma mark - Memory Management.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

