//
//  ViewController.swift
//  VisualFormatDemo
//
//  Created by 桐山圭祐 on 2017/07/07.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let copyright: UILabel = UILabel()
    let page: UILabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        copyright.text = "Oruche.Inc"
        page.text = "p.1"
        
        for v in [copyright, page]{
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        self.setConstraints()
        self.updateLayout()
    }
    
    
    func setConstraints() {
        let views: [String: AnyObject] = [
            "copyright": copyright,
            "page": page,
            "topLayoutGuide": topLayoutGuide,
            "bottomLayoutGuide": bottomLayoutGuide
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[copyright]-20-[bottomLayoutGuide]", options: .directionLeadingToTrailing, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[copyright]-(>=0)-[page]-|", options: [.directionLeadingToTrailing, .alignAllBottom], metrics: nil, views: views))
        self.view.addConstraint(NSLayoutConstraint(item: copyright, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0))
    }
    
    func updateLayout() {
        let h = self.traitCollection.horizontalSizeClass
        let v = self.traitCollection.verticalSizeClass
        
        switch(h, v) {
        case (.compact, .compact):
            print(".compact, .compact")
            copyright.isHidden = true
            page.isHidden = true
        case (.compact, .regular):
            print(".compact, .regular")
            copyright.isHidden = false
            page.isHidden = false
        case (.regular, .compact):
            print("regular, .compact")
            copyright.isHidden = true
            page.isHidden = true
        case (.regular, .regular):
            print(".regular, .regular")
            copyright.isHidden = false
            page.isHidden = false
        default:
            break
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        self.updateLayout()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

