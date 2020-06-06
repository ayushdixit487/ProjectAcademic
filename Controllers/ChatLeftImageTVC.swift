//
//  ChatLeftImageTVC.swift
//  Acadmic
//
//  Created by MAC on 30/07/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class ChatLeftImageTVC: UITableViewCell {

    @IBOutlet weak var LeftProfilePic: UIImageView!
    @IBOutlet weak var LeftImgVw: UIImageView!
    @IBOutlet weak var lblLeftTime: UILabel!
    @IBOutlet weak var LeftVw: chatLeftView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
