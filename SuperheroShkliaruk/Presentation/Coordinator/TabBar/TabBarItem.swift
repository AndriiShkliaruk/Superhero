//
//  TabBarItem.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 06.05.2022.
//

import UIKit

enum TabBarItem: Int {
    case home
    case profile
    case programs
    case calculator
    case muscles
    
    var index: Int {
        rawValue
    }
    
    var description: String {
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .programs:
            return "Programs"
        case .calculator:
            return "Calculator"
        case .muscles:
            return "Muscles"
        }
    }
    
    var icon: UIImage? {
        UIImage(named: description.lowercased())?.withRenderingMode(.alwaysOriginal)
    }
    
    var selectedIcon: UIImage? {
        icon?.withTintColor(.customYellow, renderingMode: .alwaysOriginal)
    }
}
