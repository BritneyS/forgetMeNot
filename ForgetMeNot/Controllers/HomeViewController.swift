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
//    let gift = "🎁"
//    let warning = "⚠️"
//    let alarm = "🚨"
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentDate()
        populateData()
        loadEvents()
        
        // shows usually hidden folders
        print("🌸 Document folder is \(documentsDirectory())")
        print("🌸 Data file path is \(dataFilePath())")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
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
//        if events[indexPath.row].haveGift == false {
//            if getTimeIntervalString(event: events[indexPath.row]).contains("1 week") || getTimeIntervalString(event: events[indexPath.row]).contains("days") || getTimeIntervalString(event: events[indexPath.row]).contains("day") {
//                cell.textLabel?.text = "\(alarm)" + getTimeIntervalString(event: events[indexPath.row])
//            } else {
//            cell.textLabel?.text = "\(warning)" + getTimeIntervalString(event: events[indexPath.row])
//            }
//        } else {
//            cell.textLabel?.text = "\(gift)" + getTimeIntervalString(event: events[indexPath.row])
//        }
        let eventText = getTimeIntervalString(event: events[indexPath.row])
        cell.textLabel?.text = eventText
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedEventIndex = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func swipeToDelete(indexPath: IndexPath) {
        events.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            swipeToDelete(indexPath: indexPath)
            saveEvents()
        }
    }
    
    func displayCurrentDate() {
        
        dateLabel.text = "Today is \(formattedDate())"
    }

}



// MARK: Data Persistence
extension HomeViewController {
    
    // accessing Documents folder of app
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    // adding new file to directory
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Events.plist")
    }
    
    func saveEvents() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(events)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array")
        }
    }
    
    func loadEvents() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                events = try decoder.decode([Event].self, from: data)
            } catch {
                print("Error decoding item array!")
            }
        }
    }
}



extension HomeViewController: AddEventViewControllerDelegate {

    func addEventViewControllerDidCancel(_ controller: AddEventViewController) {
        navigationController?.popViewController(animated: true)
        }
    
    func addEventViewController(_ controller: AddEventViewController, didFinishAdding item: Event) {
        let newRowIndex = events.count
        events.append(item)
        print(events)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        saveEvents()
        navigationController?.popViewController(animated: true)

        
        }
    
}



