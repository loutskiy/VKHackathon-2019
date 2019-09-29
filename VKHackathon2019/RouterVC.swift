//
//  RouterVC.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import SafariServices
import SDWebImage

class Aviaticket {
    var id: Int
    var company: UIImage
    var fromIATA: String
    var toIATA: String
    var timeArrive: String
    var timeDeparture: String
    var companyName: String
    
    init(id: Int, company: UIImage, fromIATA: String, toIATA: String, timeArrival: String, timeDeparture: String, companyName: String) {
        self.id = id
        self.company = company
        self.fromIATA = fromIATA
        self.toIATA = toIATA
        self.timeArrive = timeArrival
        self.timeDeparture = timeDeparture
        self.companyName = timeArrival
    }
}

class Hotel {
    var id: Int
    var name: String
    var dateLabel: String
    var address: String
    
    init(id: Int, name: String, dateLabel: String, address: String) {
        self.id = id
        self.name = name
        self.dateLabel = dateLabel
        self.address = address
    }
}

class RouterVC: UIViewController, SFSafariViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var routerNameLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var places = [PlaceObject]()
    var trip: TripObject!
    var planes = [Aviaticket(id: 0, company: #imageLiteral(resourceName: "Pobeda_logo.svg"), fromIATA: "VKO", toIATA: "VIE", timeArrival: "21 ноября в 10:25", timeDeparture: "21 ноября в 11:35", companyName: "Pobeda"), Aviaticket(id: 1, company: #imageLiteral(resourceName: "Pobeda_logo.svg"), fromIATA: "VIE", toIATA: "VKO", timeArrival: "25 ноября в 10:25", timeDeparture: "21 ноября в 11:35", companyName: "Pobeda")]
    
    var final = [AnyObject]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var toIATA = "LED"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        if trip != nil {
            
            routerNameLabel.text = "Ваш маршрут в \(trip.city ?? "") (\(trip.country ?? ""))"
            
            var dh = ""
            var price = 0
            
            if let t = trip.tickets.first {
                let ticket = Aviaticket(id: 0, company: #imageLiteral(resourceName: "Pobeda_logo.svg"), fromIATA: t.fromIATA, toIATA: t.toIATA, timeArrival: DateConverter().convertDateTimerToStr(date: DateConverter().convertStringToDate(str: t.departureAt)), timeDeparture: DateConverter().convertDateTimerToStr(date: DateConverter().convertStringToDate(str: t.departureAt).addingTimeInterval(7200)), companyName: "\(t.airline ?? "")-\(t.flightNumber ?? 0)")
                toIATA = ticket.toIATA
                dh = "с \(DateConverter().convertDateToStr(date: DateConverter().convertStringToDate(str: t.departureAt))) по \(DateConverter().convertDateToStr(date: DateConverter().convertStringToDate(str: t.returnAt)))"
                final.append(ticket)
                price = t.price
            }
            
            if let h = trip.hotels.first {
                let hotel = Hotel(id: h.id, name: h.label, dateLabel: dh, address: "\(trip.country ?? ""), \(trip.city ?? "")")
                final.append(hotel)
                price += h.price
            }
            
            for i in places {
                final.append(i)
            }
            if let t = trip.tickets.first {
                let ticket = Aviaticket(id: 0, company: #imageLiteral(resourceName: "Pobeda_logo.svg"), fromIATA: t.toIATA, toIATA: t.fromIATA, timeArrival: DateConverter().convertDateTimerToStr(date: DateConverter().convertStringToDate(str: t.returnAt)), timeDeparture: DateConverter().convertDateTimerToStr(date: DateConverter().convertStringToDate(str: t.returnAt).addingTimeInterval(14400)), companyName: "\(t.airline ?? "")-\(t.flightNumber ?? 0)")
                final.append(ticket)
            }
            
            buyButton.setTitle("КУПИТЬ ЗА \(price)₽", for: .normal)
        } else {
            routerNameLabel.text = "Ваш маршрут по фильму Евротур 🇪🇺"
            var price = 0
            let ticket1 = Aviaticket(id: 0, company: #imageLiteral(resourceName: "1200px-Wizz_Air_logo_2015.svg"), fromIATA: "VKO", toIATA: "LUT", timeArrival: "2 октября в 11:30", timeDeparture: "2 октября в 13:00", companyName: "WizzAir")
            price += 2100
            final.append(ticket1)
            let hotel1 = Hotel(id: 0, name: "Hotel London", dateLabel: "2 октября", address: "Англия, Лондон")
            let hotel2 = Hotel(id: 1, name: "Paris Grand", dateLabel: "3 октября", address: "Франция, Париж")
            let hotel3 = Hotel(id: 2, name: "AmsterLove", dateLabel: "4 октября", address: "Нидерланды, Амстердам")
            let hotel4 = Hotel(id: 3, name: "Elisabeth Old Town", dateLabel: "5 октября", address: "Словакия, Братислава")
            let hotel5 = Hotel(id: 3, name: "Rome residence", dateLabel: "6 октября", address: "Италия, Рим")
            let hotel6 = Hotel(id: 3, name: "Mercure", dateLabel: "6 октября", address: "Германия, Берлин")
            final.append(hotel1)
            final.append(hotel2)
            final.append(hotel3)
            final.append(hotel4)
            final.append(hotel5)
            final.append(hotel6)
            let ticket2 = Aviaticket(id: 1, company: #imageLiteral(resourceName: "Pobeda_logo.svg"), fromIATA: "TXL", toIATA: "VKO", timeArrival: "6 октября в 11:30", timeDeparture: "6 октября в 14:00", companyName: "Pobeda")
            final.append(ticket2)
            buyButton.setTitle("КУПИТЬ ЗА \(30482)₽", for: .normal)
            toIATA = "LUT"
        }
    }
    

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func buyAction(_ sender: Any) {
        let safari = SFSafariViewController(url: URL(string: "https://aviasales.ru/search/MOW0210\(toIATA)0710")!)
        safari.delegate = self
        present(safari, animated: true, completion: nil)
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension RouterVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return final.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = final[indexPath.row]
        if let i = i as? PlaceObject {
            let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell") as! PlaceCell
            cell.emojiImage.text = i.emoji
            cell.placeImageView.sd_setImage(with: URL(string: i.image), completed: nil)
            cell.placeNameLabel.text = i.name
            cell.placeLocationLabel.text = trip.city
            return cell
        } else if let i = i as? Hotel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "hotelCell") as! HotelCell
            cell.hotelNameLabel.text = i.name
            cell.dateLabel.text = i.dateLabel
            return cell
        } else if let i = i as? Aviaticket {
            let cell = tableView.dequeueReusableCell(withIdentifier: "planeCell") as! PlaneCell
            cell.companyLogoImageView.image = i.company
            cell.fromLabel.text = i.fromIATA
            cell.toLabel.text = i.toIATA
            cell.fromTimeLabel.text = i.timeArrive
            cell.toTimeLabel.text = i.timeDeparture
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
