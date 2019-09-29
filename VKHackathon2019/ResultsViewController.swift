//
//  ResultsViewController.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import FloatingPanel
import SDWebImage
import MBProgressHUD

struct Destination {
    var id: Int
    var image: UIImage
    var city: String
    var country: String
    var date: String
    var emoji: String
}

class ResultsViewController: UIViewController, FloatingPanelControllerDelegate {
    
    var emojies: [Emoji]!
    
    var fpc: FloatingPanelController!

    @IBOutlet weak var tableView: UITableView!
    
    let destinations = [
        Destination(id: 0, image: #imageLiteral(resourceName: "VIE"), city: "Вена", country: "Австрия", date: "01 Ноября (4 дня)", emoji: "❤️"),
        Destination(id: 1, image: #imageLiteral(resourceName: "LED"), city: "Санкт-Питербург", country: "Россия", date: "01 Ноября (4 дня)", emoji: "🌉")
    ]
    
    var trips = [TripObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fpc = FloatingPanelController()
        fpc.surfaceView.backgroundColor = .clear
        fpc.surfaceView.cornerRadius = 9.0
        fpc.surfaceView.shadowHidden = true
        fpc.surfaceView.grabberHandle.isHidden = false
        // Assign self as the delegate of the controller.
        fpc.delegate = self // Optional
        fpc.isRemovalInteractionEnabled = true
        
        // Set a content view controller.
        let contentVC = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        fpc.set(contentViewController: contentVC)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = back
        
        let filter = UIBarButtonItem(image: #imageLiteral(resourceName: "settings"), style: .done, target: self, action: #selector(filterAction))
        navigationItem.rightBarButtonItem = filter
        
        var str = ""
        for i in emojies {
            str += i.Image
        }
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        ServerManager.getList(emoji: str) { (tr) in
            self.trips = tr
            self.tableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }

    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func filterAction() {
        self.present(fpc, animated: true, completion: nil)
    }
    
    func loadData() {
        
    }
    
    func floatingPanel(_ vc: FloatingPanelController, layoutFor newCollection: UITraitCollection) -> FloatingPanelLayout? {
        return FilterFloatingPanelLayout()
    }

}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Наши рекоммендации"
        } else {
            return "Собери сам"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trips.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = trips[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TripCell
        cell.cityImageView.sd_setImage(with: URL(string: item.img), completed: nil)
        cell.cityNameLable.text = item.city
        cell.countryLabel.text = item.country
        var i = 0
        if let t = item.tickets.first {
            let date = DateConverter().convertStringToDate(str: t.departureAt)
            cell.dateLabel.text = "С \(DateConverter().convertDateToStr(date: date))"
            i = t.price
        }
        if let h = item.hotels.first {
            i += h.price
        }
        cell.priceLabel.text = "от \(i)₽"
        if let e = item.emoji.first {
            cell.emojiImageView.text = e
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let trip = trips[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "PlacesVC") as! PlacesVC
        vc.trip = trip
        navigationController?.pushViewController(vc, animated: true)
    }
}

class FilterFloatingPanelLayout: FloatingPanelLayout {
    public var initialPosition: FloatingPanelPosition {
        return .half
    }
    
    var supportedPositions: Set<FloatingPanelPosition> {
        return [.half]
    }
    
    public func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .half: return 600.0 // A bottom inset from the safe area
        default: return nil // Or `case .hidden: return nil`
        }
    }
}
