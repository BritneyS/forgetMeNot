//
//  AddEventViewController.swift
//  ForgetMeNot
//
//  Created by DetroitLabs on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

//MARK: - Protocol Definitions

protocol AddEventViewControllerDelegate: class {
    func addEventViewControllerDidCancel(_ controller: AddEventViewController)
    func addEventViewController(_ controller: AddEventViewController, didFinishAdding item: Event)
}

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

class AddEventViewController: UITableViewController {

    // MARK: - Outlets
    
    /// Labels:
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipientLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var haveGiftLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    /// UI Input Elements:
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var recipientField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var haveGiftSwitch: UISwitch!
    @IBOutlet weak var notesTextView: UITextView!
    
    
    // MARK: - Properties
    
    var event: Event?
    weak var delegate: AddEventViewControllerDelegate?
    

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        titleField.becomeFirstResponder()
        super.viewDidLoad()
        renderSaveBarButton()
    }

    // MARK: - Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func renderSaveBarButton() {
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    
    @objc
    func save(){
        
        let dateString = datePicker.date.toString(dateFormat: "MM/dd/yyyy")
        
        let event = Event(eventTitle: titleField.text!, giftRecipient: recipientField.text!, dateOfEventString: dateString, haveGift: haveGiftSwitch.isOn, eventNotes: notesTextView.text!)
                delegate?.addEventViewController(self, didFinishAdding: event)
        
    }
    
    
    
    // MARK: - Actions
    
    
    
    //These will be button functions once connected
    // MARK: @IBActions
    
    
    @IBAction func cancel() {
        delegate?.addEventViewControllerDidCancel(self)
    }
    
    
    
    
    
}



