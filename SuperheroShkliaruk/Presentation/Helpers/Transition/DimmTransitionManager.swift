//
//  DimmTransitionManager.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 22.03.2022.
//

import UIKit

class DimmTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DimmPresentationController(presentedViewController: presented,
                                          presenting: presenting ?? source)
    }
}
