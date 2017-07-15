//
//  ViewController.swift
//  DocumentDemo
//
//  Created by 桐山圭祐 on 2017/07/09.
//  Copyright © 2017年 桐山圭祐. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    struct USDocInfo {
        static let NAME = "usdoc_test"
        static let EXTENSION = "us"
        static var LOCAL_DOCUMENTS_PATH: String? = nil
    }
    
    //アプリのサンドボックスのパスを格納する変数を宣言
    //一度調べてUSDocInfoに格納し、二度目以降は格納した値を返す
    var localDocumentsPath: String {
        if let dir = USDocInfo.LOCAL_DOCUMENTS_PATH {
            return dir
        } else {
            let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] + "/"
            USDocInfo.LOCAL_DOCUMENTS_PATH = dir
            return dir
        }
    }
    
    var document: USDocument!
    var isFileExists = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filePath = localDocumentsPath + USDocInfo.NAME + "." + USDocInfo.EXTENSION
        let fileUrl = URL(fileURLWithPath: filePath)
        
        //ファイルの存在チェック
        print("Documentのフルパス: \(filePath)")
        isFileExists = FileManager.default.fileExists(atPath: filePath)
        
        document = USDocument(fileURL: fileUrl)
        
        if isFileExists {
            document.open(completionHandler: {(success:Bool) in if success {
                print("Documentを開きました。place: \(String(describing: self.document.place))")
            }else{
                print("Documentを開けませんでした。")
            }})
        }else{
            document.place = "自宅"
            document.save(to: fileUrl, for: .forCreating, completionHandler: { (success:Bool) in
                if success{
                    print("Documentデータを保存しました。")
                }else{
                    print("Documentデータを保存できませんでした。")
                }}
            )
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class USDocument: UIDocument {
    
    //各データに対応したstatic定数を定義
    struct USFileWrapperKeys {
        static let IMG = "USDocument.img"
        static let PLACE = "USDocument.place"
        static let DATE = "USDocument.date"
        static let DETAIL = "USDocument.detail"
    }
    
    //記録したい内容を保持するメンバ変数
    var img: UIImage?
    var place: String?
    var date: NSDate?
    var detail: String?
    //上記の内容をひとまとめにするパッケージNSFileWrapper
    var fileWrapper: FileWrapper?
    

    //読み出し書き出し用のメソッド
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        //引数で渡されたcontentsをダウンキャストし、FileWrapperに詰める
        if let fileWrapper = contents as? FileWrapper {
            self.fileWrapper = fileWrapper
            let dict =  fileWrapper.fileWrappers
            
            if let fw = dict?[USFileWrapperKeys.IMG] {
                self.img = UIImage(data:fw.regularFileContents!)
            }
            if let fw = dict?[USFileWrapperKeys.PLACE] {
                self.place = String(data:fw.regularFileContents!, encoding: String.Encoding.utf8) as String?
            }
            if let fw = dict?[USFileWrapperKeys.DATE] {
                self.date = NSKeyedUnarchiver.unarchiveObject(with: fw.regularFileContents!) as? NSDate
            }
            if let fw = dict?[USFileWrapperKeys.DETAIL] {
                self.detail = String(data:fw.regularFileContents!, encoding: String.Encoding.utf8) as String?
            }
        }
    }
    
    override func contents(forType typeName: String) throws -> Any {
        if self.fileWrapper == nil {
            //空のディクショナリを渡す
            self.fileWrapper = FileWrapper(directoryWithFileWrappers:[:])
        }
        
        if let place = self.place, let data = place.data(using: String.Encoding.utf8) {
            let fw = FileWrapper(regularFileWithContents:data)
            fw.preferredFilename = USFileWrapperKeys.PLACE
            self.fileWrapper?.addFileWrapper(fw)
        }
        if let img = self.img, let data = UIImageJPEGRepresentation(img, 1.0) {
            let fw = FileWrapper(regularFileWithContents:data)
            fw.preferredFilename = USFileWrapperKeys.IMG
            self.fileWrapper?.addFileWrapper(fw)
        }
        if let date = self.date{
            let data = NSKeyedArchiver.archivedData(withRootObject: date)
            let fw = FileWrapper(regularFileWithContents:data)
            fw.preferredFilename = USFileWrapperKeys.DATE
            self.fileWrapper?.addFileWrapper(fw)
        }
        if let detail = self.detail, let data = detail.data(using: String.Encoding.utf8) {
            let fw = FileWrapper(regularFileWithContents:data)
            fw.preferredFilename = USFileWrapperKeys.DETAIL
            self.fileWrapper?.addFileWrapper(fw)
        }
        return self.fileWrapper
    }
    
    //データ更新
    func updateDocument(img: UIImage?, place: String?,date: NSDate?, detail: String?){
        self.img = img
        self.place = place
        self.date = date
        self.detail = detail
        self.updateChangeCount(.done)
    }
}





























