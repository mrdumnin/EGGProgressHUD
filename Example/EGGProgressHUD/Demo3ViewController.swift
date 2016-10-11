//
//  Demo3ViewController.swift
//  EGGProgressHUD
//
//  Created by Suchon Dumnin on 10/10/2559 BE.
//  Copyright © 2559 CocoaPods. All rights reserved.
//

import UIKit
import EGGProgressHUD

class Demo3ViewController: UIViewController {

    private var i = 0.0
    private var timer: NSTimer!
    private var a: EGGProgressHUD!
    override func viewDidDisappear(animated: Bool) {
        self.timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.a = EGGProgressHUD()
        self.a.type = EGGProgressHUD.ProgressType.ProgressView
        self.a.bgColor = UIColor.groupTableViewBackgroundColor()
        
        self.a.showInView(self.view)
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(
            1.0, target: self, selector: #selector(self.updateProgress),
            userInfo: nil, repeats: true)
        self.timer.fire()
    }

    func updateProgress() {
        
        i = i + 0.1
        print(i)
        if i > 1.0 {
            self.a.setProgress(Float(self.i))
            i = 0.1
        } else {
            self.a.setProgress(Float(self.i))
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
