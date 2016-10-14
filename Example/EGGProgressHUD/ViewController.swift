//
//  ViewController.swift
//  EGGProgressHUD
//
//  Created by Suchon Dumnin on 10/06/2016.
//  Copyright (c) 2016 Suchon Dumnin. All rights reserved.
//

import UIKit
import EGGProgressHUD

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var datasource: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupDatasource()
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupDatasource() {
        self.datasource = NSMutableArray()
        self.datasource.addObject("Progress without BG")
        self.datasource.addObject("Progress with BG")
        self.datasource.addObject("Progress view")
        self.datasource.addObject("Progress image")
    }
}

// MARK: - UITableView UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") {
            let text = self.datasource[indexPath.row] as! String
            cell.textLabel?.text = text
            return cell
        } else {
            return UITableViewCell()
        }
    }
}

// MARK: - UITableView UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let text = self.datasource[indexPath.row] as! String
        let storyboardName = "Main"
        
        if indexPath.row == 0 {
            let vc = UIStoryboard.getViewController(storyboardName, viewControllerId: "Demo1ViewController") as! Demo1ViewController
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 1 {
            let vc = UIStoryboard.getViewController(storyboardName, viewControllerId: "Demo2ViewController") as! Demo2ViewController
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 2 {
            let vc = UIStoryboard.getViewController(storyboardName, viewControllerId: "Demo3ViewController") as! Demo3ViewController
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
        } else if indexPath.row == 3 {
            let vc = UIStoryboard.getViewController(storyboardName, viewControllerId: "Demo4ViewController") as! Demo4ViewController
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

