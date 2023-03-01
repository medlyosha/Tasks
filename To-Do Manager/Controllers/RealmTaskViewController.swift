//
//  RealmTaskViewController.swift
//  To-Do Manager
//
//  Created by Lesha Mednikov on 24.02.2023.
//

import UIKit
import RealmSwift

class RealmTaskViewController: UIViewController {
    
    var tasks = [ToDoList]()
    private let realm = try! Realm()

    @IBOutlet weak var realmTaskTableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "New task", message: " ", preferredStyle: .alert)
             alert.addTextField { field in field.placeholder = "Enter new task"}
             alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (_) in
                 if let field = alert.textFields?.first {
                     if let text = field.text, !text.isEmpty {
                         DispatchQueue.main.async {
                             try! self?.realm.write {
                             let newTask = ToDoList()
                             newTask.toDo = text
                                 self?.realm.add(newTask)
                                 self?.tasks.append(newTask)
                                 self?.realmTaskTableView.reloadData()
                                 print(text)
                             }
                         }
                     }
                 }
             }))
             present(alert, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = realm.objects(ToDoList.self).map( { $0 })
    }
}

extension RealmTaskViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].toDo
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            try! realm.write {
                realm.delete(tasks[indexPath.row])
                tasks.remove(at: indexPath.row)
            }
        }
        self.realmTaskTableView.reloadData()
    }
}
