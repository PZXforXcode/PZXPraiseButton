//
//  PZXPraiseButton.m
//  PZXPraiseButton
//
//  Created by pzx on 16/11/15.
//  Copyright © 2016年 pzx. All rights reserved.
//


#import "PZXPraiseButton.h"


@interface PZXPraiseButton ()

@property (nonatomic,strong)UIView *bloomView;
@property(nonatomic,strong) CAEmitterLayer *emitter;


@end

@implementation PZXPraiseButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame  = frame;
        
        [self initializeUserInterfacer];
        
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self initializeUserInterfacer];


    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

}
-(void)initializeUserInterfacer{
    self.animateTime = 0.8;
    self.emitterColor = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0];
    _bloomView = [[UIView alloc]initWithFrame:self.bounds];
    self.bloomView.userInteractionEnabled = NO;//关键代码必须关闭view的交互，不然会影响按钮点击事件
    //把粒子效果的view插到按钮后面
    [self addTarget:self action:@selector(SelfPressed) forControlEvents:UIControlEventTouchUpInside];
    [self makeCAEmitterLayer];
    [self insertSubview:_bloomView atIndex:0];

    
    
}

-(void)SelfPressed{
    

    if (self.isSelected == NO) {
        
        [self clickToSelectedAnimate];
        [self performSelector:@selector(animate) withObject:nil afterDelay:self.animateTime];

    }else{
        
        [self clickToUNSelectedAnimate];
        
    }
    
    
}

-(void)clickToSelectedAnimate{
    
    //UIKit的多段动画
    [UIView animateKeyframesWithDuration:self.animateTime delay:0 options:0 animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/3.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1.2, 1.2);

            
        }];
        [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);

        }];
        [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations:^{

            self.transform = CGAffineTransformMakeScale(1.0, 1.0);

            
        }];

        
        
        
    } completion:^(BOOL finished) {

    }];

}
-(void)clickToUNSelectedAnimate{
 

    [UIView animateKeyframesWithDuration:self.animateTime delay:0 options:0 animations:^{
        

        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
            
        }];
        [UIView addKeyframeWithRelativeStartTime:1/2.0 relativeDuration:1/2.0 animations:^{
            
            self.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
            
        }];
        
        

        
    } completion:^(BOOL finished) {

    }];
    
}


//制作粒子效果
-(void)makeCAEmitterLayer{

    [self.bloomView.layer removeFromSuperlayer];
    //设置例子layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    //渲染效果
    emitter.renderMode = kCAEmitterLayerAdditive;
    //边缘效果
    emitter.emitterShape = kCAEmitterLayerCircle;
    //发射模式
    emitter.emitterMode = kCAEmitterLayerOutline;
    //layerFrame
    emitter.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    //粒子发射的size
    emitter.emitterSize = CGSizeMake(self.frame.size.width, self.frame.size.width);
    //发射位置
    emitter.emitterPosition = CGPointMake(emitter.frame.size.width / 2.0, emitter.frame.size.height / 2.0);
    emitter.masksToBounds = NO;
    _emitter = emitter;
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.name = @"cube";
    cell.contents = (__bridge id)[self imageWithColor:self.emitterColor andSize:CGSizeMake(3, 3)].CGImage;
    //出身率
    cell.birthRate = 0;
    //存在时间
    cell.lifetime = self.animateTime;

    cell.lifetimeRange = 0.5;
    cell.color = [UIColor colorWithRed:1 green:0.5 blue:0.1 alpha:1.0].CGColor;
    //消失速度
    cell.alphaSpeed = - 1.f;
    cell.alphaRange = 0.20;
    //速度
    cell.velocity = 40;
    cell.velocityRange = 10;
    //发射角度
//    cell.emissionRange = M_PI * 2.0;
    //layer+cells
    _emitter.emitterCells = @[cell];
    //放上layer
    [self.bloomView.layer addSublayer:_emitter];
    
}

//绘制纯色图片
-(UIImage*)imageWithColor:(UIColor*)color andSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    
    CGRect rect=CGRectMake(0, 0, size.width, size.height);
    UIBezierPath*bezierPath=[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:size.width/2.0];
    
    CGContextAddPath(context, bezierPath.CGPath);
    CGContextFillPath(context);
    CGContextSetFillColorWithColor(context, color.CGColor);
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}


- (void)animate {
    
    [self.emitter setValue:@800 forKeyPath:@"emitterCells.cube.birthRate"];
    [self performSelector:@selector(stop) withObject:nil afterDelay:0.1];

}



- (void)stop {
    
    [self.emitter setValue:@0 forKeyPath:@"emitterCells.cube.birthRate"];


}
-(void)setEmitterColor:(UIColor *)emitterColor{
    
    _emitterColor = emitterColor;
    [self makeCAEmitterLayer];
}
@end
