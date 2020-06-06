//
//  RatingTVC.swift
//  Acadmic
//
//  Created by MAC on 16/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import Cosmos
class RatingTVC: UITableViewCell {
    @IBOutlet weak var st7: UIImageView!
    @IBOutlet weak var st8: UIImageView!
    
    @IBOutlet weak var RatingVw: CosmosView!
    @IBOutlet weak var st10: UIImageView!
    @IBOutlet weak var st9: UIImageView!
    @IBOutlet weak var st6: UIImageView!
    @IBOutlet weak var st5: UIImageView!
    @IBOutlet weak var st4: UIImageView!
    @IBOutlet weak var st3: UIImageView!
    @IBOutlet weak var st2: UIImageView!
    @IBOutlet weak var st1: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblRvw: UILabel!
    @IBOutlet weak var ImgPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
