//
//  ChatRightImageVC.swift
//  Acadmic
//
//  Created by MAC on 30/07/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ChatRightImageVC: UITableViewCell {

    @IBOutlet weak var RightProfilePic: UIImageView!
    @IBOutlet weak var RightImgVw: UIImageView!
    @IBOutlet weak var LblRightTime: UILabel!
    @IBOutlet weak var RightVw: chatRightView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
