FullScreenImage
===========
A sample of implementation like Sina Weibo Image animation
模仿新浪微博图片点击放大动画

Step
---
1. Add ZJFullScreenImageViewController.h/m to your project
2. Add SDWebImage (you can use cocoapods)
3. In your code, create the ViewController like:
    ZJFullScreenImageViewController *fullScreenVC = [[ZJFullScreenImageViewController alloc] initWithOriginalImageView:self.imgView withFullImageURLString:kImgURLString];
    [self presentViewController:fullScreenVC animated:YES completion:nil];
self.imgView: the image which will have the animation
kImgURLString: a NSString represents for the url of the full screen image

OK, That's ALL!

You can also use it on the image which exists in the tableview cell.

To-do:
--
1. Support for All Orientations;
2. Support for iPad device(currently it is not tested only on iPhone)



Notice
-----
This sample depends on SDWebImage;

