//
//  WeatherViewController.h
//  WeatherForecastApplication
//
//  Created by Ashwin Sharma  on 03/09/17.
//  Copyright © 2017 asap. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface WeatherViewController : UIViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    __weak IBOutlet UILabel *locationLbl;
    __weak IBOutlet UILabel *tempLbl;
    __weak IBOutlet UIImageView *tempImg;
    __weak IBOutlet UILabel *weatherMainLbl;
    __weak IBOutlet UILabel *timeLbl;
    __weak IBOutlet UIView *leftSideView;
    __weak IBOutlet UILabel *tempMaxMinLbl;
    CLLocation *currentLocation;
}

@property (nonatomic,strong) NSString *CountryArea;
@property (nonatomic,strong) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITableView *openWeatherTableView;
@property (weak, nonatomic) IBOutlet UITableView *leftSideTableView;

@end
