//
//  TagsViewController.swift
//  TagsController_Example
//
//  Created by suifumin on 2020/12/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
public class TagsViewController: UIViewController {
    lazy var slideView: UIView = {
        let slideView = UIView()
        slideView.backgroundColor = .red
        return slideView
    }()
    var titleScrollH: CGFloat = 0.0
    var btnSize: CGSize = CGSize(width: 0, height: 0)
    lazy var titleScrollView: UIScrollView = {
        let titleScrollView = UIScrollView()
        titleScrollView.backgroundColor = .white
        titleScrollView.showsHorizontalScrollIndicator = false
        return titleScrollView
    }()
    lazy var contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.backgroundColor = .white
        contentScrollView.showsHorizontalScrollIndicator = false
        contentScrollView.delegate = self
        contentScrollView.isPagingEnabled = true
        return contentScrollView
    }()
    lazy var moreBtn: UIButton = {
        let moreBtn = UIButton(type: .custom)
        moreBtn.setImage(UIImage(named: "icon_more"), for: .normal)
        moreBtn.backgroundColor = .white
        moreBtn.addTarget(self, action: #selector(clickMoreBtn), for: .touchUpInside)
        return moreBtn
    }()
    lazy var showAllLabelView : ShowAllLabelView = {
        let showAllLabelView = ShowAllLabelView()
        showAllLabelView.isHidden = true
        return showAllLabelView
    }()
    lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = .black
        coverView.alpha = 0.3
        coverView.isHidden = true
        let tapcoverView = UITapGestureRecognizer(target: self, action: #selector(tapCoverview))
        coverView.addGestureRecognizer(tapcoverView)
        return coverView
    }()
    public lazy var btnArray: [UIButton] = [UIButton]()
    public var clicktitleBtnBlock: ((_ num: Int) -> ())?
    public var selectedHeadButton: UIButton = UIButton(type: .custom)
    var titleA: [String] = [String]()
    let mainWidth = UIScreen.main.bounds.size.width
    var btnNormalColor: UIColor = .black
    var btnSelectColor: UIColor = .red
    var btnFont: CGFloat = 12
    var slideColor: UIColor?
    var slideSize: CGSize?
    var isHideMoreBtn: Bool = true
    var vcStr: String = ""
    public convenience init(titleArray: [String],titleScrollHeight: CGFloat,buttonSize: CGSize,headBtnNomalColor: UIColor, headBtnSelColor: UIColor,headBtnFont: CGFloat,slideViewColor: UIColor,slideViewSize: CGSize,hideMoreBtn: Bool,controllerString: String) {
        self.init()
        titleA = titleArray
        titleScrollH = titleScrollHeight
        btnSize = buttonSize
        btnNormalColor = headBtnNomalColor
        btnSelectColor = headBtnSelColor
        btnFont = headBtnFont
        slideColor = slideViewColor
        slideSize = slideViewSize
        isHideMoreBtn = hideMoreBtn
        vcStr = controllerString
    }
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
        addAllChildControllers(num: titleA.count)
        addAllHeadTitleS(headArray: titleA)
        setDefaultSetting()
        
        self.showAllLabelView.clickAllCellBlock = { [weak self] (num) in
            guard let strongself = self else {return}
            strongself.setTitleViewOffset(num: num)
            strongself.showAllLabelView.isHidden = true
            if let block = strongself.clicktitleBtnBlock {
                block(num)
            }
        }
        
        
    }
    //MARk: 添加scrollView
    func setUI() {
        view.addSubview(self.titleScrollView)
        view.addSubview(self.contentScrollView)
        view.addSubview(self.moreBtn)
        view.insertSubview(self.showAllLabelView, at: self.view.subviews.count)
        view.insertSubview(self.coverView, at: self.view.subviews.count)
        var valuey: CGFloat = 0.0
        if(isIphoneX()) {
            valuey = 88.0
        }else{
            valuey = 64.0
        }
        self.titleScrollView.frame = CGRect(x: 0, y: valuey, width: mainWidth, height: titleScrollH)
        self.contentScrollView.frame = CGRect(x: 0, y: titleScrollView.frame.maxY, width: mainWidth, height: self.view.bounds.size.height - titleScrollH )
        self.titleScrollView.addSubview(self.slideView)
        moreBtn.isHidden = isHideMoreBtn
        
        self.moreBtn.frame = CGRect(x: mainWidth - 30, y: valuey, width: (moreBtn.isHidden ? 0 : 30) , height: titleScrollH)
        self.showAllLabelView.frame = CGRect(x: 0, y: self.titleScrollView.frame.minY, width: mainWidth, height: 50)
        self.coverView.frame = CGRect(x: 0, y: self.showAllLabelView.frame.maxY, width: mainWidth, height: self.view.bounds.size.height - self.showAllLabelView.frame.maxY)
        
    }
    
    
    //MARK: 添加所有子控制器
    func addAllChildControllers(num: Int) {
        for _ in 0 ..< num {
           
            let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
            let vcCl:AnyObject = NSClassFromString(namespace + "." + vcStr)!
            let vc = vcCl as! UIViewController.Type
            let convc = vc.init();
            
            
            self.addChild(convc)
        }
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        self.contentScrollView.contentSize = CGSize(width: CGFloat(num) * screenWidth + moreBtn.bounds.size.width, height: 0)
        
    }
    //MARK: 添加所有标题
    func addAllHeadTitleS(headArray: [String]) {
        let headLabelWidth = btnSize.width
        let btnY =  ((titleScrollH / 2.0) - (btnSize.height / 2.0))
        for i in 0 ..< headArray.count {
            let headButton = UIButton(type: .custom)
            headButton.setTitle(headArray[i], for: .normal)
            headButton.setTitleColor(.black, for: .normal)
            headButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            headButton.setTitle(headArray[i], for: .selected)
            headButton.setTitleColor(.red, for: .selected)
            self.titleScrollView.addSubview(headButton)
            
            headButton.frame = CGRect(x:  headLabelWidth  * CGFloat(i), y: btnY , width: btnSize.width, height: btnSize.height)
            headButton.tag = i
            headButton.addTarget(self, action: #selector(clickHeadBtn), for: .touchUpInside)
            btnArray.append(headButton)
        }
        
        self.titleScrollView.contentSize = CGSize(width: (headLabelWidth) * CGFloat(headArray.count) + moreBtn.bounds.width, height: 0)
        
        
    }
    @objc func clickMoreBtn() {
        self.coverView.isHidden = false
        self.showAllLabelView.isHidden = false
        self.showAllLabelView.titles = self.titleA
        self.showAllLabelView.collectionViewLayout.didloadedCollectionView = { [weak self](contentsize) in
            guard let strongSelf = self else { return }
            var rect = strongSelf.showAllLabelView.frame
            rect.size.height = contentsize.height
            strongSelf.showAllLabelView.frame = rect
            
            var coverRect = strongSelf.coverView.frame
            coverRect.origin.y = strongSelf.showAllLabelView.frame.maxY
            strongSelf.coverView.frame = coverRect
            
            
        }
        
    }

    @objc func clickHeadBtn(sender: UIButton) {
        if let block = self.clicktitleBtnBlock {
            block(sender.tag)
        }
        self.setTitleViewOffset(num: sender.tag)
    }
    
    @objc func tapCoverview(tap: UITapGestureRecognizer) {
        self.showAllLabelView.isHidden = true
        self.coverView.isHidden = true
    }
    func setTitleViewOffset(num: Int) {
        self.showAllLabelView.isHidden = true
        self.coverView.isHidden = true
        let contentOffX: CGFloat = CGFloat(num) * UIScreen.main.bounds.size.width
        self.contentScrollView.setContentOffset(CGPoint(x: contentOffX, y: 0), animated: false)
        let sender = self.btnArray[num]
        self.selectedHeadButton.isSelected = false
        self.selectedHeadButton = sender
        sender.isSelected =  true
    }
    //MARK: 设置默认设置
    func setDefaultSetting() {
        
        let firstView: UIView = (self.children.first?.view)!
        firstView.frame = self.contentScrollView.bounds
        self.contentScrollView.addSubview(firstView)
        
        
        let headButton = self.btnArray.first
        self.selectedHeadButton = headButton!
        headButton?.isSelected = true
        self.slideView.frame = CGRect(x: self.selectedHeadButton.center.x - (self.slideSize?.width ?? 0.0) * 0.5 , y: titleScrollH - (self.slideSize?.height ?? 0.0), width: (self.slideSize?.width ?? 0), height: self.slideSize?.height ?? 0)
        
        
    }
    
    
}
extension TagsViewController: UIScrollViewDelegate {
    
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        let index: Int = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let headButton = self.btnArray[index]
        self.selectedHeadButton.isSelected = false
        self.selectedHeadButton = headButton
        headButton.isSelected = true
        
