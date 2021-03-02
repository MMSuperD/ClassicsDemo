//
//  FanBaseTableViewCell.m
//  ClassicsDemo
//
//  Created by xzmac on 2021/3/1.
//

#import "FanBaseTableViewCell.h"

@implementation FanBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addChildView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)addChildView{
    
}

@end
