//
//  CntctSuprtVC.swift
//  Acadmic
//
//  Created by MAC on 18/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class CntctSuprtVC: headerVC {
    var screentype = 0
    
    @IBOutlet weak var lblAsk: UILabel!
    @IBOutlet weak var ShdVw: UIView!
    @IBOutlet weak var btnPreviosHistry: UIButton!
    @IBOutlet weak var btnPS: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        header.text = "Contact Support"
        btnPS.makeRounderCorners(5)
        ShdVw.makeSemiCircle()
        ShdVw.isHidden = true
        btnPreviosHistry.makeRounderCorners(5)
        btnPreviosHistry.backgroundColor = UIColor(netHex: COLORS.LIGHTBLUE.rawValue)
        btnPS.backgroundColor = UIColor(netHex: COLORS.YELLOW.rawValue)
        if screentype == 0{
            leftBtn.addTarget(self, action: #selector(btnActMenu(_:)), for: .touchUpInside)
            leftBtn.setImage(#imageLiteral(resourceName: "ic_menu"), for: .normal)

        }else{
            leftBtn.addTarget(self, action: #selector(btnActBack(_:)), for: .touchUpInside)
        }
        if Chinese == 1{
            header.text = "联系售后"
            lblAsk.text = "要求退款/销售"
            btnPS.setTitle("点我解决你的⼀一切问题", for: .normal)
            btnPreviosHistry.setTitle("查看以前的售后记录", for: .normal)
        }
        btnPS.addTarget(self, action: #selector(btnProblemSolution(_:)), for: .touchUpInside)
        btnPreviosHistry.addTarget(self, action: #selector(btnPreviosHistory(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    @objc func btnActMenu(_ sender: UIButton){
        view.endEditing(true)
        toggleSideMenuView()
    }
    @objc func btnPreviosHistory(_ sender: UIButton){
        self.moveTowrads("MessageVC")
    }
    @objc func btnProblemSolution(_ sender: UIButton){
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC" ) as! ChatVC
        secondVC.ScreenType = 1
        secondVC.chatType = 3
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}
