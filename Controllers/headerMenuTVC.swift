//
//  headerMenuTVC.swift
//  Acadmic
//
//  Created by MAC on 14/06/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

class headerMenuTVC: UITableViewCell {

    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var profileaPic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
