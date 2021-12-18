//
//  CollectionCellSize.swift
//  MathsQuiz
//
//  Created by Karahanyan Levon on 17.12.2021.
//

import UIKit

struct CollectionCellSize {
    static func calculateCellSize(itemsPerRow: CGFloat, in collectionView: UICollectionView) -> CGFloat {
        let itemsPerRow: CGFloat = itemsPerRow
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        return availableWidth / itemsPerRow
    }
}
