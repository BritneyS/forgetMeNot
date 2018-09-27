//
//  Event.swift
//  ForgetMeNot
//
//  Created by Britney Smith on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import Foundation

extension String {
    func toDate(dateString: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        guard let newDate = formatter.date(from: dateString) else { return Date() }
        return newDate
    }
}

class Event: Codable {
    var eventTitle: String
    var giftRecipient: String
    var dateOfEventString: String
    var haveGift: Bool
    var eventNotes: String
    
    init(eventTitle: String, giftRecipient: String, dateOfEventString: String, haveGift: Bool, eventNotes: String) {
        self.eventTitle = eventTitle
        self.giftRecipient = giftRecipient
        self.dateOfEventString = dateOfEventString
        self.haveGift = haveGift
        self.eventNotes = eventNotes
    }
    
    var dateOfEvent: Date {
        return dateOfEventString.toDate(dateString: dateOfEventString)
    }
    
    enum GiftState: String, Codable {
        case gift
        case warning
        case alarm
        
        var emoji: String {
            switch self {
            case .gift:
                return "🎁"
            case .warning:
                return "⚠️"
            case .alarm:
                return "🚨"
            }
        }
    }
    
    var giftState: GiftState = .warning
    
    var giftEmoji: String {
        if giftState == .gift {
            return GiftState.gift.emoji
        } else if giftState == .warning {
            return GiftState.warning.emoji
        } else if giftState == .alarm {
            return GiftState.alarm.emoji
        }
        return ""
    }
    
//    func setGiftState() {
//        if haveGift == true {
//            giftState = .gift
//        } else if haveGift == false {
//
//        }
//    }
    
}

extension Event {
    
    func countdownToEvent(dateOfEvent: Date) -> Int {
        let currentDate = Date()
        return Int(dateOfEvent.timeIntervalSince(currentDate))  // TimeInterval
    }
    
    func formatTimeInterval(seconds: Int) -> String {
        let secondsInAYear = 29_030_400
        let secondsInAMonth = 2_419_200
        let secondsInAWeek = 604_800
        let secondsInADay = 86_400
        
        switch true {
        case seconds / secondsInAYear > 0:
            let numberOfYears = Int(seconds / secondsInAYear)
            if numberOfYears == 1 {
                return "\(giftEmoji) \(numberOfYears) year"
            } else {
                return "\(giftEmoji) \(numberOfYears) years"
            }
        case seconds / secondsInAMonth > 0:
            let numberOfMonths = Int(seconds / secondsInAMonth)
            if numberOfMonths == 1 {
                return "\(giftEmoji) \(numberOfMonths) month"
            } else {
                return "\(giftEmoji) \(numberOfMonths) months"
            }
        case seconds / secondsInAWeek > 0:
            let numberofWeeks = Int(seconds / secondsInAWeek)
            if numberofWeeks == 1 {
                return "\(giftEmoji) \(numberofWeeks) week"
            } else {
                return " \(giftEmoji) \(numberofWeeks) weeks"
            }
        case seconds / secondsInADay > 0:
            let numberOfDays = Int(seconds / secondsInADay)
            if numberOfDays == 1 {
                return "\(giftEmoji) \(numberOfDays) day"
            } else {
                return " \(giftEmoji) \(numberOfDays) days"
            }
        case seconds < secondsInADay:
            return "\(giftEmoji) Less than one day"
        default:
            return "Invalid date"
        }
    }
}
