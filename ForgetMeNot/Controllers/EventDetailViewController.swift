//
//  EventDetailViewController.swift
//  ForgetMeNot
//
//  Created by DetroitLabs on 9/25/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

protocol EventDetailViewControllerDelegate: class {
    func detail(_ controller: EventDetailViewController, didChangeGiftStatus event: Event)
}

class EventDetailViewController: UITableViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var haveGiftLabel: UILabel!
    @IBOutlet weak var notesView: UITextView!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: EventDetailViewControllerDelegate?
    let eventsDatabase = EventDatabase()
    var event: Event?

    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Settings.sharedService.lighterColor;
        UINavigationBar.appearance().barTintColor = UIColor(red: 181/255.0, green: 198/255.0, blue: 255/255.0, alpha: 1.0)
        displayEventData()
        setButtonColors()
    }
    
    // MARK: - Methods
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func displayEventData() {
        guard let titleText = event?.eventTitle else { return }
        titleLabel.text = titleText
        
        guard let dateText = event?.dateOfEventString else { return }
        dateLabel.text = dateText
        
        guard let recipient = event?.giftRecipient else { return }
        haveGiftLabel.text = "Do you have a gift for \(recipient)?"
        
        guard let notesText = event?.eventNotes else { return }
        notesView.text = notesText
    }
    
    func getRandomGift() -> URL? {
        let urls = GiftIdeaLinks().urls
        let randomIndex = Int(arc4random_uniform(UInt32(urls.count)))
        let urlString = urls[randomIndex]
        guard let url = URL(string: urlString) else { return URL(string: "")}
        return url
    }
    
    func updateHaveGift(haveGift: Bool) {
        guard let eventToUpdate = event else { return }
        eventToUpdate.haveGift = haveGift
        delegate?.detail(self, didChangeGiftStatus: eventToUpdate)
    }
    
    func setButtonColors() {
        
        let darkerPurpleColor = UIColor(red: 120/255.0, green: 148/255.0, blue: 255/255.0, alpha: 1.0)
        let lighterPurpleColor = UIColor(red: 177/255.0, green: 192/255.0, blue: 253/255.0, alpha: 1.0)
        
        guard let haveGiftValue = event?.haveGift else { return }
        if haveGiftValue == false {
            noButton.backgroundColor = darkerPurpleColor
            noButton.setTitleColor(UIColor.white, for: .normal)
            yesButton.backgroundColor = lighterPurpleColor
            yesButton.setTitleColor(UIColor.black, for: .normal)
        }
        else {
            yesButton.backgroundColor = darkerPurpleColor
            yesButton.setTitleColor(UIColor.white, for: .normal)
            noButton.backgroundColor = lighterPurpleColor
            noButton.setTitleColor(UIColor.black, for: .normal)
        }
    }
    
    // MARK: - Actions
    @IBAction func haveGiftYesButton(_ sender: UIButton) {
        updateHaveGift(haveGift: true)
        setButtonColors()
    }
    
    @IBAction func haveGiftNoButton(_ sender: UIButton) {
        updateHaveGift(haveGift: false)
        setButtonColors()
        showActionSheet()
    }
    
    // MARK: - Action Sheet
    @objc func showActionSheet() {
        
        let actionSheet = UIAlertController(title: "What are you gonna do about it?", message: nil, preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let remindAgain = UIAlertAction(title: "Remind Me Later", style: .default) { action in
            // nothing happens here yet - it basically is another way of saying "cancel"
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
