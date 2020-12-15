//
//  ShowAllLayout.swift
//  Test
//
//  Created by suifumin on 2020/12/15.
//

import UIKit
typealias DidloadedCollectionView = (_ contentsize:CGSize) ->(Void)
class ShowAllLayout: UICollectionViewFlowLayout {

    var didloadedCollectionView:DidloadedCollectionView?
    override var collectionViewContentSize: CGSize{
        let size = super.collectionViewContentSize
        if let loadCollectionView = self.didloadedCollectionView{
            
            loadCollectionView(size)
        }
        return size
        
    }
}
