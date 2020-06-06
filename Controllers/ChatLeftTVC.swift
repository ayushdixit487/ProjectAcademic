//
//  ChatLeftTVC.swift
//  Acadmic
//
//  Created by MAC on 21/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ChatLeftTVC: UITableViewCell {

    @IBOutlet weak var lblTimeLeft: UILabel!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var MsgVw: UIView!
    @IBOutlet weak var ProfileLeft: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
