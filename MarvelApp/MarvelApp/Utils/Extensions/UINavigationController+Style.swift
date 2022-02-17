//
//  UINavigationController+Style.swift
//  MarvelApp
//
//  Created by crodrigueza on 17/2/22.
//

import UIKit

extension UINavigationController {
    func configureStyle(_ controller: UIViewController) {
        self.navigationItem.title = Constants.appName
        self.navigationBar.barTintColor = .red
//        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
