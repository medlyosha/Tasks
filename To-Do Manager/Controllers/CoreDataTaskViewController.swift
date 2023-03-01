//
//  CoreDataTaskViewController.swift
//  To-Do Manager
//
//  Created by Lesha Mednikov on 24.02.2023.
//

import UIKit
import CoreData

class CoreDataTaskViewController: UIViewController {
    
    let todo = Tasks()
    
    @IBOutlet weak var CoreDataTaskTableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "New task", message: " ", preferredStyle: .alert)
        alert.addTextField { field in field.placeholder = "Enter new task"}
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        self?.todo.saveTask(toDoSave: text)
                        self?.CoreDataTaskTableView.reloadData()
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todo.fetchTask()
    }
}

extension CoreDataTaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todo.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DCell", for: indexPath)
        let job = todo.tasks[indexPath.row]
        cell.textLabel?.text = job.value(forKey: "toDo") as? String
        return cell
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todo.deleteTask(ip: indexPath.row)
        }
        self.CoreDataTaskTableView.reloadData()
    }
}
