//
//  EGGProgressHUD.swift
//  Pods
//
//  Created by Suchon Dumnin on 10/7/2559 BE.
//
//

import UIKit

open class EGGProgressHUD: NSObject {
    fileprivate var rotateAngle:CGFloat = 0.0
    fileprivate var isAnimating:Bool = false
    fileprivate var spinner: UIActivityIndicatorView!
    fileprivate var loadingBGView: UIView!
    fileprivate var progressView: UIProgressView!
    fileprivate var loadingLabel: UILabel!
    
    fileprivate var loadingImageView: UIImageView!
    
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
        case progressWithoutBG
        case progressWithBG
        case progressView
        case progressImage
    }
    
    public enum SpinnerStyle {
        case white
        case gray
    }

    fileprivate var bundle:Bundle {
        let podBundle = Bundle(for: EGGProgressHUD.self)
        
        let bundleURL = podBundle.url(forResource: "EGGProgressHUDResource", withExtension: "bundle")
        let bundle = Bundle(url: bundleURL!)!
        return bundle
    }
    
    //MARK: - Initial
    public override init() {
        super.init()
        
        self.spinner = UIActivityIndicatorView()
        self.loadingBGView = UIView()
        self.loadingBGView = UIView()
        self.loadingImageView = UIImageView()

        
        self.type = ProgressType.progressWithoutBG
        self.style = SpinnerStyle.gray
        self.bgColor = UIColor.black
        self.loadingTextColor = UIColor.black
        self.progressTrackTintColor = UIColor.white
        self.progressTintColor = UIColor.blue
        
        self.loadingText = "Loading..."
        
        //self.loadingImage = UIImage(named: "loading.png", inBundle: self.bundle, compatibleWithTraitCollection: nil)
        self.loadingImage = UIImage(named: "Circle-Progress.png", in: self.bundle, compatibleWith: nil)
    }
    
    open func showInView(_ view: UIView) {
        
         if self.type == ProgressType.progressWithoutBG {
            self.setupProgressWithoutBG()
            
            self.spinner.removeFromSuperview()
            view.addSubview(self.spinner)
            
            self.spinner.startAnimating()
         } else if self.type == ProgressType.progressWithBG {
            self.setupProgressWithoutBG()
            self.setupProgressWithBG()
            
            self.loadingBGView.isHidden = false
            self.loadingBGView.removeFromSuperview()
            view.addSubview(self.loadingBGView)
         } else if self.type == ProgressType.progressView {
            self.setupProgressView()
            
            self.loadingBGView.isHidden = false
            self.loadingBGView.removeFromSuperview()
            view.addSubview(self.loadingBGView)
         } else if self.type == ProgressType.progressImage {
            self.setupProgressImage()
            
            self.loadingImageView.isHidden = false
            self.loadingImageView.removeFromSuperview()
            view.addSubview(self.loadingImageView)
        }
    }
    
    open func hide() {
        if self.type == ProgressType.progressWithBG || self.type == ProgressType.progressView {
            self.loadingBGView.isHidden = true
        } else if self.type == ProgressType.progressWithoutBG {
            self.spinner.stopAnimating()
        } else if self.type == ProgressType.progressImage {
            self.stopAnimateLoadingImageView()
            self.loadingImageView.isHidden = true
        }
    }
    
    open func setProgress(_ progress: Float) {
        guard (self.progressView == nil) else {
            DispatchQueue.main.async {
                self.progressView.setProgress(progress, animated: true)
            }
            return
        }
    }
    
    fileprivate func setupProgressWithoutBG() {
        //self.spinner = UIActivityIndicatorView()
        if self.style == SpinnerStyle.white {
            self.spinner.activityIndicatorViewStyle = .whiteLarge
        } else {
            self.spinner.activityIndicatorViewStyle = .gray
        }
        
        self.spinner.hidesWhenStopped = true
        
        let screenSize = UIScreen.main.bounds.size
        let spinnerSize = CGSize(width: 30, height: 30)
        let x = (screenSize.width / 2) - (spinnerSize.width / 2)
        let y = (screenSize.height / 2) - (spinnerSize.height / 2)
        self.spinner.frame = CGRect(x: x, y: y, width: spinnerSize.width, height: spinnerSize.height)
    }
    
    fileprivate func setupProgressWithBG() {
        //self.loadingBGView = UIView()
        let screenSize = UIScreen.main.bounds.size
        let bgSize = CGSize(width: 80, height: 80)
        let x = (screenSize.width / 2) - (bgSize.width / 2)
        let y = (screenSize.height / 2) - (bgSize.height / 2)
        self.loadingBGView.frame = CGRect(x: x, y: y, width: bgSize.width, height: bgSize.height)
        self.loadingBGView.backgroundColor = self.bgColor
        self.loadingBGView.layer.cornerRadius = 5.0
        self.loadingBGView.layer.borderColor = UIColor.gray.cgColor
        self.loadingBGView.layer.borderWidth = 0.5
        self.loadingBGView.clipsToBounds = true
        
        let loadingBGViewSize = loadingBGView.frame.size
        let spinnerSize = CGSize(width: 50, height: 50)
        let spinner_x = (loadingBGViewSize.width / 2) - (spinnerSize.width / 2)
        let spinner_y = (loadingBGViewSize.height / 2) - (spinnerSize.height / 2)
        
        self.spinner.frame = CGRect(x: spinner_x, y: spinner_y
            , width: spinnerSize.width, height: spinnerSize.height)
        self.loadingBGView.addSubview(self.spinner)
        self.spinner.startAnimating()
    }
    
    fileprivate func setupProgressView() {
        //self.loadingBGView = UIView()
        let screenSize = UIScreen.main.bounds.size
        let bgSize = CGSize(width: 200, height: 60)
        let x = (screenSize.width / 2) - (bgSize.width / 2)
        let y = (screenSize.height / 2) - (bgSize.height / 2)
        self.loadingBGView.frame = CGRect(x: x, y: y, width: bgSize.width, height: bgSize.height)
        self.loadingBGView.backgroundColor = self.bgColor
        self.loadingBGView.layer.cornerRadius = 5.0
        self.loadingBGView.layer.borderColor = UIColor.gray.cgColor
        self.loadingBGView.layer.borderWidth = 0.5
        self.loadingBGView.clipsToBounds = true
        
        let padding: CGFloat = 10
        let subViewWidth: CGFloat = bgSize.width - (padding * 2)
        //Progress View
        self.progressView = UIProgressView()
        self.progressView.progressViewStyle = .bar
        self.progressView.frame = CGRect(x: padding, y: 20, width: subViewWidth, height: 21)
        self.progressView.progress = 0.0
        self.progressView.trackTintColor = self.progressTrackTintColor
        self.progressView.tintColor = self.progressTintColor
        self.loadingBGView.addSubview(self.progressView)
        
        //Loading label
        self.loadingLabel = UILabel()
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.frame = CGRect(x: padding, y: bgSize.height - 30, width: subViewWidth, height: 21)
        self.loadingLabel.text = self.loadingText
        self.loadingLabel.textColor = self.loadingTextColor
        
        self.loadingBGView.addSubview(self.loadingLabel)
        
    }
    
    fileprivate func setupProgressImage() {
        //self.loadingImageView = UIImageView()
        self.loadingImageView.image = self.loadingImage
        self.loadingImageView.backgroundColor = UIColor.clear
        
        let screenSize = UIScreen.main.bounds.size
        let imageSize = CGSize(width: 40, height: 40)
        let x = (screenSize.width / 2) - (imageSize.width / 2)
        let y = (screenSize.height / 2) - (imageSize.height / 2)
        
        self.loadingImageView.frame = CGRect(x: x, y: y, width: imageSize.width, height: imageSize.height)
        self.startAnimateLoadingImageView()
        self.isAnimating = true
    }
    
    fileprivate func startAnimateLoadingImageView() {
        
        rotateAngle += CGFloat(M_PI)

        let rotateTransform = CGAffineTransform(rotationAngle: rotateAngle)
        UIView.animate(withDuration: 0.4, delay: 0, options: [.allowUserInteraction, .curveLinear], animations: { () -> Void in
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
    
    fileprivate func stopAnimateLoadingImageView() {
        self.isAnimating = false
    }
}

