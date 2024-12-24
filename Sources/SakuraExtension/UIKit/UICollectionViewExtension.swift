//
//  File.swift
//  
//
//  Created by Duc apple  on 24/12/24.
//

import Foundation
import UIKit

public extension UICollectionView {
    func registerCell<T>(type: T.Type, bundle: Bundle = Bundle.main) {
        let name = String(describing: type)
        self.register(UINib(nibName: name, bundle: bundle), forCellWithReuseIdentifier: name)
    }

    func dequeueCell<T>(type: T.Type, indexPath: IndexPath) -> T? {
        let name = String(describing: type)
        return self.dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T
    }
}
