//
//  ProfileViewControllerDelegate.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 20.03.2022.
//

import UIKit

protocol ProfileViewControllerDelegate {
    func updateSaveButtonState()
    func setActiveTableViewCell(_ cell: UITableViewCell?)
}
