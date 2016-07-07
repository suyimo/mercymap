//
//  PhotoCollectionViewCell.h
//  MercyMap
//
//  Created by sunshaoxun on 16/5/10.
//  Copyright © 2016年 Wispeed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property(nonatomic,assign)BOOL isAddTarget;
@end
