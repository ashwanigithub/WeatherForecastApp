//
//  ForecastCustomTC.h
//  SamplePro
//
//  Created by Varun Gupta on 29/08/17.
//  Copyright © 2017 Varun Gupta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastCustomTC : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLbl;
@property (weak, nonatomic) IBOutlet UILabel *todayLbl;
@property (weak, nonatomic) IBOutlet UILabel *maxTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *minTempLbl;
@property (weak, nonatomic) IBOutlet UILabel *cloudinessLbl;
@property (weak, nonatomic) IBOutlet UILabel *cloudPressureLbl;
@property (weak, nonatomic) IBOutlet UILabel *windLbl;
@property (weak, nonatomic) IBOutlet UIImageView *cloudImageview;

@end
