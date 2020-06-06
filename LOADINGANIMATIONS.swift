//
//  LOADINGANIMATIONS.swift
//  RPM
//
//  Created by Gaurav on 02/08/17.
//  Copyright © 2017 HenceForth. All rights reserved.
//

import UIKit

func loadingStart(_ mainViewFrame:CGRect, buttonViewFrame: CGRect) -> UIView{
    
    let loadingView : UIView = UIView(frame: mainViewFrame)
    loadingView.backgroundColor = UIColor.clear
   let loaderBgView : UIView = UIView(frame: buttonViewFrame)
    //loaderBgView.backgroundColor = UIColor(netHex: COLORS.THEMECOLOR.rawValue)
   loaderBgView.layer.cornerRadius = buttonViewFrame.height/2
    let circularView : SpinnerView = SpinnerView(frame: CGRect(x: 8, y: 8, width: loaderBgView.frame.width - 16, height: loaderBgView.frame.height - 16))
    loaderBgView.addSubview(circularView)
    loadingView.addSubview(loaderBgView)
    
    return loadingView
}


func loadingOnScreen(_ mainViewFrame:CGRect) -> UIView{
    let loadingView = UIView(frame : CGRect(x: 0, y: 0, width: mainViewFrame.width, height: mainViewFrame.height))
//    loadingView.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
    loadingView.alpha = 0.6
    
    let laodingFrame = SpinnerView(frame: CGRect(x: mainViewFrame.width/2 - 20, y: mainViewFrame.height/2 - 20, width: 40, height: 40))
    loadingView.addSubview(laodingFrame)
    
    return loadingView
}

func loadingOnView(_  mainViewFrame:CGRect, loadingHeight: CGFloat) -> UIView{
    let loadingView : UIView = UIView(frame: mainViewFrame)
    loadingView.backgroundColor = UIColor.clear
    
//        let rotatorView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
//        rotatorView.backgroundColor = THEMECOLOR
    
    
    let rotatorView : UIView = UIView(frame: CGRect(x: loadingView.frame.midX-5, y: loadingHeight, width: 5, height: 5))
    rotatorView.backgroundColor = UIColor.white
    
    let rotatorView2 : UIView = UIView(frame: CGRect(x: loadingView.frame.midX, y: loadingHeight, width: 5, height: 5))
    rotatorView2.backgroundColor = UIColor.white
    
    
    let whiteView : UIView = UIView(frame: CGRect(x: 0, y: loadingHeight, width: loadingView.frame.width, height: 5))
    whiteView.backgroundColor = UIColor.black
    whiteView.alpha = 0.3
    
    
    UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat], animations: {
        
        rotatorView.frame = CGRect(x: -5, y: loadingHeight, width: 5, height: 5)
        rotatorView2.frame = CGRect(x: loadingView.frame.maxX, y: loadingHeight, width: 5, height: 5)
        
    }, completion: nil)
    
    loadingView.addSubview(whiteView)
    loadingView.addSubview(rotatorView)
    loadingView.addSubview(rotatorView2)
    return loadingView
}


func getResizeLink(_ mainLink: String , width: CGFloat) -> String{
    if mainLink.contains("graph.facebook.com"){
        return mainLink
    }
    
    return "http://ec2-13-58-182-212.us-east-2.compute.amazonaws.com:8000/api/user/resizeImage?path=\(mainLink)&width=\(width)"
}
