//
//  Demo4ViewController.swift
//  EGGProgressHUD
//
//  Created by Suchon Dumnin on 10/14/2559 BE.
//  Copyright © 2559 CocoaPods. All rights reserved.
//

import UIKit
import EGGProgressHUD

class Demo4ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let a = EGGProgressHUD()
        a.type = EGGProgressHUD.ProgressType.ProgressImage
        //a.loadingImage = UIImage(named: "Chicken Filled-80")
        //a.loadingImage = UIImage(named: "Hourglass Filled-80")
        a.loadingImage = UIImage(named: "Pig Filled-80")
        a.showInView(self.view)
        
        let triggerTime = (Int64(NSEC_PER_SEC) * 5) //5 Sec
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue()) {
            //a.hide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
