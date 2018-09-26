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
    func addEventViewController(_ controller: AddEventViewController, didFinishEditing item: Event)
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
        let saveBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doesNothing))
        navigationItem.rightBarButtonItem = saveBarButtonItem
    }
    
    //delete this after adding real save functionality
    @objc
    func doesNothing(){
        
    }
    
    // MARK: - Actions
}
