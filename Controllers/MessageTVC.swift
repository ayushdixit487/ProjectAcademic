//
//  MessageTVC.swift
//  Acadmic
//
//  Created by MAC on 18/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class MessageTVC: UITableViewCell {

    @IBOutlet weak var ContentVw: UIView!
    @IBOutlet weak var lblNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var msgVw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
