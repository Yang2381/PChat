//
//  textCell.swift
//  PChat
//
//  Created by YangSzu Kai on 2017/2/23.
//  Copyright © 2017年 YangSzu Kai. All rights reserved.
//

import UIKit
import Parse

class textCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
