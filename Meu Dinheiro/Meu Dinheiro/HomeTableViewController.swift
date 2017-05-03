//
//  HomeTableViewController.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 30/04/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        //feedDatabase(in: context)
        initializeFetchedResultsController()
        setupHeader()
        
        tableView.tableFooterView = UIView()
    }
    
    func initializeFetchedResultsController() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        let sort = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sort]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to initialize FetchedResultsController: \(error)")
        }
    }
    
    private func setupHeader() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let dateFormatter: DateFormatter = DateFormatter()
        let months = dateFormatter.monthSymbols!
        let month = months[currentMonth - 1]
        
        self.navigationItem.title = month.capitalized(with: Locale.current)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(HomeTableViewController.addCategory))
    }
    
    func addCategory() {
        print("will add category")
    }
    
    private func feedDatabase(in context: NSManagedObjectContext) {
        let newCategory = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! CategoryMO
        
        newCategory.icon = "invoice"
        newCategory.month = 5
        newCategory.title = "Contas"
        newCategory.reservedValue = 250.0
        //newCategory.spentValue = 0
        newCategory.status = CategoryStatus.Good.rawValue
        newCategory.year = 2017
        
        let newCategory2 = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! CategoryMO
        
        newCategory2.icon = "cart"
        newCategory2.month = 5
        newCategory2.title = "Mercado"
        //newCategory2.reservedValue = 450.0
        //newCategory2.spentValue = 160
        newCategory2.status = CategoryStatus.None.rawValue
        newCategory2.year = 2017
        
        let newCategory3 = NSEntityDescription.insertNewObject(forEntityName: "Category", into: context) as! CategoryMO
        
        newCategory3.icon = "hobby"
        newCategory3.month = 5
        newCategory3.title = "Lazer"
        newCategory3.reservedValue = 150.0
        //newCategory3.spentValue = 160
        newCategory3.status = CategoryStatus.Good.rawValue
        newCategory3.year = 2017

        do {
            try context.save()

            print("All objects saved.")
        } catch {
            print("Something is wrong =(")
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = fetchedResultsController.sections {
            return sections[section].numberOfObjects
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell

        let object = fetchedResultsController?.object(at: indexPath) as! CategoryMO

        cell.title.text = object.title
        cell.totalAmount.text = "R$ \(String(describing: object.total()))"
        
        if let icon = object.icon {
            cell.icon.image = UIImage(named: icon)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let theCell = cell as! CategoryTableViewCell
        
        if let theObject = fetchedResultsController.object(at: indexPath) as? CategoryMO {
            theCell.totalAmount.textColor =  CategoryStatus(rawValue: theObject.status)!.color()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = fetchedResultsController.object(at: indexPath) as! CategoryMO
        
        performSegue(withIdentifier: "ShowCategoryDetails", sender: category)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch (segue.identifier!)
        {
        case "ShowCategoryDetails":
            if let destinationVC = segue.destination as? CategoryDetailViewController {
                destinationVC.category = sender as! CategoryMO
            }
        default: break
        }
    }
}
