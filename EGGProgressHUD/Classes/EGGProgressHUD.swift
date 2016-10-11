//
//  EGGProgressHUD.swift
//  Pods
//
//  Created by Suchon Dumnin on 10/7/2559 BE.
//
//

import UIKit

public class EGGProgressHUD: NSObject {
    
    private var spinner: UIActivityIndicatorView!
    private var loadingBGView: UIView!
    private var progressView: UIProgressView!
    private var loadingLabel: UILabel!
    
    //MARK: - Property user can set
    public var type: ProgressType!
    public var style: SpinnerStyle!
    public var bgColor: UIColor!
    //public var progress: Float!
    
    public enum ProgressType {
        case ProgressWithoutBG
        case ProgressWithBG
        case ProgressView
    }
    
    public enum SpinnerStyle {
        case White
        case Gray
    }

    //MARK: - Initial
    public override init() {
        super.init()
        
        self.type = ProgressType.ProgressWithoutBG
        self.style = SpinnerStyle.Gray
        self.bgColor = UIColor.blackColor()
        //self.progress = 0.0
    }
    
    public func showInView(view: UIView) {
        
         if self.type == ProgressType.ProgressWithoutBG {
            self.setupProgressWithoutBG()
            
            self.spinner.removeFromSuperview()
            view.addSubview(self.spinner)
            
            self.spinner.startAnimating()
         } else if self.type == ProgressType.ProgressWithBG {
            self.setupProgressWithoutBG()
            self.setupProgressWithBG()
            
            self.loadingBGView.hidden = false
            self.loadingBGView.removeFromSuperview()
            view.addSubview(self.loadingBGView)
         } else if self.type == ProgressType.ProgressView {
            self.setupProgressView()
            
            self.loadingBGView.hidden = false
            self.loadingBGView.removeFromSuperview()
            view.addSubview(self.loadingBGView)
        }
    }
    
    public func hide() {
        if self.type == ProgressType.ProgressWithBG || self.type == ProgressType.ProgressView {
            self.loadingBGView.hidden = true
        } else if self.type == ProgressType.ProgressWithoutBG {
            self.spinner.stopAnimating()
        }
    }
    
    public func setProgress(progress: Float) {
        guard (self.progressView == nil) else {
            dispatch_async(dispatch_get_main_queue()) {
                self.progressView.setProgress(progress, animated: true)
            }
            return
        }
    }
    
    private func setupProgressWithoutBG() {
        self.spinner = UIActivityIndicatorView()
        if self.style == SpinnerStyle.White {
            self.spinner.activityIndicatorViewStyle = .WhiteLarge
        } else {
            self.spinner.activityIndicatorViewStyle = .Gray
        }
        
        self.spinner.hidesWhenStopped = true
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let spinnerSize = CGSize(width: 30, height: 30)
        let x = (screenSize.width / 2) - (spinnerSize.width / 2)
        let y = (screenSize.height / 2) - (spinnerSize.height / 2)
        self.spinner.frame = CGRectMake(x, y, spinnerSize.width, spinnerSize.height)
    }
    
    private func setupProgressWithBG() {
        self.loadingBGView = UIView()
        let screenSize = UIScreen.mainScreen().bounds.size
        let bgSize = CGSize(width: 80, height: 80)
        let x = (screenSize.width / 2) - (bgSize.width / 2)
        let y = (screenSize.height / 2) - (bgSize.height / 2)
        self.loadingBGView.frame = CGRectMake(x, y, bgSize.width, bgSize.height)
        self.loadingBGView.backgroundColor = self.bgColor
        self.loadingBGView.layer.cornerRadius = 5.0
        self.loadingBGView.layer.borderColor = UIColor.grayColor().CGColor
        self.loadingBGView.layer.borderWidth = 0.5
        self.loadingBGView.clipsToBounds = true
        
        let loadingBGViewSize = loadingBGView.frame.size
        let spinnerSize = CGSize(width: 50, height: 50)
        let spinner_x = (loadingBGViewSize.width / 2) - (spinnerSize.width / 2)
        let spinner_y = (loadingBGViewSize.height / 2) - (spinnerSize.height / 2)
        
        self.spinner.frame = CGRectMake(spinner_x, spinner_y
            , spinnerSize.width, spinnerSize.height)
        self.loadingBGView.addSubview(self.spinner)
        self.spinner.startAnimating()
    }
    
    private func setupProgressView() {
        self.loadingBGView = UIView()
        let screenSize = UIScreen.mainScreen().bounds.size
        let bgSize = CGSize(width: 200, height: 60)
        let x = (screenSize.width / 2) - (bgSize.width / 2)
        let y = (screenSize.height / 2) - (bgSize.height / 2)
        self.loadingBGView.frame = CGRectMake(x, y, bgSize.width, bgSize.height)
        self.loadingBGView.backgroundColor = self.bgColor
        self.loadingBGView.layer.cornerRadius = 5.0
        self.loadingBGView.layer.borderColor = UIColor.grayColor().CGColor
        self.loadingBGView.layer.borderWidth = 0.5
        self.loadingBGView.clipsToBounds = true
        
        let padding: CGFloat = 10
        let subViewWidth: CGFloat = bgSize.width - (padding * 2)
        //Progress View
        self.progressView = UIProgressView()
        self.progressView.progressViewStyle = .Bar
        self.progressView.frame = CGRectMake(padding, 20, subViewWidth, 21)
        self.progressView.progress = 0.0
        self.loadingBGView.addSubview(self.progressView)
        
        //Loading label
        self.loadingLabel = UILabel()
        self.loadingLabel.textAlignment = .Center
        self.loadingLabel.frame = CGRectMake(padding, bgSize.height - 30, subViewWidth, 21)
        self.loadingLabel.text = "Loading..."
        self.loadingLabel.textColor = UIColor.blackColor()
        
        self.loadingBGView.addSubview(self.loadingLabel)
        
    }
}
