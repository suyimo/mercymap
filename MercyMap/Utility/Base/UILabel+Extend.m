//
//  UILabel+EasyExtend.m
//  leway
//
//  Created by keirlee on 14-6-6.
//  Copyright (c) 2014年 zhuchao. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel (EasyExtend)

//ios6 later
-(CGSize)autoSize{
    return [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.font} context:nil].size;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.preferredMaxLayoutWidth = 300;
    }
    return self;
}

/**
 *  fixes issues with embedding a `UILabel` in a `UIScrollScrollView`.
 *  @see http://www.raywenderlich.com/73602/dynamic-table-view-cell-height-auto-layout for examples and in-depth discussion on why this is needed.
 *
 *  @discussion Setting the label's `bounds` will update the `preferredMaxLayoutWidth`.
 */
- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    if (bounds.size.width != self.preferredMaxLayoutWidth) {
        self.preferredMaxLayoutWidth = self.bounds.size.width;
        [self setNeedsUpdateConstraints];
    }
}
- (void)adEightWithLines:(unsigned int)line maxHight:(float)maxH spaceWidth:(float)spaceW
{
    self.numberOfLines = line;
    float maxWidth = [[UIScreen mainScreen] bounds].size.width - spaceW*2;
    CGSize maxSize = CGSizeMake(maxWidth, maxH);
    NSDictionary *attribute = [NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
    CGSize labelSize = [self.text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelSize.width, labelSize.height);
}
- (CGFloat)adWidth
{
    self.numberOfLines = 1;
    float maxWidth = [[UIScreen mainScreen] bounds].size.width - 107;
    CGSize maxSize = CGSizeMake(maxWidth, self.frame.size.height);
    NSDictionary *attribute = [NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName];
    CGSize labelSize = [self.text boundingRectWithSize:maxSize options: NSStringDrawingTruncatesLastVisibleLine |
                        NSStringDrawingUsesLineFragmentOrigin |
                        NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, labelSize.width, labelSize.height);
    return labelSize.width;
}
@end
