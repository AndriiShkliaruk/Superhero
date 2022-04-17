//
//  UIViewController+ActionSheet.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 17.04.2022.
//

import UIKit

extension UIViewController {
    typealias ActionSheetItem = (title: String, handler: () -> Void)
    
    func showActionSheetWithCancel(with items: [ActionSheetItem]) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for item in items {
            actionSheet.addAction(UIAlertAction(title: item.title, style: .default, handler: { _ in item.handler() }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(actionSheet, animated: true)
    }
}
