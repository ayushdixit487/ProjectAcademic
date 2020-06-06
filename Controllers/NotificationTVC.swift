//
//  NotificationTVC.swift
//  Acadmic
//
//  Created by MAC on 03/08/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewCell {

    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
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
