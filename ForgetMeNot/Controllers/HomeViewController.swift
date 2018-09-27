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
    var fiveSoonestEvents: [Event] = []
    var selectedEventIndex = 0

    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        displayCurrentDate()
        if dataFileExists() { loadEvents() }
        else { populateData() }
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
        cell.textLabel?.text = getTimeIntervalString(event: events[indexPath.row])

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
            if event.dateOfEvent > Date() {
                events.append(event)
            }
        }
        events = sortAndLimitEvents(events: events)
    }

    func sortEvents(array: [Event]) -> [Event] {
        var sortedEvents: [Event] = []
        sortedEvents = array.sorted(by: { $0.dateOfEvent < $1.dateOfEvent } )
        return sortedEvents
    }

    func limitToFiveEvents(array: [Event]) -> [Event] {
        var fiveSoonestEvents: [Event] = []
        if events.count < 5 { return events }
        for event in events[0...4] {
            fiveSoonestEvents.append(event)
        }
        return fiveSoonestEvents
    }
    
    func sortAndLimitEvents(events: [Event]) -> [Event] {
        let sortedEvents = sortEvents(array: events)
        let sortedAndLimited = limitToFiveEvents(array: sortedEvents)
        return sortedAndLimited
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
                events = sortAndLimitEvents(events: events)
            } catch {
                print("Error decoding item array!")
            }
        }
    }
    
    func dataFileExists() -> Bool {
        let fileManager = FileManager()
        let filePath = dataFilePath().path
        
        return fileManager.fileExists(atPath: filePath)
    }
}


extension HomeViewController: AddEventViewControllerDelegate {

    func addEventViewControllerDidCancel(_ controller: AddEventViewController) {
        navigationController?.popViewController(animated: true)
        }

    func addEventViewController(_ controller: AddEventViewController, didFinishAdding item: Event) {
        events.append(item)
        events = sortAndLimitEvents(events: events)
        tableView.reloadData()
        saveEvents()
        navigationController?.popViewController(animated: true)

        //need to create a save function and call that method here if doing persistence

        }

}
