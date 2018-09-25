//
//  AddEventViewController.swift
//  ForgetMeNot
//
//  Created by DetroitLabs on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

//MARK: - Protocol Definition

protocol AddEventViewControllerDelegate: class {
    func addEventViewControllerDidCancel(_ controller: AddEventViewController)
    func addEventViewController(_ controller: AddEventViewController, didFinishEditing item: Event)
}

class AddEventViewController: UITableViewController {

    // MARK: - Properties
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
    
    
    var event: Event?
    weak var delegate: AddEventViewControllerDelegate?
    
    // MARK: - Outlets
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        titleField.becomeFirstResponder()
        super.viewDidLoad()
    }

    // MARK: - Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Actions
}
