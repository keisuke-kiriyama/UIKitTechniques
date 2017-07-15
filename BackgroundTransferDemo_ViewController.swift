//
//  ViewController.swift
//  BackgroundTransferDemo
//
//  Created by 桐山圭祐 on 2017/07/15.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

//投げ出し！！！！！！


import UIKit
import AVKit
import AVFoundation


class ViewController: UIViewController {
    
    //ダウンロードの状態を列挙型で管理
    
    enum USDownloadState : Int {
        case Init = 0, caseDownloading, Suspended, Downloaded
    }
    
    var appDelegate: AppDelegate?
    var state: USDownloadState = .Init
    var task: URLSessionDownloadTask?
    
    let target = URL(string: "http://")
    var saveAs: String?
    
    @IBOutlet weak var _start: UIButton!
    @IBOutlet weak var _cancel: UIButton!
    @IBOutlet weak var _play: UIButton!
    @IBOutlet weak var _progressView: UIProgressView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

