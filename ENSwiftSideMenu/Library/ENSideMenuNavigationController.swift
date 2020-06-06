//
//  RootNavigationViewController.swift
//  SwiftSideMenu
//
//  Created by Evgeny Nazarov on 29.09.14.
//  Copyright (c) 2014 Evgeny Nazarov. All rights reserved.
//

import UIKit

open class ENSideMenuNavigationController: UINavigationController, ENSideMenuProtocol {
    
    public var sideMenu : ENSideMenu?
    public var sideMenuAnimationType : ENSideMenuAnimation = .default
    
    
    // MARK: - Life cycle
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public init( menuViewController: UIViewController, contentViewController: UIViewController?) {
        super.init(nibName: nil, bundle: nil)
        
        if (contentViewController != nil) {
            self.viewControllers = [contentViewController!]
        }
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: menuViewController, menuPosition:.left)
        view.bringSubview(toFront: navigationBar)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    public func setContentViewController(_ contentViewController: UIViewController) {
        self.sideMenu?.toggleMenu()
        switch sideMenuAnimationType {
        case .none:
            contentViewController.navigationItem.hidesBackButton = true
            //
            //            let transition = CATransition()
            //            transition.duration = 0.5
            //            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            //            transition.type = kCATransitionFade
            //            transition.subtype = kCATransitionFromLeft
            //            self.navigationController?.view.layer.add(transition, forKey: nil)
            //            _ = self.navigationController?.popToRootViewController(animated: false)
            self.viewControllers = [contentViewController]
            break
        default:
            //            let transition = CATransition()
            //            transition.duration = 0.5
            //            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            //            transition.type = kCATransitionFade
            //            transition.subtype = kCATransitionFromLeft
            //            self.navigationController?.view.layer.add(transition, forKey: nil)
            //            self.navigationController?.pushViewController(contentViewController, animated: true)
            
            self.setViewControllers([contentViewController], animated: true)
            break
        }
        
    }
    
}
