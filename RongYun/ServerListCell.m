//
//  ServerListCell.m
//  RongYun
//
//  Created by 乐米科技 on 5/10/15.
//  Copyright (c) 2015 zwh. All rights reserved.
//

#import "ServerListCell.h"

@implementation ServerListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (UINib *)serverListCellNib
{
    return [UINib nibWithNibName:@"ServerListCell" bundle:nil];
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(ServerListEntity *)model
{
    self.headImageView.image = ImageFile(@"family_ima", @"png");
    self.typeLB.text = @"游戏";
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
