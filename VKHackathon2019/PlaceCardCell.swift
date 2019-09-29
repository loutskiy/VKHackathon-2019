//
//  PlaceCardCell.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class PlaceCardCell: CardCell {
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var emojiImage: UILabel!
    
    override func prepareForReuse() {
           super.prepareForReuse()
    }

   override func layoutSubviews() {

       self.layer.cornerRadius = 12
       super.layoutSubviews()
   }
}
