//
//  MealInventoryViewController.swift
//  meal-tracking-swift
//
//  Created by Hy-tsoung Chang on 15/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

import UIKit

protocol MealInventoryDelegate {
    func userDidSelectMeal(meal:String);
}

class MealInventoryViewController: UITableViewController {
    
    var mealArray:[String]!
    var delegate:MealInventoryDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.mealArray = MealDatabase.sharedInstance.getMeals()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "mealCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.mealArray.count;
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mealCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.mealArray[indexPath.row]

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.sendData()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func sendData() {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if (indexPath.row < self.mealArray.count) {
                let selectedMeal = self.mealArray[indexPath.row]
                self.delegate?.userDidSelectMeal(selectedMeal)
            }
        }
    }
    
}
