//
//  TagsViewController.swift
//  TagsController_Example
//
//  Created by suifumin on 2020/12/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class TagsViewController: UIViewController {

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
   lazy var btnArray: [UIButton] = [UIButton]()
   lazy var vcArray: [UIViewController] = [UIViewController]()
    var selectedHeadButton: UIButton = UIButton(type: .custom)
    var titleA: [String] = [String]()
    let mainWidth = UIScreen.main.bounds.size.width
    convenience init(titleArray: [String],titleScrollHeight: CGFloat,buttonSize: CGSize) {
        self.init()
        titleA = titleArray
        titleScrollH = titleScrollHeight
        btnSize = buttonSize
        
    }
  public   override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        addScrollView()
        addAllChildControllers(num: titleA.count)
        addAllHeadTitleS(headArray: titleA)
        setDefaultSetting()
        
    }
    //MARk: 添加scrollView
    func addScrollView() {
        view.addSubview(self.titleScrollView)
        view.addSubview(self.contentScrollView)
        

        if(isIphoneX()) {
            self.titleScrollView.frame = CGRect(x: 0, y: 88, width: mainWidth, height: titleScrollH)
        }else{
            self.titleScrollView.frame = CGRect(x: 0, y: 64, width: mainWidth, height: titleScrollH)
        }
        self.contentScrollView.frame = CGRect(x: 0, y: titleScrollView.frame.maxY, width: mainWidth, height: self.view.bounds.size.height - titleScrollH )
        
    }
    
    func isIphoneX() -> Bool {
        return (UIApplication.shared.statusBarFrame.size.height == 44.0) ? true : false
    }
    //MARK: 添加所有子控制器
    func addAllChildControllers(num: Int) {
        for _ in 0 ..< num {
            let vc =  UIViewController()
            arc4random()
            vc.view.backgroundColor = .white
            self.addChild(vc)
            vcArray.append(vc)
        }
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        self.contentScrollView.contentSize = CGSize(width: CGFloat(num) * screenWidth, height: 0)
        
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
        
        self.titleScrollView.contentSize = CGSize(width: (headLabelWidth) * CGFloat(headArray.count), height: 0)
        
    }
    @objc func clickHeadBtn(sender: UIButton) {
        let contentOffX: CGFloat = CGFloat(sender.tag) * UIScreen.main.bounds.size.width
        self.contentScrollView.setContentOffset(CGPoint(x: contentOffX, y: 0), animated: true)
        self.selectedHeadButton.isSelected = false
        self.selectedHeadButton = sender
        sender.isSelected =  true
        
    }
    //MARK: 设置默认设置
    func setDefaultSetting() {
        
        let firstView: UIView = (self.children.first?.view)!
        firstView.frame = self.contentScrollView.bounds
        self.contentScrollView.addSubview(firstView)
        
        
        let headButton = self.titleScrollView.subviews.first as? UIButton
        self.selectedHeadButton = headButton!
        headButton?.isSelected = true
        
    }


}
 extension TagsViewController: UIScrollViewDelegate {
    
    
    public   func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollViewDidEndDecelerating(scrollView)
    }
    
    public  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index: Int = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        let headButton = self.titleScrollView.subviews[index] as! UIButton
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
        _ = CGPoint(x: titlesOffsetx, y: self.titleScrollView.contentOffset.y)
        self.titleScrollView.setContentOffset(CGPoint(x: titlesOffsetx, y: self.titleScrollView.contentOffset.y), animated: true)
        
        
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
