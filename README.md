# PZXPraiseButton
下载地址：https://github.com/PZXforXcode/PZXPraiseButton
一款用粒子效果做的点赞按钮。使用方便
#效果图
![点击效果](https://upload-images.jianshu.io/upload_images/19409325-c9f8ae26c032ec7e.gif?imageMogr2/auto-orient/strip)
#效果图

```
//首先import项目
#import "PZXPraiseButton.h"

    PZXPraiseButton *button = [[PZXPraiseButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    button.center = self.view.center;
    [button setImage:[UIImage imageNamed:@"桃心-3"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"桃心-2"] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

```
