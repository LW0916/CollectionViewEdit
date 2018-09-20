//
//  LWCollectionViewCell.m
//  CollectionViewEditTest
//
//  Created by lwmini on 2018/9/10.
//  Copyright © 2018年 lw. All rights reserved.
//

#import "LWCollectionViewCell.h"


@implementation LWCollectionViewCell
- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        _contentLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:10];
        _contentLabel.adjustsFontSizeToFitWidth = YES;
        _contentLabel.numberOfLines = 0;
        _contentLabel.textColor = [UIColor yellowColor];
    }
    return _contentLabel;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self loadSubviews];
    }
    return self;
}
- (void)loadSubviews{
    [self addSubview:self.contentLabel];
}

@end
