//
//  HomeViewController.swift
//  ForgetMeNot
//
//  Created by Elle Gover on 9/24/18.
//  Copyright © 2018 com.detroitlabs. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - Properties
    var events = ["Anniversary, Sept. 27", "LabsCon, Sept. 28"]
    var eventList: [Event] = []
    var selectedEventIndex = 0
    
    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate()
        
        }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = events[indexPath.row]
        
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.addEventSegueIdentifier.rawValue {
            guard let addEventViewController = segue.destination as? AddEventViewController else { return }
            addEventViewController.delegate = self
        } else if segue.identifier == SegueIdentifier.eventDetailSegueIdentifier.rawValue {
            guard let eventDetailViewController = segue.destination as? eventDetailViewController else { return }
            eventDetailViewController.eventData = eventList[selectedEventIndex]
    }
    }
    

    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        let formattedToday = dateFormatter.date(from: todayString)
        
        return dateFormatter.string(from: formattedToday!)
    }
    
    func setDate() {
        
        dateLabel.text = "Today is \(formattedDate())"
    }
    

}
