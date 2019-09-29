//
//  PlacesVC.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 28/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import SDWebImage

class Place {
    var id: Int
    var name: String
    var description: String
    var image: UIImage
    var price: Int
    var emoji: UIImage
    
    init(id: Int, name: String, description: String, image: UIImage, price: Int, emoji: UIImage) {
        self.id = id
        self.name = name
        self.description = description
        self.image = image
        self.price = price
        self.emoji = emoji
    }
}

class PlacesVC: UIViewController, VerticalCardSwiperDatasource, VerticalCardSwiperDelegate {
    
    @IBOutlet weak var cardSwiper: VerticalCardSwiper!
    
    var trip: TripObject!
    
//    var places = [
//        Place(id: 0, name: "Миланский собор", description: "Кафедральный собор в Милане расположен в историческом центре города.", image: #imageLiteral(resourceName: "856MilanoDuomo"), price: 10, emoji: #imageLiteral(resourceName: "😍")),
//        Place(id: 0, name: "Миланский собор", description: "Кафедральный собор в Милане расположен в историческом центре города.", image: #imageLiteral(resourceName: "856MilanoDuomo"), price: 10, emoji: #imageLiteral(resourceName: "😍")),
//        Place(id: 0, name: "Миланский собор", description: "Кафедральный собор в Милане расположен в историческом центре города.", image: #imageLiteral(resourceName: "856MilanoDuomo"), price: 10, emoji: #imageLiteral(resourceName: "😍"))
//    ]
    
    var selected = [PlaceObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Соберите свой маршрут"
        
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        // register cardcell for storyboard use
        cardSwiper.register(nib: UINib(nibName: "PlaceCardCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        
        let back = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .done, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = back
        
        let next = UIBarButtonItem(title: "Далее", style: .done, target: self, action: #selector(nextAction))
        navigationItem.rightBarButtonItem = next
    }
    
    @objc func nextAction() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RouterVC") as! RouterVC
        vc.modalPresentationStyle = .fullScreen
        vc.trip = trip
        vc.places = selected
//        vc.places = selected
        present(vc, animated: true, completion: nil)
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }

    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "cell", for: index) as? PlaceCardCell {
            if let p = trip.places.first {
                let place = p[index]
                cardCell.backImageView.sd_setImage(with: URL(string: place.image), completed: nil)
                cardCell.descriptionLabel.text = place.description ?? ""
                cardCell.emojiImage.text = place.emoji
                cardCell.titleLabel.text = place.name
                cardCell.priceLabel.text = "\(place.price ?? "")"
                return cardCell
            }
        }
        return CardCell()
    }
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        if let p = trip.places.first {
            return p.count
        }
        return 0
    }
    
    func willSwipeCardAway(card: CardCell, index: Int, swipeDirection: SwipeDirection) {
        // called right before the card animates off the screen.
        if var p = trip.places.first {
            if swipeDirection == .Right {
                selected.append(p[index])
            }
            p.remove(at: index)
            trip.places = [p]
            if p.count == 0 {
                nextAction()
            }
        }
    }
}
