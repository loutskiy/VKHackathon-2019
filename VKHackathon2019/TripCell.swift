//
//  TripCell.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

class TripCell: UITableViewCell {

    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var cityNameLable: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var emojiImageView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
