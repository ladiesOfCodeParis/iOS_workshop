//
//  DayRecordViewController.swift
//  meal-tracking-swift
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

import UIKit

class DayRecordViewController: UITableViewController, MealInventoryDelegate {
    
    var dayRecordArray:[String]!
    var dayString:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "mealRecord")
        self.tableView.allowsSelectionDuringEditing = true;
        
        self.loadUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.editing) {
            return self.dayRecordArray.count + 1
        } else {
            return self.dayRecordArray.count
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mealRecord", forIndexPath: indexPath)

        // Configure the cell...
        if (indexPath.row == self.dayRecordArray.count) {
            cell.textLabel?.text = "[add]"
        } else {
            cell.textLabel?.text = self.dayRecordArray[indexPath.row]
        }

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            self.dayRecordArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance, insert it into the array, and add a new row to the table view
            self.dayRecordArray.insert("[new]", atIndex: indexPath.row)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }    
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if (indexPath.row == self.dayRecordArray.count) {
            return UITableViewCellEditingStyle.Insert
        } else {
            return UITableViewCellEditingStyle.Delete
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.tableView.editing) {
            if (indexPath.row == self.dayRecordArray.count) {
                self.dayRecordArray.insert("[new]", atIndex: indexPath.row)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            } else {
                let mealInventory = MealInventoryViewController()
                mealInventory.delegate = self
                self.navigationController?.pushViewController(mealInventory, animated: true)
            }
        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
        if (editing) {
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: self.dayRecordArray.count, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
        } else {
            self.tableView.beginUpdates()
            self.tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: self.dayRecordArray.count, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Left)
            self.tableView.endUpdates()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func userDidSelectMeal(meal: String) {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            if (self.tableView.editing && indexPath.row < self.dayRecordArray.count) {
                self.dayRecordArray[indexPath.row] = meal
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (self.navigationController?.viewControllers.indexOf(self) == nil) {
            self.saveUserData()
        }
        super.viewWillDisappear(animated)
    }
    
    // save/load user data
    func loadUserData() {
        self.dayRecordArray = UserMealRecordDatabase.loadUserMealDataForDay(self.dayString)
    }
    
    func saveUserData() {
        UserMealRecordDatabase.saveUserData(self.dayRecordArray, forDay: self.dayString);
    }
}
