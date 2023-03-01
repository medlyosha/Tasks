//
//  CoreDataTaskModel.swift
//  To-Do Manager
//
//  Created by Lesha Mednikov on 24.02.2023.
//

import UIKit
import CoreData

class Tasks {
     var tasks = [NSManagedObject]()

    func saveTask(toDoSave: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let entity =  NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        let toDo = NSManagedObject(entity: entity, insertInto: context)
        toDo.setValue(toDoSave, forKey: "toDo")
        do {
            try context.save()
            tasks.append(toDo)
        } catch {
        }
    }
    func fetchTask(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        do {
            let result = try context.fetch(fetchRequest)
            tasks = result as! [NSManagedObject]
        } catch {
        }
    }
    func deleteTask(ip: Int){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
            do {
                context.delete(tasks[ip])
                tasks.remove(at: ip)
                try context.save()
            } catch {
            }
        }
}
