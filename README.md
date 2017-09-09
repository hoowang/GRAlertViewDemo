# GRAlertView
带有blur效果的弹窗组件~~
![image](https://github.com/hoowang/GRAlertViewDemo/blob/master/DemoImage.jpg)  

## 系统要求
- iOS 6.0
- ARC
- 语言：Objective-C

## 安装方法
支持CocoaPods 安装，pod search GRAlertView

也可以下载文件，拖放至项目目录

## 使用方法：
###1.创建flowlayout configurator对象 并配置参数

```objc
		// your custom contentview
		SexualOrientationContentView *contentView = 
		[[SexualOrientationContentView alloc] init];
		  
	   GRAlertView *alertView = 
	   [GRAlertView alertViewWithContentView:contentView
	     ViewHeight:408 ViewWidth:284];
	     
   	contentView.delegate = self;
   	alertView.topImageName = @"imagename";
   	alertView.animationStyle = style;
   	[alertView present:self.navigationController];
	 
```
### 2.present on Window 
```objc
		[alertView presentOnWindow]
```


