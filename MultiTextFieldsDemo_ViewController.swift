//
//  ViewController.swift
//  MultiTextFieldsDemo
//
//  Created by 桐山圭祐 on 2017/07/09.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var textView1: UITextView?
    var textView2: UITextView?
    var textView3: UITextView?


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ストレージに文字を保持しておいて、LayoutManagerがその文字拾って、表示するためのマネージャー。
        
        
        //1つのストレージに2つのLyoutManagerを登録
        let storage = NSTextStorage(string: "「人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。人とテクノロジーの融合でワクワクする食文化を創る」というミッションをもとに、AR（拡張現実）を駆使して食事を際立たせ、新たな食事体験を提供します。また 人工知能を駆使して、自分専用の「食のコンシュルジュ」を育てることで、最適な飲食店や食料品をレコメンドします。")
        let layoutManager1 = NSLayoutManager()
        let container1 = NSTextContainer()
        layoutManager1.addTextContainer(container1)
        storage.addLayoutManager(layoutManager1)
        
        //LayoutManager2には2つのContainerを登録
        let layoutManager2 = NSLayoutManager()
        let container2 = NSTextContainer()
        let container3 = NSTextContainer()
        
        layoutManager2.addTextContainer(container2)
        layoutManager2.addTextContainer(container3)
        storage.addLayoutManager(layoutManager2)
        
        //textView1はスクロール可能,編集可能とし、
        //AccessoryViewを付加する。
        let textView1 = UITextView(frame: CGRect.zero, textContainer: container1)
        textView1.backgroundColor = UIColor.red.withAlphaComponent(0.2)
        
        let accessoryBar = UIToolbar()
        accessoryBar.sizeToFit()
        let doneBtn = UIBarButtonItem(title: "完了", style: .done, target: self, action: #selector(self.doneBtnDidPush(sender:)))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        accessoryBar.setItems([spacer,doneBtn], animated: true)
        textView1.inputAccessoryView = accessoryBar
        textView1.isScrollEnabled = true
        
        //textView2, 3を編集不可とし、textView2はスクロール不可
        let textView2 = UITextView(frame: CGRect.zero, textContainer: container2)
        textView2.isEditable = false
        textView2.isScrollEnabled = false
        textView2.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        
        let textView3 = UITextView(frame: CGRect.zero, textContainer: container3)
        textView3.isEditable = false
        textView3.backgroundColor = UIColor.blue.withAlphaComponent(0.2)
        
        for v in [textView1,textView2,textView3] {
            self.view.addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        //Auto LayoutのConstraintを設定します。
        let views: [String: AnyObject] = [
            "tv1" : textView1,
            "tv2" : textView2,
            "tv3" : textView3,
            "tlg" : self.topLayoutGuide,
            "blg" : self.bottomLayoutGuide
        ]
        
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[tlg]-12-[tv1]-10-[tv2(==tv1)]-10-[tv3(==tv1)]-12-[blg]", options: .directionLeadingToTrailing, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[tv1]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[tv2]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[tv3]-20-|", options: .directionLeadingToTrailing, metrics: nil, views: views))
        
        self.textView1 = textView1
        self.textView2 = textView2
        self.textView3 = textView3
        
    }
    
    func doneBtnDidPush(sender: UIBarButtonItem){
        //textView1をFirstResponderから外すことで、キーボードを閉じる
        self.textView1!.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

