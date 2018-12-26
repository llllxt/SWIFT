//
//  ViewController.swift
//  TODO
//
//  Created by Li, Xintong on 26/12/18.
//  Copyright © 2018 Li, Xintong. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let defaulte = UserDefaults.standard


    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "添加一个新的todo项目", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "添加项目", style: .default, handler: {(action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
            self.defaulte.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        })
        alert.addTextField(configurationHandler: {(alertTextField) in
            alertTextField.placeholder = "创建一个新项目..."
            print(alertTextField.text!)
            textField = alertTextField
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let newItem = Item()
        newItem.title = "购买水杯"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "吃药"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "修改密码"
        itemArray.append(newItem3)
        
        if let items = defaulte.array(forKey: "ToDoListArray") as? [Item]{
            itemArray = items
        }
    }
    
    //table view data source methods
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].title
        if itemArray[indexPath.row].done == false{
            cell.accessoryType = .none
        }else{
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        if itemArray[indexPath.row].done == false{
            itemArray[indexPath.row].done = true
        }else{
            itemArray[indexPath.row].done = false
        }
       
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
        tableView.endUpdates()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }


}

