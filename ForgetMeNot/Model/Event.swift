//
//  Event.swift
//  ForgetMeNot
//
//  Created by Britney Smith on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//
/*
 extension Date
 {
 func toString( dateFormat format  : String ) -> String
 {
 let dateFormatter = DateFormatter()
 dateFormatter.dateFormat = format
 return dateFormatter.string(from: self)
 }
 }
 
 In above method we can set the required output date format.
 Usage:
 Add the following lines of code for usage:
 
 let dateString = Date().toString(dateFormat: "yyyy/MMM/dd HH:mm:ss")
 print("dateString is \(dateString)")
 
 // output will be 'dateString is 2017/Oct/11 17:16:23'
 */
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
        return dateOfEvent.toString(dateFormat: "yyyy-MM-dd")
    }
    
    
    
    func countdownToEvent(dateOfEvent: Date) {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let timeInterval = dateOfEvent.timeIntervalSince()
        /*
         let dateString = "2018-12-19"
         let dateOfEvent = RFC3339DateFormatter.date(from: dateString)
         let timeInterval = dateOfEvent!.timeIntervalSince(currentDate)
         */
        
    }
}
