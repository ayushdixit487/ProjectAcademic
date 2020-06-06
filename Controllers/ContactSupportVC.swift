//
//  ContactSupportVC.swift
//  Acadmic
//
//  Created by MAC on 15/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import ENSwiftSideMenu

class ContactSupportVC: headerVC {

    @IBOutlet weak var btnAddFiles: UIButton!
    @IBOutlet weak var btnCncl: UIButton!
    @IBOutlet weak var btnSnd: UIButton!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var Vw1: UIView!
    @IBOutlet weak var btnADD: UICollectionView!
    @IBOutlet weak var photoClctnVw: UICollectionView!
    @IBOutlet weak var txtVw: UITextView!
    @IBOutlet weak var btnPicker: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
   header.text =  "Contact Support"
        txtVw.makeRounderCorners(5)
        btnPicker.makeRounderCorners(5)
        Vw2.makeRounderCorners(5)
        Vw1.makeRounderCorners(5)
        btnSnd.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        btnAddFiles.makeRounderCorners(5)
        btnAddFiles.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuController()?.sideMenu?.delegate = self
        self.sideMenuController()?.sideMenu?.allowLeftSwipe = true
        self.sideMenuController()?.sideMenu?.allowPanGesture = true
        self.sideMenuController()?.sideMenu?.allowRightSwipe = true
    }
    @objc func btnActMenu(_ sender: UIButton){
        toggleSideMenuView()
    }

}
extension ContactSupportVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCVC", for: indexPath) as! PhotoCVC
        
        return cell
    }
}
