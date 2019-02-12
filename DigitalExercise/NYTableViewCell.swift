//
//  nyTableViewCell.swift
//  DigitalExercise
//
//  Created by Saad Al Mubarak on 2/10/19.
//  Copyright © 2019 Saad Al Mubarak. All rights reserved.
//

import UIKit

class NYTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var headTitle: UILabel!
    @IBOutlet weak var publishedBy: UILabel!
    @IBOutlet weak var publishedDate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //set image style to be round
        // we need to set image to clip to bounds to true -- done through storyboard
        //coverImage.clipsToBounds = true 
        coverImage.layer.cornerRadius = coverImage.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
