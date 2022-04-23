//
//  Coordinator+InfoView.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 23.04.2022.
//

import UIKit

extension MainCoordinator {
    func backWithInfoView(iconName: String, text: String) {
        if let navigationControllerView = navigationController.view,
           let icon = UIImage(named: iconName) {
            
            let infoView: InfoView = InfoView.fromNib()
            infoView.frame = navigationControllerView.frame
            infoView.configure(with: icon,
                               text: text,
                               backgroundColor: nil)
            UIView.showWithTransition(for: 2, childView: infoView, in: navigationControllerView) { [weak self] in
                self?.back()
            }
        } else {
            back()
        }
    }
}
