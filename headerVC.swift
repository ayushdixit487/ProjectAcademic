//
//  headerVC.swift
//  Acadmic
//
//  Created by MAC on 12/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu
class headerVC: UIViewController,ENSideMenuDelegate {

    var header : UILabel = UILabel()
    var leftBtn : UIButton = UIButton()
    var rightBtn : UIButton = UIButton()
    var rightSideBtn : UIButton = UIButton()
    var headerView : UIView = UIView()
    var alertView : UIView = UIView()
    // MARK: - OVERRIDE FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 76)
        headerView.backgroundColor = UIColor(netHex: COLORS.DARKGREY.rawValue)
       // headerView.translatesAutoresizingMaskIntoConstraints = false
        //self.headerView.addSubview(alertView)
        self.view.addSubview(headerView)
//        let margins = view.layoutMarginsGuide
//        NSLayoutConstraint.activate([
//            headerView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
//            headerView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
//            ])
//        if #available(iOS 11, *) {
//            let guide = view.safeAreaLayoutGuide
//            NSLayoutConstraint.activate([
//                headerView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
//                guide.bottomAnchor.constraintEqualToSystemSpacingBelow(headerView.bottomAnchor, multiplier: 1.0)
//                ])
//
//        } else {
//            let standardSpacing: CGFloat = 8.0
//            NSLayoutConstraint.activate([
//                headerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
//                bottomLayoutGuide.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: standardSpacing)
//                ])
//        }
        header.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 56)
        header.textAlignment = .center
        header.font = UIFont(name: FONTS.Colfax_Medium.rawValue, size: 18)
        //header.font = UIFont(name: FONTS.ProximaNovaSemibold.rawValue, size: 20)
        header.textColor = UIColor.white
        self.view.addSubview(header)
        
        leftBtn.frame = CGRect(x: 0, y: 20, width: 56, height: 56)
       // header.text = "Proposals"
        leftBtn.isHidden = false
        leftBtn.setImage(#imageLiteral(resourceName: "ic_back_w"), for: .normal)
        //leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        self.view.addSubview(leftBtn)
        
        rightBtn.frame = CGRect(x: self.view.frame.width - 56, y: 20, width: 56, height: 56)
      //  rightBtn.titleLabel?.font = UIFont(name: FONTS.ProximaNovaRegular.rawValue, size: 15)
        self.headerView.addSubview(rightBtn)
        alertView.frame = CGRect(x: self.view.frame.width - 28, y: 40, width: 8, height: 8)
        alertView.backgroundColor = UIColor.red
        alertView.layer.cornerRadius = self.alertView.frame.height/2
        alertView.isHidden = true
        self.view.addSubview(alertView)
        rightSideBtn.frame = CGRect(x: self.view.frame.width - 96, y: 20, width: 56, height: 56)
        self.view.addSubview(rightSideBtn)
        rightSideBtn.isHidden = true
        
        self.sideMenuController()?.sideMenu?.delegate = self
        
    }
    @objc func btnActBack(_ sender: UIButton){
        self.back()
    }
    override func viewDidAppear(_ animated: Bool) {
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = false
        self.sideMenuController()?.sideMenu?.allowPanGesture = false
        self.sideMenuController()?.sideMenu?.allowRightSwipe = false
    }
    func alertView(title:String,message:String,button:String, buttonResult: @escaping (String)->(),destructive:Bool,secondButton:String, secondButtonResult: @escaping (String)->())-> UIAlertController{
        
        // call AlertController define its buttons and its functions and show it
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: button, style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            buttonResult("")
        }
        if(destructive){
            
            let DestructiveAction = UIAlertAction(title: secondButton, style: UIAlertActionStyle.destructive) { (result : UIAlertAction) -> Void in
                secondButtonResult("")
            }
            alertController.addAction(DestructiveAction)
            
        }
        
        alertController.addAction(okAction)
        //    self.presentViewController(alertController, animated: true, completion: nil)
        return alertController
    }
    func sideMenuWillOpen() {
        
        var present = false
        
        for cView in self.view.subviews{
            if cView.tag == 100{
                present = true
            }
        }
        
        if !present{
            let fullView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
            fullView.tag = 100
            fullView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            self.view.addSubview(fullView)
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            fullView.addGestureRecognizer(tap)
            fullView.isUserInteractionEnabled = true
        }
    }
    
    func sideMenuDidClose() {
        for views in self.view.subviews{
            if views.tag == 100{
                views.removeFromSuperview()
            }
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        toggleSideMenuView()
    }
}


