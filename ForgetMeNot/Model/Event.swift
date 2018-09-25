//
//  Event.swift
//  ForgetMeNot
//
//  Created by Britney Smith on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import Foundation

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

class Event {
    var eventTitle: String
    var giftRecipient: String
    var dateOfEvent: Date
    var haveGift: Bool
    var eventNotes: String
    
    init(eventTitle: String, giftRecipient: String, dateOfEvent: Date, haveGift: Bool, eventNotes: String) {
        self.eventTitle = eventTitle
        self.giftRecipient = giftRecipient
        self.dateOfEvent = dateOfEvent
        self.haveGift = haveGift
        self.eventNotes = eventNotes
    }
    
    var dateOfEventString: String {
        return dateOfEvent.toString(dateFormat: "yyyy-MM-dd") //TODO: Make this format match app's.
    }
    
}

extension Event {
    
    func countdownToEvent(dateOfEvent: Date) -> Int {
        let currentDate = Date()
        return Int(dateOfEvent.timeIntervalSince(currentDate))  // TimeInterval
    }
    
    func formatTimeInterval(seconds: Int) -> String {
        let secondsInAYear = 3_153_600
        let secondsInAMonth = 2_419_200
        let secondsInAWeek = 604_800
        let secondsInADay = 86_400
        
        switch true {
        case seconds / secondsInAYear > 0:
            let numberOfYears = Int(seconds / secondsInAYear)
            if numberOfYears == 1 {
                return "\(numberOfYears) year"
            } else {
                return "\(numberOfYears) years"
            }
        case seconds / secondsInAMonth > 0:
            let numberOfMonths = Int(seconds / secondsInAMonth)
            if numberOfMonths == 1 {
                return "\(numberOfMonths) month"
            } else {
                return "\(numberOfMonths) months"
            }
        case seconds / secondsInAWeek > 0:
            let numberofWeeks = Int(seconds / secondsInAWeek)
            if numberofWeeks == 1 {
                return "\(numberofWeeks) week"
            } else {
                return "\(numberofWeeks) weeks"
            }
        case seconds / secondsInADay > 0:
            let numberOfDays = Int(seconds / secondsInADay)
            if numberOfDays == 1 {
                return "\(numberOfDays) day"
            } else {
                return "\(numberOfDays) days"
            }
        case seconds < secondsInADay:
            return "Less than one day"
        default:
            return "Invalid date"
        }
    }
}
