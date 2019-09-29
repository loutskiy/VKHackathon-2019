//
//  ServerManager.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 29/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ServerManager {
    
    static func getList(emoji: String, r: @escaping(_ trips: [TripObject]) -> Void) {
        let url = "http://demo14.charlie.vkhackathon.com:8080/gen/\(emoji)"
        let safeURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        Alamofire.request(safeURL).responseJSON { (response) in
            switch response.result {
            case .success:
                let trips = Mapper<TripObject>().mapArray(JSONObject: response.result.value)
                r(trips ?? [TripObject]())
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
}
