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

class Event: NSObject, Codable {
    var eventTitle: String
    var giftRecipient: String
    var dateOfEventString: String
    var haveGift: Bool
    var eventNotes: String
    
    static var giftState: GiftState?
    
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
}

extension Event {
    
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
    
    var giftEmoji: String {
        if Event.giftState == .gift {
            return GiftState.gift.emoji
        } else if Event.giftState == .warning {
            return GiftState.warning.emoji
        } else if Event.giftState == .alarm {
            return GiftState.alarm.emoji
        }
        return ""
    }
    
    func setGiftState(state: GiftState) {
        if haveGift == true {
            Event.giftState = .gift
        } else if haveGift == false {
            Event.giftState = state
        }
    }
    
}

extension Event {
    
    func countdownToEvent(dateOfEvent: Date) -> Int {
        let currentDate = Date()
        return Int(DateInterval(start: currentDate, end: dateOfEvent).duration) // Time Interval
        //return Int(dateOfEvent.timeIntervalSince(currentDate))  // TimeInterval
    }
    
    func formatTimeInterval(seconds: Int) -> String {
        let secondsInAYear = 29_030_400
        let secondsInAMonth = 2_419_200
        let secondsInAWeek = 604_800
        let secondsInADay = 86_400
        
        switch true {
        case seconds / secondsInAYear > 0:
            let numberOfYears = Int(seconds / secondsInAYear)
            setGiftState(state: .warning)
            if numberOfYears == 1 {
                return "\(giftEmoji) \(numberOfYears) year"
            } else {
                return "\(giftEmoji) \(numberOfYears) years"
            }
        case seconds / secondsInAMonth > 0:
            let numberOfMonths = Int(seconds / secondsInAMonth)
            setGiftState(state: .warning)
            if numberOfMonths == 1 {
                return "\(giftEmoji) \(numberOfMonths) month"
            } else {
                return "\(giftEmoji) \(numberOfMonths) months"
            }
        case seconds / secondsInAWeek > 0:
            let numberofWeeks = Int(seconds / secondsInAWeek)
            setGiftState(state: .warning)
            if numberofWeeks == 1 {
                return "\(giftEmoji) \(numberofWeeks) week"
            } else {
                return "\(giftEmoji) \(numberofWeeks) weeks"
            }
        case seconds / secondsInADay > 0:
            let numberOfDays = Int(seconds / secondsInADay)
            setGiftState(state: .alarm)
            if numberOfDays == 1 {
                return "\(giftEmoji) \(numberOfDays) day"
            } else {
                return "\(giftEmoji) \(numberOfDays) days"
            }
        case seconds < secondsInADay:
            setGiftState(state: .alarm)
            return "\(giftEmoji) Less than one day"
        default:
            return "Invalid date"
        }
    }
}
