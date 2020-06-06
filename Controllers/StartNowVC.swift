//
//  StartNowVC.swift
//  Acadmic
//
//  Created by MAC on 19/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class StartNowVC: headerVC {

    @IBOutlet weak var btnStartNow: UIButton!
    @IBOutlet weak var btnAmonutToLoad: UIButton!
    @IBOutlet weak var btnTA: UIButton!
    @IBOutlet weak var lblAmontToLoad: UILabel!
    @IBOutlet weak var lblTA: UILabel!
    @IBOutlet weak var lblDateNTime: UILabel!
    @IBOutlet weak var btnPP: UIButton!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblEvnt: UILabel!
    @IBOutlet weak var vw1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Order #567889786"
        btnStartNow.makeRounderCorners(5)
        btnPP.makeSemiCircle()
        btnAmonutToLoad.makeSemiCircle()
        btnTA.makeSemiCircle()
        vw1.makeRounderCorners(5)
        btnStartNow.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        btnStartNow.addTarget(self, action: #selector(btnActDeposit(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    @objc func btnActDeposit(_ sender: UIButton){
        self.moveTowrads("RateWritterVC")
    }
}