        var titlesOffsetx: CGFloat = headButton.center.x - scrollView.bounds.width * 0.5
        let maxtitlesOffsetx = self.titleScrollView.contentSize.width - self.titleScrollView.bounds.width 
        if (titlesOffsetx < 0) {
            titlesOffsetx = 0
        } else if (titlesOffsetx > maxtitlesOffsetx) {
            titlesOffsetx = maxtitlesOffsetx
        }
        let point = CGPoint(x: titlesOffsetx, y: self.titleScrollView.contentOffset.y)
        self.titleScrollView.setContentOffset(point, animated: true)
        UIView.animate(withDuration: 0.25) {
            var frame = self.slideView.frame
            frame.origin.x = self.selectedHeadButton.center.x - ((self.slideSize?.width ?? 0) * 0.5)
            self.slideView.frame = frame
        }
        let vc = self.children[index]
        if (vc.view.superview != nil) {return}
        self.contentScrollView.addSubview(vc.view)
        
        vc.view.frame =  CGRect(x: CGFloat(index) * mainWidth, y: 0, width: mainWidth, height: self.contentScrollView.bounds.height)
      
        
        
        
    }
    
}
extension  UIColor  {
    //返回随机颜色
    class  var  randomColor:  UIColor  {
        get  {
            let  red =  CGFloat (arc4random()%256)/255.0
            let  green =  CGFloat (arc4random()%256)/255.0
            let  blue =  CGFloat (arc4random()%256)/255.0
            return  UIColor (red: red, green: green, blue: blue, alpha: 1.0)
        }
    }
}
