//
//
//
//  Created by Vũ Thị Thanh on 23/12/24.
//

import Foundation
import UIKit

public extension UIViewController {
    func presentAlert(title: String, message: String, action: UIAlertAction? = nil) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        vc.addAction(cancelAction)
        
        if let action {
            vc.addAction(action)
        }
        self.present(vc, animated: true)
    }
}

public extension UIAlertAction {
    static var openSetting: UIAlertAction {
        UIAlertAction(title: "Settings", style: .destructive) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        }
    }
}
