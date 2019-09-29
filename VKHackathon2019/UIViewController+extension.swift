//
//  UIViewController+extension.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        vc.addAction(ok)
        present(vc, animated: true, completion: nil)
    }
}
