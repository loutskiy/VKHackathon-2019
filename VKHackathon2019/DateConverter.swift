//
//  DateConverter.swift
//  VKHackathon2019
//
//  Created by Михаил Луцкий on 29/09/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import Foundation

class DateConverter {
    func convertStringToDate(str: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return formatter.date(from: str) ?? Date()
    }
    
    func convertDateToStr(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM"
        return formatter.string(from: date)
    }
    
    func convertDateTimerToStr(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM 'в' HH:mm"
        return formatter.string(from: date)
    }
}
