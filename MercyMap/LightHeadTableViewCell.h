//
//  LightHeadTableViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/4/8.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol singleTapsDelegate<NSObject>
-(void)singleTaps:(int)ID;
@end

@interface LightHeadTableViewCell : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic ,weak) id<singleTapsDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *introduceLable;
@property (weak, nonatomic) IBOutlet UIScrollView *pageScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pagePageControl;

@end
