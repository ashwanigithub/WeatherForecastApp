//
//  userProfileCustomTC.m
//  SamplePro
//
//  Created by Varun Gupta on 30/08/17.
//  Copyright © 2017 Varun Gupta. All rights reserved.
//

#import "userProfileCustomTC.h"

@implementation userProfileCustomTC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _userImgview.layer.cornerRadius = _userImgview.frame.size.height/2;
    _userImgview.layer.masksToBounds = YES;
    _userImgview.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _userImgview.layer.borderWidth = 2.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
