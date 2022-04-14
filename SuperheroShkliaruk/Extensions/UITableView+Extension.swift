//
//  UITableView+Extension.swift
//  SuperheroShkliaruk
//
//  Created by Andrii Shkliaruk on 12.04.2022.
//

import UIKit

extension UITableView {
    func reloadDataWithScroll(to section: Int, animated: Bool) {
        let offset = contentOffset
        reloadData()
        layoutIfNeeded()
        setContentOffset(offset, animated: false)
        let sectionIndexPath = IndexPath(row: NSNotFound, section: section)
        scrollToRow(at: sectionIndexPath, at: .top, animated: animated)
    }
}
