//
//  PZXPraiseButton.h
//  PZXPraiseButton
//
//  Created by pzx on 16/11/15.
//  Copyright © 2016年 pzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PZXPraiseButton : UIButton

//动画时间 默认0.8 建议不低于0.5
@property(nonatomic,assign)CGFloat animateTime;
//粒子颜色，适配不同的图片
@property(nonatomic,strong)UIColor *emitterColor;

@end
