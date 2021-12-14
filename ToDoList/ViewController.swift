//
//  ViewController.swift
//  ToDoList
//
//  Created by administrator on 13/12/2021.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDoItems: [ToDoItem] = [ToDoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchAllItem()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoItemTableViewCell
        cell.editButton.tag = indexPath.row
        let item = toDoItems[indexPath.row]
        
        cell.toDoTitle.text = item.title
        cell.toDoNote.text = item.note
        cell.toDoDate.text = item.date?.formatted()
        
        if item.checkMark {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddNewItem", sender: sender)
    }
    
    @IBAction func editButtonClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "EditItem", sender: sender.tag)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let saveItemViewController = segue.destination as! SaveItemViewController
        if segue.identifier == "AddNewItem" {
            saveItemViewController.addDelegate = self
            saveItemViewController.mode = .adding
        }else if segue.identifier == "EditItem" {
            saveItemViewController.editDelegate = self
            saveItemViewController.getToDoItem = self
            saveItemViewController.mode = .editing
            saveItemViewController.index = sender as? Int
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = toDoItems[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        
        item.checkMark = !item.checkMark
        saveChangesOfContext()
        if item.checkMark {
            cell?.accessoryType = .checkmark
        }else{
            cell?.accessoryType = .none
        }
    }
    
    // DELETE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let item = toDoItems[indexPath.row]
            managedObjectContext.delete(item)
            if saveChangesOfContext() {
                toDoItems.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
    //READ or Fetch
    private func fetchAllItem() {
        let itemsRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDoItem")
        
        do {
            let result = try managedObjectContext.fetch(itemsRequest)
            toDoItems = result as! [ToDoItem]
            print("Fetched")
            tableView.reloadData()
        } catch {
            print("Fetch Error - \(error.localizedDescription)")
        }
    }
    
    private func saveChangesOfContext() -> Bool {
        var hasSaved = false
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Saved")
                hasSaved = true
            } catch {
                print("Saved Error - \(error.localizedDescription)")
            }
        }
        return hasSaved
    }
    
}

extension ViewController: AddNewItemDelegate, UpdateItemDelegate, GetToDoItem{
    
    // CREATE
    func addNewItem(title: String, note: String, date: Date) {
        let newItem = ToDoItem(context: managedObjectContext)
        newItem.title = title
        newItem.note = note
        newItem.date = date
        newItem.checkMark = false
        if saveChangesOfContext() {
            toDoItems.append(newItem)
        }
        tableView.reloadData()
    }
    
    // UPDATE
    func updateItem(title: String, note: String, date: Date, index: Int){
        let item = toDoItems[index]
        item.title = title
        item.note = note
        item.date = date
        item.checkMark = false
        if saveChangesOfContext() {
            fetchAllItem()
        }
    }
    
    func getToDoItem(at index: Int) -> ToDoItem {
        return toDoItems[index]
    }
}
