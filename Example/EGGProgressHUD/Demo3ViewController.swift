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

    fileprivate var i = 0.0
    fileprivate var timer: Timer!
    fileprivate var a: EGGProgressHUD!
    override func viewDidDisappear(_ animated: Bool) {
        self.timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.a = EGGProgressHUD()
        self.a.type = EGGProgressHUD.ProgressType.progressView
        self.a.bgColor = UIColor.gray
        self.a.loadingTextColor = UIColor.white
        self.a.showInView(self.view)
        
        self.timer = Timer.scheduledTimer(
            timeInterval: 1.0, target: self, selector: #selector(self.updateProgress),
            userInfo: nil, repeats: true)
        self.timer.fire()
    }

    func updateProgress() {
        
        i = i + 0.1

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
