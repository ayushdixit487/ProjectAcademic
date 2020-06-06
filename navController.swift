//
//  navController.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class navController: ENSideMenuNavigationController, ENSideMenuDelegate {
    var sideMenuNew : SideMenuVC!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubview(toFront: navigationBar)
        
        // Do any additional setup after loading the view.
    }
    
    func reloadMenuView(_ homeView:AllOrderVC){
        sideMenuNew = self.storyboard?.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        //sideMenuNew.chkValues()
        navigationController?.isNavigationBarHidden = true
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: sideMenuNew, menuPosition:.left)
        sideMenuNew.allOrderVC = homeView
        sideMenu?.delegate = self //optional
        sideMenu?.menuWidth = 4*UIScreen.main.bounds.width/5 // optional, default is 160
        sideMenu?.bouncingEnabled = false
        
        view.bringSubview(toFront: navigationBar)
    }
}
