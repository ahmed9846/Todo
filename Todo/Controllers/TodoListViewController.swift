//
//  ViewController.swift
//  Todo
//
//  Created by Ahmed on 6/24/19.
//  Copyright © 2019 Ahmed sobhi. All rights reserved.
//

import UIKit

class TodoViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
        
        loadItems()
        
    }

   //MARK - tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none


        return cell
    }
    
    
    //MARK - TableView Delegate Methods
    
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    itemArray[indexPath.row].done = !itemArray[indexPath.row].done
    
    self.saveItems()
    
    tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    //MARK Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            // what will happen once the user clicks the add item on the alert
            
            let newItem = Item()
            newItem.title = textField.text!
            
           self.itemArray.append(newItem)
            
            self.saveItems()
         }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
   }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    //MARK - Model Manupulating Methods
    
    func saveItems() {
        
        let encoder = PropertyListEncoder()
        
        do {
            
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error \(error)")
        }
        
        self.tableView.reloadData()
        }
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error decoding \(error)")
            }
        }
    }
    

}

