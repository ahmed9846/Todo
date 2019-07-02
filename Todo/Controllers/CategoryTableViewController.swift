//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by Ahmed on 6/29/19.
//  Copyright © 2019 Ahmed sobhi. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {

    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
        
    }
    
   //MARK: - TableView datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
       // let category = categories[indexPath.row]
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "no categories added yet"
        
        return cell
    }
    
    //MARK: - TableView delegate methods

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destanationVC = segue.destination as! TodoViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
           destanationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    
   //MARK: - TableView Data manipulation methods
    
    func save(category: Category) {
        
        
        do {
            
            try realm.write {
                realm.add(category)
            }
            
        } catch {
            print("error saving category \(error)")
        }
        
         tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        tableView.reloadData()
        
    }
    
    
   //MARK: - Add new categories

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a newcategory"
            
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    

    
    
    
}
