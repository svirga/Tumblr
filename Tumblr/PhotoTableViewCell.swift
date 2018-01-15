//
//  PhotoTableViewCell.swift
//  Tumblr
//
//  Created by Simona Virga on 1/10/18.
//  Copyright © 2018 Simona Virga. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell
{

    @IBOutlet weak var picture: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
