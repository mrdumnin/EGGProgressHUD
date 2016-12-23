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
    fileprivate var datasource: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.setupDatasource()
        self.tableView.reloadData()
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setupDatasource() {
        self.datasource = NSMutableArray()
        self.datasource.add("Progress without BG")
        self.datasource.add("Progress with BG")
        self.datasource.add("Progress view")
        self.datasource.add("Progress image")
    }
}

// MARK: - UITableView UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
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

