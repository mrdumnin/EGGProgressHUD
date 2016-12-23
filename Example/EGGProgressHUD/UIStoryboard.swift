//
//  UIStoryboard.swift
//  fivestarchicken
//
//  Created by Suchon Dumnin on 3/23/2559 BE.
//  Copyright © 2559 EGG Digital. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static func getViewController(_ storyBoardName: String, viewControllerId: String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerId)
    }
}
