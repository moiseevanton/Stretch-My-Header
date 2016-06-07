//
//  MasterViewController.swift
//  Stretch My Header
//
//  Created by Anton Moiseev on 2016-06-07.
//  Copyright © 2016 Anton Moiseev. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var customHeaderView: UIView!
    
    var detailViewController: DetailViewController? = nil
    var objects = [NewsItem?]()
    var kTableHeaderheight: CGFloat = 0.0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(MasterViewController.insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        // hide navigation bar
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // set up our custom header view
        kTableHeaderheight = customHeaderView.frame.size.height
        tableView.tableHeaderView = nil
        tableView.addSubview(customHeaderView)
        tableView.contentOffset = CGPointMake(0, -kTableHeaderheight)
        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderheight, 0, 0, 0)
        updateHeaderView()
        
        // set up date
        setUpDateLabel()
        
        // populate my objects array
        objects = [NewsItem(category: .World, headline: "Climate change protests, divestments meet fossil fuels realities"),
                   NewsItem(category: .Europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime"),
                   NewsItem(category: .MiddleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
                   NewsItem(category: .Africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
                   NewsItem(category: .AsiaPacific, headline: "Despite UN ruling, Japan seeks backing for whale hunting"),
                   NewsItem(category: .Americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
                   NewsItem(category: .World, headline: "South Africa in $40 billion deal for Russian nuclear reactors"),
                   NewsItem(category: .Europe, headline: "One million babies' created by EU student exchanges")]
    }
    
    func updateHeaderView() {
        if (tableView.contentOffset.y < -kTableHeaderheight) {
            customHeaderView.frame = CGRectMake(0, tableView.contentOffset.y, tableView.bounds.size.width, kTableHeaderheight + (-kTableHeaderheight - tableView.contentOffset.y))
        } else {
            customHeaderView.frame = CGRectMake(0, -kTableHeaderheight, tableView.bounds.size.width, kTableHeaderheight)
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func setUpDateLabel() {
        let date: NSDate = NSDate()
        let dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        let dateInFormat: String = dateFormatter.stringFromDate(date)
        dateLabel.text = dateInFormat
    }
    
    struct NewsItem {
        let category: Category
        let headline: String
        
        enum Category {
            
            case World
            case Americas
            case Europe
            case MiddleEast
            case Africa
            case AsiaPacific
            
            func catToColor() -> UIColor {
                switch self {
                case .World:
                    return UIColor.redColor()
                case .Americas:
                    return UIColor.blueColor()
                case .Europe:
                    return UIColor.greenColor()
                case .MiddleEast:
                    return UIColor.yellowColor()
                case .Africa:
                    return UIColor.orangeColor()
                case .AsiaPacific:
                    return UIColor.purpleColor()
                }
            }
            
            func catToString() -> String {
                switch self {
                case .World:
                    return "World"
                case .Americas:
                    return "Americas"
                case .Europe:
                    return "Europe"
                case .MiddleEast:
                    return "Middle East"
                case .Africa:
                    return "Africa"
                case .AsiaPacific:
                    return "Asia Pacific"
                }
            }
        }
    }
    
    
    // hide status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func insertNewObject(sender: AnyObject) {
        objects.insert(nil, atIndex: 0)
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = segue.destinationViewController as! DetailViewController
//                controller.detailItem = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as! CustomCell
        let item = objects[indexPath.row]
        cell.categoryLabel.text = item?.category.catToString()
        cell.categoryLabel.textColor = item?.category.catToColor()
        cell.headlineLabel.text = item?.headline
        return cell
        
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            objects.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    
}

