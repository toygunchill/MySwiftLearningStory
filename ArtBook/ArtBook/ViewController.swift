//
//  ViewController.swift
//  ArtBook
//
//  Created by Toygun Çil on 3.09.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var nameArr : [String?] = []
    var idArr : [UUID?] = []
    var selectedPainting : String? = ""
    var selectedPaintingID : UUID?
    @IBOutlet weak var tableView: UITableView! {
        didSet{
            self.tableView.dataSource = self
            self.tableView.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name("newData"), object: nil)
    }
    
    @objc func addButtonClicked() {
        selectedPainting = ""
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    @objc func getData() {
        nameArr.removeAll(keepingCapacity: false)
        idArr.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = true
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        self.nameArr.append(name)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArr.append(id)
                    }
                    self.tableView.reloadData()
                }
            }
        } catch {
            print("error fetch")
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = nameArr[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = nameArr[indexPath.row]
        selectedPaintingID = idArr[indexPath.row]
        if let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            self.navigationController?.pushViewController(detailVC, animated: true)
            detailVC.choosenPainting = selectedPainting
            detailVC.choosenPaintingID = selectedPaintingID
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            if let idString = idArr[indexPath.row]?.uuidString {
                fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            }
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArr[indexPath.row] {
                                context.delete(result)
                                nameArr.remove(at: indexPath.row)
                                idArr.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                do {
                                    try context.save()
                                } catch {
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("error")
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    
}

