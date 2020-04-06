//
//  PairListTableViewController.swift
//  Week6Assessment
//
//  Created by Jon Corn on 2/14/20.
//  Copyright © 2020 Jon Corn. All rights reserved.
// ⠄⢀⣀⣤⣴⣶⣶⣤⣄⡀⠄⠄⣀⣤⣤⣤⣤⡀⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
// ⣴⣏⣹⣿⠿⠿⠿⠿⢿⣿⣄⢿⣿⣿⣿⣿⣿⣋⣷⡄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄
// ⣿⢟⣩⣶⣾⣿⣿⣿⣶⣮⣭⡂⢛⣭⣭⣭⣭⣭⣍⣛⣂⡀⠄⠄⠄⠄⠄⠄⠄⠄
// ⣿⣿⣿⣿⡿⢟⣫⣭⣷⣶⣾⣭⣼⡻⢛⣛⣭⣭⣶⣶⣬⣭⣅⡀⠄⠄⠄⠄⠄⠄
// ⣿⡿⢏⣵⣾⣿⣿⣿⡿⢉⡉⠙⢿⣇⢻⣿⣿⣿⣿⡟⠉⠉⢻⡷⠄⠄⠄⠄⠄⠄
// ⣿⣷⣾⣍⣛⢿⣿⣿⣿⣤⣁⣤⣿⢏⠸⣿⣿⣿⣿⣷⣬⣥⣾⠁⣿⣿⣷⠄⠄⠄
// ⣿⣿⣿⣿⣭⣕⣒⠿⠭⠭⠭⡷⢖⣫⣶⣶⣬⣭⣭⣭⣭⣥⡶⢣⣿⣿⣿⠄⠄⠄
// ⣿⣿⣿⣿⣿⣿⣿⡿⣟⣛⣭⣾⣿⣿⣿⣝⡛⣿⢟⣛⣛⣁⣀⣸⣿⣿⣿⣀⣀⣀
// ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
// ⣿⡿⢛⣛⣛⣛⣙⣛⠿⠿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣭⣭⠽⣛⢻⣿⣿⣿⠛⠛⠛
// ⣿⢰⣿⣿⣿⣿⣟⣛⣛⣶⠶⠶⠶⣦⣭⣭⣭⣭⣶⡶⠶⣾⠟⢸⣿⣿⣿⠄⠄⠄
// ⡻⢮⣭⣭⣭⣭⣉⣛⣛⡻⠿⠿⠷⠶⠶⠶⠶⣶⣶⣾⣿⠟⢣⣬⣛⡻⢱⣇⠄⠄
// ⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⠶⠒⠄⠄⠄⢸⣿⢟⣫⡥⡆⠄⠄
// ⢭⣭⣝⣛⣛⣛⣛⣛⣛⣛⣿⣿⡿⢛⣋⡉⠁⠄⠄⠄⠄⠄⢸⣿⢸⣿⣧⡅⠄⠄
// ⣶⣶⣶⣭⣭⣭⣭⣭⣭⣵⣶⣶⣶⣿⣿⣿⣦⡀⠄⠄⠄⠄⠈⠡⣿⣿⡯⠁⠄⠄


import UIKit

class PairListTableViewController: UITableViewController {
  
  // MARK: - Properties
  
  var count = 0
  
  // usefull for deleting
  var personDictionary = [IndexPath: Person]()
  
  // MARK: - View Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    updateViews()
    self.title = "Pair"
  }
  
  // MARK: - Actions
  @IBAction func AddButtonTapped(_ sender: UIBarButtonItem) {
    addPersonAlertController()
  }
  
  @IBAction func randomizeButtonTapped(_ sender: UIButton) {
    PersonController.shared.people.shuffle()
    self.count = 0
    updateViews()
  }
  
  // MARK: - Table view data source
  override func numberOfSections(in tableView: UITableView) -> Int {
    // first thought that returning the count of the array/2 would be enough, but it didn't account for an odd number in the list
    //  this adds that extra section for the single person object in an odd count
    let peopleArray = PersonController.shared.people
    if peopleArray.count % 2 == 0 {
      return peopleArray.count / 2
    } else {
      return peopleArray.count / 2 + 1
    }
    //        return PersonController.shared.people.count / 2
    
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Group \(section + 1)"
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    let sections = tableView.numberOfSections
    
    let people = PersonController.shared.people
    
    // Add section for every two people placed in people array
    if people.count % 2 == 0 {
      return 2
    } else {
      // If the section is at the same location as the last section, only return one row
      if section == sections - 1 {
        return 1
      } else {
        return 2
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
    
    // instead of the indexpath.row, i'm using the count i created above. when you add a new person, the value of count changes
    let person = PersonController.shared.people[count]
    cell.textLabel?.text = person.name
    
    personDictionary[indexPath] = person
    count += 1
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // get person
      guard let person = personDictionary[indexPath] else { return }
      // delete person
      PersonController.shared.delete(person: person)
      // set count to zero before updating views
      count = 0
      updateViews()
      
//      let personToDelete = PersonController.shared.people[indexPath.row]
//      PersonController.shared.delete(person: personToDelete)
//      tableView.deleteRows(at: [indexPath], with: .fade)
      // crash here due to rows being "cloned" into each group, so when a row gets deleted, the other "clones" don't, causing a crash?
      // If this is the case, maybe using a dictionary in some way could allow the app to find the proper index of the person object delete.
      // example: [Group 1 : ["Person1", "Person3"]] and delete person1 of group 1.. maybe idk lmao
    }
  }
  
  // MARK: - Helper Methods
  func updateViews() {
    self.tableView.reloadData()
  }
  
  func addPersonAlertController() {
    let alert = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .alert)
    alert.addTextField { (textField) in
      textField.placeholder = "Full Name"
    }
    let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
      guard let personName = alert.textFields?[0].text, personName != "" else { return }
      PersonController.shared.create(personWithName: personName)
      self.count = 0
      self.updateViews()
    }
    alert.addAction(cancelButton)
    alert.addAction(addButton)
    self.present(alert, animated: true)
  }
  
} // class end
