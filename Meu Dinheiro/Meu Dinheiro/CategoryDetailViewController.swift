//
//  CategoryDetailViewController.swift
//  Meu Dinheiro
//
//  Created by Caio Colaiacovo on 02/05/17.
//  Copyright © 2017 Caio Colaiacovo. All rights reserved.
//

import UIKit

class CategoryDetailViewController: UIViewController {

    var category: CategoryMO!
    @IBOutlet weak var reservedValue: UILabel!
    @IBOutlet weak var spentValue: UILabel!
    @IBOutlet weak var totalValue: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var buttonItem = UIBarButtonItem(image: UIImage(named: "chart"), style: .plain, target: self, action: #selector(CategoryDetailViewController.openChart))
        
        self.navigationItem.rightBarButtonItem = buttonItem
        self.navigationItem.title = category.title
        
        //progressView.progress = NSDecimalNumber(decimal: category.spentPercentage()).floatValue
        progressView.progress = 0.4
        progressView.progressTintColor = UIColor(red:0.25, green:0.71, blue:0.08, alpha:1.0)
        reservedValue.text = category.reservedValue == nil ? "R$ 0,00" : "R$ \(String(describing: category.reservedValue!))"
        spentValue.text = category.spentValue == 0 ? "R$ 0,00" : "R$ \(String(describing: category.spentValue))"
        
        totalValue.text = "R$ \(String(describing: category.total()))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openChart() {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
