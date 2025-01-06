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
