//
//  PlacesCell.m
//  FSDash
//
//  Created by Jose Ramos on 3/20/14.
//  Copyright (c) 2014 Jose Ramos. All rights reserved.
//

#import "PlacesCell.h"

@implementation PlacesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
