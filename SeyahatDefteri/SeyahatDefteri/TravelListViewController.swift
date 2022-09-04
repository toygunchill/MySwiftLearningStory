//
//  TravelListViewController.swift
//  SeyahatDefteri
//
//  Created by Toygun Çil on 4.09.2022.
//

import UIKit
import CoreData

class TravelListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var titleArr : [String?] = []
    var idArr : [UUID?] = []
    var choosenTitle : String? = ""
    var choosenTitleID : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newPlace"), object: nil)
    }
    
    @objc func addButtonClicked() {
        choosenTitle = ""
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            navigationController?.pushViewController(mapVC, animated: true)
        }
    }
    
    @objc func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                
                self.titleArr.removeAll(keepingCapacity: false)
                self.idArr.removeAll(keepingCapacity: false)
                
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArr.append(title)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArr.append(id)
                    }
                    tableView.reloadData()
                }
            }
        } catch {
            
        }
    }
}

extension TravelListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = titleArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choosenTitle = titleArr[indexPath.row]
        choosenTitleID = idArr[indexPath.row]
        if let mapVC = storyboard?.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            navigationController?.pushViewController(mapVC, animated: true)
            mapVC.selectedTitle = choosenTitle
            mapVC.selectedTitleID = choosenTitleID
        }
    }
}

extension TravelListViewController: UITableViewDelegate {
    
}
