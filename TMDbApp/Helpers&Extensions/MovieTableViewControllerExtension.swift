//
//  MovieTableViewControllerExtension.swift
//  TMDbApp
//
//  Created by Colton Swapp on 8/7/20.
//  Copyright © 2020 Colton Swapp. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        present(alertController, animated: true)
    }
}
