//
//  ShowAllLabelView.swift
//  rebate
//
//  Created by suifumin on 2020/4/14.
//  Copyright © 2020 寻宝天行. All rights reserved.
//

import UIKit
typealias  ClickAllCellBlock = ((_ num: Int) -> ())
class ShowAllLabelView: UIView {
    lazy var selectedBtn:UIButton = {
        var selectedBtn = UIButton(type: .custom)
        return selectedBtn
    }()
    var defualtSelectTag:Int = 0
    
    lazy var btnA = [UIButton]()
    public var clickAllCellBlock: ClickAllCellBlock?
    let collectionViewLayout = ShowAllLayout()
    lazy var collectionView:UICollectionView = {
        self.collectionViewLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 15, right: 20)
        let marginY:CGFloat = 10
        let marginX:CGFloat = 10
        self.collectionViewLayout.sectionHeadersPinToVisibleBounds = true
        self.collectionViewLayout.minimumLineSpacing = marginY
        self.collectionViewLayout.minimumInteritemSpacing = marginX
        let collectionViewCellW:CGFloat = (ScreenSize.SCREEN_WIDTH - 20 * 2 - marginX * 2)/3
        let collectionViewCellH:CGFloat = 30
        self.collectionViewLayout.itemSize = CGSize(width: collectionViewCellW, height: collectionViewCellH)
        let collectionView = UICollectionView(frame:.zero, collectionViewLayout: self.collectionViewLayout)
        collectionView.register(ShowAllCollectionCell.self, forCellWithReuseIdentifier: "showAllCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .white
     
        self.collectionViewLayout.sectionHeadersPinToVisibleBounds = true
        self.collectionViewLayout.headerReferenceSize = CGSize(width: ScreenSize.SCREEN_WIDTH, height: 15)
        
        return collectionView
        
    }()
   
   
    ///首页中标题（分类的数据）
    var titles: [String]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white

        addSubview(self.collectionView)
        

        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func clickBtn(sender:UIButton){
        self.selectedBtn.isSelected = false
        self.selectedBtn = sender
        sender.isSelected = true
       
        
    }
   
    
}
extension ShowAllLabelView: UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return titles?.count ?? 0
        
      
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "showAllCollectionCell", for: indexPath) as! ShowAllCollectionCell
        
        if let titles = self.titles {
           let title = titles[indexPath.row]
            if (self.defualtSelectTag == indexPath.row) {
                cell.contentView.layer.borderColor = RGB(255, 49, 74).cgColor
                cell.contentView.backgroundColor = RGB(253,248,248)
                cell.nameLabel.textColor = RGB(255, 49, 74)
            }
            else {
                cell.contentView.layer.borderColor = RGB(221, 221, 221).cgColor
                cell.contentView.backgroundColor = .white
                cell.nameLabel.textColor = RGB(111, 111, 112)
            }
            cell.nameLabel.text = title
            return cell
        }
        
        
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let _ = self.titles {
           
            self.defualtSelectTag = indexPath.row
            self.collectionView.reloadData()
            if let block = self.clickAllCellBlock {
                block(indexPath.row)
            }
            return
        }

    }
 
    
}
