//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by MacBookPro9 on 11/13/18.
//  Copyright © 2018 MacBookPro9. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var post: Post! {
        didSet {
            
            self.usernameLabel.text = post.author.username
            self.captionLabel.text = post.caption
           
            
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
