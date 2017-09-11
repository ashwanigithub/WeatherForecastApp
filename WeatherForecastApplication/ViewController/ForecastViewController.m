//
//  ForecastViewController.m
//  WeatherForecastApplication
//
//  Created by Ashwin Sharma  on 03/09/17.
//  Copyright © 2017 asap. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastCustomTC.h"
#import "AppDelegate.h"

@interface ForecastViewController (){
    NSMutableArray *forcastdictArray;
}
@end

@implementation ForecastViewController{}

- (void)viewDidLoad {
    [super viewDidLoad];
    _forecastTableView.tableFooterView = [UIView new];
    AppDelegate *appdel=(AppDelegate *)[[UIApplication sharedApplication] delegate];
    forcastdictArray = appdel.username;
}

#pragma mark - Back Button Action
- (IBAction)backToView:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UITableViewDelegate and UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [forcastdictArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"cell";
    ForecastCustomTC *cell = (ForecastCustomTC *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ForecastCustomTC" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
        NSDictionary *forecastDict = [forcastdictArray objectAtIndex:indexPath.row];
        NSString * dateStr = [forecastDict objectForKey:@"dt"];
        NSString * speedStr = [forecastDict objectForKey:@"speed"];
        NSString *windSpeedStr = [NSString stringWithFormat:@"%@ %@",speedStr,@"m/s"];
        NSString *cloud = [forecastDict objectForKey:@"clouds"];
        NSString *cloudStr = [NSString stringWithFormat:@"%@ %@ %@",@"clouds:",cloud,@"%"];
        NSString * pressure = [forecastDict objectForKey:@"pressure"];
        NSString *pressureStr = [NSString stringWithFormat:@"%@ %@",pressure,@"hpa"];
        NSString *cloudPressureStr = [NSString stringWithFormat:@"%@,  %@",cloudStr,pressureStr];
        NSDictionary * tempDict = [forecastDict objectForKey:@"temp"];
        NSString *maxTemp = [tempDict objectForKey:@"max"];
        NSString *maxTempStr = [NSString stringWithFormat:@"%@%@",maxTemp,@"°C"];
        NSString *minTemp = [tempDict objectForKey:@"min"];
        NSString *minTempStr = [NSString stringWithFormat:@"%@%@",minTemp,@"°C"];
        NSString *date = [self convertToFraction:dateStr];
        NSArray * weatherarray = [forecastDict objectForKey:@"weather"];
        NSDictionary * sysdictmain = [weatherarray objectAtIndex:0];
        NSString *descriptionStr = [sysdictmain objectForKey:@"description"];
        NSString *iconStr = [sysdictmain objectForKey:@"icon"];
        NSString *url_I1 = @"http://openweathermap.org/img/w/";
        NSString *url_Img1 =  [NSString stringWithFormat:@"%@%@%@",url_I1,iconStr,@".png"];
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url_Img1]];
        cell.dateLbl.text = date;
        if (indexPath.row == 0) {
            cell.todayLbl.hidden = NO;
        }else{
            cell.todayLbl.hidden = YES;
        }
        cell.maxTempLbl.text = maxTempStr;
        cell.minTempLbl.text = minTempStr;
        cell.cloudinessLbl.text = descriptionStr;
        cell.windLbl.text = windSpeedStr;
        cell.cloudPressureLbl.text = cloudPressureStr;
        cell.cloudImageview.image = [UIImage imageWithData:data];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0;
}

#pragma mark - Date/Time Formate Converstion.
-(NSString*)convertToFraction:(NSString*)strintFormat {
    NSString *dateStr = [NSString stringWithFormat:@"%@",strintFormat];
    NSTimeInterval seconds = [dateStr doubleValue];
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE dd MMM"];
    NSString *dateFormateStr = [dateFormatter stringFromDate:epochNSDate];
    return dateFormateStr;
}

#pragma mark - Memory Management.
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
