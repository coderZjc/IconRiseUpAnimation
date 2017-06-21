//
//  BKIconRiseUpView.swift
//  AnimationDemo
//
//  Created by 博库网 on 2017/6/21.
//  Copyright © 2017年 博库网. All rights reserved.
//

import UIKit


class BKIconRiseUpView: UIView
{
    //MARK:公共方法，供外部调用
    //动画时间
    public var animationTime:CFTimeInterval = 4
    //图片数组
    public var iconArray:[UIImage]?
    //单张图片的宽度
    public let sigleIconWidth:CGFloat=50
    
    
    //MARK:类方法，初始化view
    class func Initialize(frame:CGRect,toView superView:UIView) -> BKIconRiseUpView
    {
        let riseUpView = BKIconRiseUpView.init(frame: frame)
        superView.addSubview(riseUpView)
        return riseUpView
    }
    
    //MARK:开始动画
    func startAnimation() -> Void
    {
        //确定曲线路径
        let travelPath = self.drawBezierPath()
        
        //随机选取图片
        let image = self.selectAImageRandomly()
        let imageView = UIImageView.init(frame: CGRect.init(x: self.frame.size.width/2, y: self.frame.size.height, width: sigleIconWidth, height: sigleIconWidth))
        imageView.backgroundColor=UIColor.clear
        imageView.image=image
        self.addSubview(imageView)
        
        //图片随路径移动
        let keyFrameAnimation = CAKeyframeAnimation.init(keyPath: "position")
        keyFrameAnimation.path=travelPath.cgPath
        keyFrameAnimation.isRemovedOnCompletion=true
        keyFrameAnimation.duration=animationTime
        keyFrameAnimation.repeatCount=1
        imageView.layer.add(keyFrameAnimation, forKey: "positionOnPath")
        
        //透明度变化
        UIView.animate(withDuration: animationTime/2, delay: animationTime/2, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: UIViewAnimationOptions.curveEaseInOut, animations:
        {
            imageView.alpha=0
        }) { (completed) in
            imageView.removeFromSuperview()
        }
        
    }
    
    //MARK:覆写初始化方法
    private override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.backgroundColor=UIColor.clear
    }
    
    internal required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:绘制贝塞尔曲线
    private func drawBezierPath() ->UIBezierPath
    {
        let path = UIBezierPath()
        let self_width = self.frame.size.width
        let self_height = self.frame.size.height-sigleIconWidth
        //视图起点为底部中心点
        let startPoint_x = self_width/2
        let startPoint_y = self_height
        path.move(to: CGPoint.init(x: startPoint_x, y: startPoint_y))
        //设置终点
        let endPoint_x = CGFloat(arc4random_uniform(UInt32(self_width)))
        let endPoint_height:CGFloat = self_height/5
        let endPoint_y = CGFloat(UInt32(endPoint_height)-arc4random_uniform(UInt32(endPoint_height)))
        let endPoint = CGPoint.init(x:endPoint_x , y:endPoint_y )
        //设置控制点
        let xDelta = (fabsf(Float(endPoint_x-startPoint_x)))
        let yDelta = (fabsf(Float(endPoint_y-startPoint_y)))
        let midPoint = CGPoint.init(x:((startPoint_x+endPoint_x)/2) , y:((startPoint_y+endPoint_y)/2))
        let controlPoint1 = CGPoint.init(x: (midPoint.x-CGFloat(arc4random_uniform(UInt32(xDelta/2)))), y: (midPoint.y-CGFloat(arc4random_uniform(UInt32(yDelta/4)))))
        let controlPoint2 = CGPoint.init(x: (midPoint.x+CGFloat(arc4random_uniform(UInt32(xDelta/2)))), y: (midPoint.y+CGFloat(arc4random_uniform(UInt32(yDelta/4)))))
        
        //绘制三阶贝塞尔曲线
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        
        return path
    }
    
    
    //MARK:从已给的图片里随机选择一张图片
    private func  selectAImageRandomly() -> UIImage
    {
        let arrayCount:Int = iconArray!.count
        if (arrayCount>0)
        {
            let index:Int = Int(arc4random_uniform(UInt32(arrayCount)))
            let image:UIImage = iconArray![index]
            return image
        }
        else
        {
            let alert = UIAlertController.init(title: "提示", message: "请先在代码中设置图片数组属性：iconArray", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction.init(title: "确定", style: UIAlertActionStyle.cancel, handler: nil))
            let window = UIApplication.shared.keyWindow?.rootViewController
            window?.present(alert, animated: true, completion: nil)
            
            return UIImage()
        }
    }
    
    
}


