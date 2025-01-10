//
//  File.swift
//  
//
//  Created by Duc apple  on 6/1/25.
//

import Foundation
import UIKit

public extension UIApplication {
    func openSetting() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if self.canOpenURL(settingsUrl) {
            self.open(settingsUrl, completionHandler: { (success) in
                print("Settings opened: \(success)") // Prints true
            })
        }
    }
}

public extension UIApplication {
    var keyWindow: UIWindow? {
        return self.connectedScenes
               .filter { $0.activationState == .foregroundActive } // Keep only active scenes, onscreen and visible to the user
               .first(where: { $0 is UIWindowScene })  // Keep only the first `UIWindowScene`
               .flatMap({ $0 as? UIWindowScene })?.windows // Get its associated windows
               .first(where: \.isKeyWindow) // Finally, keep only the key window
    }
    
    var rootViewController: UIViewController? {
        return keyWindow?.rootViewController
    }
    
    var navigationController: UINavigationController? {
        return rootViewController as? UINavigationController
    }
}

public extension UINavigationController {
    var topVC: UIViewController? {
        var topVC = self.topViewController
        
        while topVC?.presentedViewController != nil {
            topVC = topVC?.presentedViewController
        }
        
        return topVC
    }
}
