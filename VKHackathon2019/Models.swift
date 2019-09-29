//
//  Models.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 29/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import ObjectMapper

class TripObject: Mappable {
    
    var img: String!
    var country: String!
    var emoji: [String]!
    var city: String!
    var tickets: [TicketObject]!
    var hotels: [HotelObject]!
    var places: [[PlaceObject]]!
    
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        img <- map["img"]
        country <- map["country"]
        emoji <- map["emoji"]
        city <- map["city"]
        tickets <- map["tickets"]
        hotels <- map["hotels"]
        places <- map["places"]
    }
}

class PlaceObject: Mappable {
    
    var name: String!
    var image: String!
    var price: String!
    var coordinates: [Float]!
    
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        image <- map["image"]
        price <- map["price"]
        coordinates <- map["coordinates"]
    }
}

class TicketObject: Mappable {
    
    var price: Int!
    var airline: String!
    var flightNumber: Int!
    var departureAt: String!
    var returnAt: String!
    var expiresAt: String!
    var fromIATA: String!
    var toIATA: String!
    
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        price <- map["price"]
        airline <- map["airline"]
        flightNumber <- map["flight_number"]
        departureAt <- map["departure_at"]
        returnAt <- map["return_at"]
        expiresAt <- map["expires_at"]
        fromIATA <- map["fromIATA"]
        toIATA <- map["toIATA"]
    }
}

class HotelObject: Mappable {
    
    var location: [Float]!
    var score: Int!
    var label: String!
    var id: Int!
    var fullName: String!
    var locationId: Int!
    var locationName: String!
    
    required init?(map: Map) {

    }

    // Mappable
    func mapping(map: Map) {
        location <- map["location"]
        score <- map["_score"]
        label <- map["label"]
        id <- map["id"]
        fullName <- map["fullName"]
        locationId <- map["locationId"]
        locationName <- map["locationName"]
    }
}
