//
//  TransactionTVC.swift
//  Acadmic
//
//  Created by MAC on 13/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class TransactionTVC: UITableViewCell {

    @IBOutlet weak var SepratorVw: UIView!
    @IBOutlet weak var lblDatenTime: UILabel!
    @IBOutlet weak var btnMoney: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
