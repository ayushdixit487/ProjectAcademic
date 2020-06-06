//
//  AllOrdersTVC.swift
//  Acadmic
//
//  Created by MAC on 14/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class AllOrdersTVC: UITableViewCell {

    @IBOutlet weak var RoundVw: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var Vw2: UIView!
    @IBOutlet weak var btnDeposit: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var StkVw: UIStackView!
    @IBOutlet weak var SeprtrVw: UIView!
    @IBOutlet weak var lblDownload: UILabel!
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var btnSts: UIButton!
    @IBOutlet weak var lblOrdrNo: UILabel!
    @IBOutlet weak var lblSbjct: UILabel!
    @IBOutlet weak var lblEvent: UILabel!
    @IBOutlet weak var Vw1: UIView!
    
    @IBOutlet weak var Vw1Height: NSLayoutConstraint!
    @IBOutlet weak var downloadHeight: NSLayoutConstraint!
    @IBOutlet weak var stkHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDeadline: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
