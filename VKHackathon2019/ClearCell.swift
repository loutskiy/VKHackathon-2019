//
//  ClearCell.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

protocol ClearCellDelegate: NSObject {
    func didClickToClearButton()
}

class ClearCell: UICollectionViewCell {
    
    weak var delegate: ClearCellDelegate?
    
    @IBAction func clearAction(_ sender: Any) {
        delegate?.didClickToClearButton()
    }
}
