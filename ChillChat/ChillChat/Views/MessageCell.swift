//
//  MessageCell.swift
//  ChillChat
//
//  Created by Toygun Çil on 20.08.2022.
//  Copyright © 2022 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
    }
    @IBOutlet weak var messageBubble: UIView! {
        didSet {
            messageBubble.layer.cornerRadius = messageBubble.frame.height / 5
        }
    }
    @IBOutlet weak var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
