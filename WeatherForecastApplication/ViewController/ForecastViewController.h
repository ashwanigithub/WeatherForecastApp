//
//  ForecastViewController.h
//  WeatherForecastApplication
//
//  Created by Ashwin Sharma  on 03/09/17.
//  Copyright © 2017 asap. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSMutableArray *forecastArrayID;
@property (weak, nonatomic) IBOutlet UITableView *forecastTableView;

@end

