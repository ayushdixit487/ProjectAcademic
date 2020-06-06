//
//  ChatRightTVC.swift
//  Acadmic
//
//  Created by MAC on 21/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ChatRightTVC: UITableViewCell {

    @IBOutlet weak var rightProfilePic: UIImageView!
    @IBOutlet weak var RightLblTime: UILabel!
    @IBOutlet weak var rightLblMsg: UILabel!
    @IBOutlet weak var RightMsgVw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
