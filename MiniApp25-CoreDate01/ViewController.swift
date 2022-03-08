//
//  ViewController.swift
//  MiniApp25-CoreDate01
//
//  Created by 前田航汰 on 2022/03/07.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!

    @IBAction func didTapCreateButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Store", in: managedContext) else { return }
        let storeObject = NSManagedObject(entity: entity, insertInto: managedContext)

        storeObject.setValue(itemTextField.text, forKey: "item")
        storeObject.setValue(Int(priceTextField.text ?? "0"), forKey: "price")

        do {
            try managedContext.save()
            print("保存しました")
        } catch let error as NSError {
            print("保存時にエラー： \(error), \(error.userInfo)")
        }
    }

    @IBAction func didTapConfirmButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Store")
        do {
            let fetchRequests = try managedContext.fetch(fetchRequest)
            if let results = fetchRequests as? [NSManagedObject] {
                for result in results {
                    if let item = result.value(forKey: "item") as? String, let price = result.value(forKey: "price") as? Int {
                        print("item：\(item), price：\(price)")
                    }
                }
            }
        } catch let error as NSError {
            print("確認時にエラー:\(error), \(error.userInfo)")
        }

    }

}

