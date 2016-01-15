//
//  ViewController.swift
//  meal-tracking-swift
//
//  Created by Hy-tsoung Chang on 13/01/2016.
//  Copyright © 2016 Hy-tsoung Chang. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var today:NSDate!
    
    @IBOutlet
    var tableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        today = NSDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        let date = NSDate(timeInterval:Double(60*60*24*(indexPath.row)), sinceDate:self.today)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.stringFromDate(date)
        
        cell.textLabel?.text = stringDate
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath:NSIndexPath) {
        let dayRecord = UIStoryboard(name: "Main", bundle:nil).instantiateViewControllerWithIdentifier("dayRecordID") as! DayRecordViewController
        
        let date = NSDate(timeInterval:Double(60*60*24*(indexPath.row)), sinceDate:self.today)
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let stringDate = formatter.stringFromDate(date)

        dayRecord.dayString = stringDate
        self.navigationController?.pushViewController(dayRecord, animated: true)
    }
}

