//
//  EGGProgressHUD.swift
//  Pods
//
//  Created by Suchon Dumnin on 10/7/2559 BE.
//
//

import UIKit

public class EGGProgressHUD: NSObject {
    private var rotateAngle:CGFloat = 0.0
    private var isAnimating:Bool = false
    private var spinner: UIActivityIndicatorView!
    private var loadingBGView: UIView!
    private var progressView: UIProgressView!
    private var loadingLabel: UILabel!
    
    private var loadingImageView: UIImageView!
    
    //MARK: - Property user can set
    public var type: ProgressType!
    public var style: SpinnerStyle!
    public var bgColor: UIColor!
    public var loadingText: String!
    public var loadingTextColor: UIColor!
    public var progressTrackTintColor: UIColor!
    public var progressTintColor: UIColor!
    public var loadingImage: UIImage!
    
    public enum ProgressType {
        case ProgressWithoutBG
        case ProgressWithBG
        case ProgressView
        case ProgressImage
    }
    
    public enum SpinnerStyle {
        case White
        case Gray
    }

    private var bundle:NSBundle {
        let podBundle = NSBundle(forClass: EGGProgressHUD.self)
        
        let bundleURL = podBundle.URLForResource("EGGProgressHUDResource", withExtension: "bundle")
        let bundle = NSBundle(URL: bundleURL!)!
        return bundle
    }
    
    //MARK: - Initial
    public override init() {
        super.init()
        
        self.type = ProgressType.ProgressWithoutBG
        self.style = SpinnerStyle.Gray
        self.bgColor = UIColor.blackColor()
        self.loadingTextColor = UIColor.blackColor()
        self.progressTrackTintColor = UIColor.whiteColor()
        self.progressTintColor = UIColor.blueColor()
        
        self.loadingText = "Loading..."
        
        //self.loadingImage = UIImage(named: "loading.png", inBundle: self.bundle, compatibleWithTraitCollection: nil)
        self.loadingImage = UIImage(named: "Circle-Progress.png", inBundle: self.bundle, compatibleWithTraitCollection: nil)
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
         } else if self.type == ProgressType.ProgressImage {
            self.setupProgressImage()
            
            self.loadingImageView.hidden = false
            self.loadingImageView.removeFromSuperview()
            view.addSubview(self.loadingImageView)
        }
    }
    
    public func hide() {
        if self.type == ProgressType.ProgressWithBG || self.type == ProgressType.ProgressView {
            self.loadingBGView.hidden = true
        } else if self.type == ProgressType.ProgressWithoutBG {
            self.spinner.stopAnimating()
        } else if self.type == ProgressType.ProgressImage {
            self.stopAnimateLoadingImageView()
            self.loadingImageView.hidden = true
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
        self.progressView.trackTintColor = self.progressTrackTintColor
        self.progressView.tintColor = self.progressTintColor
        self.loadingBGView.addSubview(self.progressView)
        
        //Loading label
        self.loadingLabel = UILabel()
        self.loadingLabel.textAlignment = .Center
        self.loadingLabel.frame = CGRectMake(padding, bgSize.height - 30, subViewWidth, 21)
        self.loadingLabel.text = self.loadingText
        self.loadingLabel.textColor = self.loadingTextColor
        
        self.loadingBGView.addSubview(self.loadingLabel)
        
    }
    
    private func setupProgressImage() {
        self.loadingImageView = UIImageView()
        self.loadingImageView.image = self.loadingImage
        self.loadingImageView.backgroundColor = UIColor.clearColor()
        
        let screenSize = UIScreen.mainScreen().bounds.size
        let imageSize = CGSize(width: 40, height: 40)
        let x = (screenSize.width / 2) - (imageSize.width / 2)
        let y = (screenSize.height / 2) - (imageSize.height / 2)
        
        self.loadingImageView.frame = CGRectMake(x, y, imageSize.width, imageSize.height)
        self.startAnimateLoadingImageView()
        self.isAnimating = true
    }
    
    private func startAnimateLoadingImageView() {
        
        rotateAngle += CGFloat(M_PI)

        let rotateTransform = CGAffineTransformMakeRotation(rotateAngle)
        UIView.animateWithDuration(0.4, delay: 0, options: [.AllowUserInteraction, .CurveLinear], animations: { () -> Void in
            self.loadingImageView.transform = rotateTransform
            },completion:  { (finished: Bool) in
                
                if self.isAnimating == true {
                    self.startAnimateLoadingImageView()
                }
            }
        )
        
    }
    
    /*private func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = Float.infinity
        
        self.loadingImageView.layer.addAnimation(rotateAnimation, forKey: nil)
    }*/
    
    private func stopAnimateLoadingImageView() {
        self.isAnimating = false
    }
}

