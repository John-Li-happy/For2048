//
//  CollectionViewCell.swift
//  For2048
//
//  Created by Zhaoyang Li on 10/23/20.
//

import Foundation
import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var digitLabel: UILabel!
    
    func configureCell(digit: Int) {
        digitLabel.text = digit == 0 ? " " : String(digit)
    }
}
