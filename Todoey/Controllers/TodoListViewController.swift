//
//  ViewController.swift
//  Todoey
//
//  Created by Kumoyo Mukunyandela on 25.09.18.
//  Copyright © 2018 tusso. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let item1 = Item("Call Zani", false)
    let item2 = Item("Call Mum", false)
    let item3 = Item("Buy Milk", false)
    let item4 = Item("Write Program", false)
    
    let USER_DEFAULTS_KEY = "TodoListArray"
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemArray.append(item1)
        itemArray.append(item2)
        itemArray.append(item3)
        itemArray.append(item4)
        
        if let items = defaults.array(forKey: USER_DEFAULTS_KEY) as? [Item]{
            itemArray = items
        }
    }
    
    //MARK - Tableview Datasource methods
    //Return number of cells to display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    //Return the select cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row].title
        
//        if itemArray[indexPath.row].done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        cell.accessoryType = itemArray[indexPath.row].done ? .checkmark : .none

        return cell
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Item is: ", itemArray[indexPath.row])
        
        if itemArray[indexPath.row].done == false {
           itemArray[indexPath.row].done = true
        }else {
            itemArray[indexPath.row].done = false
        }
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//                    tableView.cellForRow(at: indexPath)?.accessoryType = .none
//                    }else{
//                        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//                    }

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add New Items

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        var textField = UITextField()
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when user clicks the Add Item button on our UIAlert
            let newItem = Item(textField.text!, false)
            self.updateTodoList(newItem)
            
            self.updateDefaults()
            
            self.tableView.reloadData()
            
            print(self.itemArray)
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField //Create reference to alertTextField
        }
        
        
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Utility methods
    func updateTodoList(_ item : Item){
        itemArray.append(item)
    }
    
    func updateDefaults() {
        defaults.set(itemArray, forKey: USER_DEFAULTS_KEY)
    }
    
}

