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
    
    var events: [Event] = []
    var selectedEventIndex = 0

    
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentDate()
        populateData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
        cell.textLabel?.text = getTimeIntervalString(event: events[indexPath.row])
        
        return cell
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifier.addEventSegueIdentifier.rawValue {
            guard let addEventViewController = segue.destination as? AddEventViewController else { return }
            addEventViewController.delegate = self
        } else if segue.identifier == SegueIdentifier.eventDetailSegueIdentifier.rawValue {
            guard let eventDetailViewController = segue.destination as? EventDetailViewController else { return }
            eventDetailViewController.event = events[selectedEventIndex]
    }
    }
    
    
    
    
    

    func populateData() {
        let eventDatabase = EventDatabase()
        for event in eventDatabase.events {
            events.append(event)
        }
    }
    
    func getTimeIntervalString(event: Event) -> String {
        let eventDate = event.dateOfEvent
        let timeIntervalInSeconds = event.countdownToEvent(dateOfEvent: eventDate)
        return "\(event.formatTimeInterval(seconds: timeIntervalInSeconds)) until \(event.eventTitle)"
    }


    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        let formattedToday = dateFormatter.date(from: todayString)
        
        return dateFormatter.string(from: formattedToday!)
    }
    
    func displayCurrentDate() {
        
        dateLabel.text = "Today is \(formattedDate())"
    }
    
//    func saveEvents() {
//        let encoder = PropertyListEncoder()
//        do {
//            let data = try encoder.encode(events)
//
//            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
//        } catch {
//            print("Error encoding item array")
//        }
//    }
    

}




// MARK: Private Implementation

//extension HomeViewController {
//
//
//    func addEventViewControllerDidCancel(_ controller: AddEventViewController) {
//        <#code#>
//    }
//
//    func addEventViewController(_ controller: AddEventViewController, didFinishEditing item: Event) {
//        <#code#>
//    }
//
//
//}













extension HomeViewController: AddEventViewControllerDelegate {

    func addEventViewControllerDidCancel(_ controller: AddEventViewController) {
        //print("Do some stuff")
        navigationController?.popViewController(animated: true)
        }
    
    func addEventViewController(_ controller: AddEventViewController, didFinishAdding item: Event) {
        //print("Do some more stuff")
        let newRowIndex = events.count
        events.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        navigationController?.popViewController(animated: true)
        
        
        //need to create a save function and call that method here
        
        }
    
}


//need to connect labels from add event view
//place the below line (+ the ones for the other labels) in tableview function func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    //cell.dateLabel.text = event.dateOfEventString  *Must check for cell id/name*
