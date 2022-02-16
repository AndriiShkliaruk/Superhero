//
//  Storyboarded.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 15.02.2022.
//

import UIKit

public protocol Storyboarded: AnyObject {
    static var storyboard: UIStoryboard { get }
}

public extension Storyboarded {
    static var storyboard: UIStoryboard {
      return UIStoryboard(name: String(describing: self), bundle: Bundle(for: self))
    }
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
          fatalError("The ViewController of \(storyboard.classForCoder) is not of class \(self)")
      }
      return viewController
    }
}
