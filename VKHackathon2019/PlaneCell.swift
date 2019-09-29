//
//  PlaneCell.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

class PlaneCell: UITableViewCell {

    @IBOutlet weak var companyLogoImageView: UIImageView!
    @IBOutlet weak var fromLabel: UILabel!
    @IBOutlet weak var toLabel: UILabel!
    @IBOutlet weak var fromTimeLabel: UILabel!
    @IBOutlet weak var toTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
