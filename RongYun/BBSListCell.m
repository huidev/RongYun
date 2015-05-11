//
//  BBSListCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "BBSListCell.h"

@implementation BBSListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setBbsModel:(BBSEntity *)bbsModel
{
    self.themeImageVIew.image = ImageFile(@"family_ima", @"png");
    self.typeLB.text = @"游戏";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
