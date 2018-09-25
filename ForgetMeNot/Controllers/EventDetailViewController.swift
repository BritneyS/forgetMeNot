//
//  EventDetailViewController.swift
//  ForgetMeNot
//
//  Created by DetroitLabs on 9/25/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

class EventDetailViewController: UITableViewController {

    // MARK: - Properties
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var haveGiftLabel: UILabel!
    @IBOutlet weak var notesView: UITextView!
    
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Methods
    
    // MARK: - Actions
    
    @IBAction func haveGiftYesButton(_ sender: UIButton) {
    }
    
    @IBAction func haveGiftNoButton(_ sender: UIButton) {
    }
    
}
