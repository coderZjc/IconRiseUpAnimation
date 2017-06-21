//
//  ViewController.swift
//  IconRiseUpAnimation
//
//  Created by 博库网 on 2017/6/21.
//  Copyright © 2017年 company. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
     var myView = BKIconRiseUpView()

    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        testButton.layer.masksToBounds=true
        testButton.layer.cornerRadius=testButton.frame.size.width/2
        
        
        //1.使用的时候先初始化对象，并设置图片内容数组
        myView=BKIconRiseUpView.Initialize(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width/2, height: self.view.frame.size.height), toView: self.view)
        myView.iconArray=[#imageLiteral(resourceName: "lemon"),#imageLiteral(resourceName: "tomato"),#imageLiteral(resourceName: "apple_red"),#imageLiteral(resourceName: "apple_green"),#imageLiteral(resourceName: "chinese-goosebeery"),#imageLiteral(resourceName: "hami-melon"),#imageLiteral(resourceName: "pimiento"),#imageLiteral(resourceName: "pumpkin"),#imageLiteral(resourceName: "orange")]
    }

    
    @IBAction func testAnimation()
    {
        //2.调用动画的方法
        myView.startAnimation()
    }
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    
    

}

