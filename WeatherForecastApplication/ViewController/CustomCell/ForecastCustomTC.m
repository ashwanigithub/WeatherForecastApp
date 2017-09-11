//
//  ForecastCustomTC.m
//  SamplePro
//
//  Created by Varun Gupta on 29/08/17.
//  Copyright © 2017 Varun Gupta. All rights reserved.
//

#import "ForecastCustomTC.h"

@implementation ForecastCustomTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _maxTempLbl.layer.cornerRadius=4.0;
    _maxTempLbl.clipsToBounds=YES;
    _minTempLbl.layer.cornerRadius=4.0;
    _minTempLbl.clipsToBounds=YES;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
