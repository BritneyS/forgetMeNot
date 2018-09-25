//
//  EventDetailViewController.swift
//  ForgetMeNot
//
//  Created by DetroitLabs on 9/25/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

class EventDetailViewController: UITableViewController {

    
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var haveGiftLabel: UILabel!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    // MARK: - Properties
    let eventsDatabase = EventDatabase()
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        displayEventData()
    }
    
    // MARK: - Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getEvent() -> Event {
        return eventsDatabase.events[0]
    }
    
    func displayEventData() {
        let event = getEvent()
        titleLabel.text = event.eventTitle
        dateLabel.text = event.dateOfEventString
        haveGiftLabel.text = "Do you have a gift for \(event.giftRecipient)?"
        notesView.text = event.eventNotes
        if event.haveGift == false {
            noButton.backgroundColor = UIColor.blue
            noButton.setTitleColor(UIColor.white, for: .normal)
        }
        else {
            yesButton.backgroundColor = UIColor.blue
            yesButton.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func getRandomGift() -> URL? {
        let urls = GiftIdeaLinks().urls
        let randomIndex = Int(arc4random_uniform(UInt32(urls.count)))
        let urlString = urls[randomIndex]
        guard let url = URL(string: urlString) else { return URL(string: "")}
        return url
    }
    
    // MARK: - Actions
    
    @IBAction func haveGiftYesButton(_ sender: UIButton) {
    }
    
    @IBAction func haveGiftNoButton(_ sender: UIButton) {
        showActionSheet()
    }
    
    // MARK: - Action Sheet
    
    @objc func showActionSheet() {
        
        let actionSheet = UIAlertController(title: "What are you gonna do about it?", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let remindAgain = UIAlertAction(title: "Remind Me Later", style: .default) { action in
            // does anything happen here?
        }
        
        let needGift = UIAlertAction(title: "Find A Gift", style: .default) { action in
            if let url = self.getRandomGift() {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
        
        actionSheet.addAction(cancel)
        actionSheet.addAction(needGift)
        actionSheet.addAction(remindAgain)
        
        present(actionSheet, animated: true, completion: nil)
    }
}
