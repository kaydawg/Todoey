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
    
    let USER_DEFAULTS_KEY = "TodoListArray"
    
    //let defaults = UserDefaults.standard
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadItems()
        
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
        
        saveItems()

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
            
            self.saveItems()
            
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
    
    func saveItems() {
        //defaults.set(itemArray, forKey: USER_DEFAULTS_KEY)
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Encoding error:  \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadItems(){
        
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                
            }

            
        }
    }
    
}

