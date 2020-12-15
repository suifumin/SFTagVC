//
//  ShowAllCollectionCell.swift
//  Test
//
//  Created by suifumin on 2020/12/15.
//

import UIKit

class ShowAllCollectionCell: UICollectionViewCell {
    lazy var nameLabel:UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.textColor =  RGB(111, 111, 112)
       return nameLabel
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(nameLabel)
        self.nameLabel.frame = self.contentView.bounds
        self.contentView.layer.borderWidth = 1
        self.contentView.layer.borderColor = RGB(221, 221, 221).cgColor
        self.contentView.layer.cornerRadius = 3
        self.contentView.layer.masksToBounds = true
        self.contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
