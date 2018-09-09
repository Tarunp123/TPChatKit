//
//  TPChatViewToolbarVC.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 9/5/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//


//*****************
//*****************
//NOT IN USE
//*****************
//*****************

//import UIKit
//
//class TPChatViewToolbarVC: UIViewController, UITextViewDelegate {
//
//    lazy var toolbarView : TPMessagesToolbarView = {
//        return TPMessagesToolbarView(frame: self.frame)
//    }()
//    
//    private var frame : CGRect!
//    var toolbarDelegate : TPMessagesToolbarDelegate?
//    
//    
//    init(frame: CGRect) {
//        super.init(nibName: nil, bundle: nil)
//        self.frame = frame
//    }
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.setupToolbar()
//        
//    }
//    
//    private func setupToolbar(){
//        print("setupToolbar")
//        self.toolbarView.textView?.delegate = self
//        self.toolbarView.sendButton?.addTarget(self, action: #selector(didClickSendButton(sender:)), for: UIControlEvents.touchUpInside)
//        self.toolbarView.sendButton?.isEnabled = false
//        self.toolbarView.textView?.inputAccessoryView = self.toolbarView
//    }
//
//    
//    @IBAction func didClickSendButton(sender: UIButton){
//        print("SEND")
//        self.toolbarDelegate?.didClickSendButtonWithText(text: self.toolbarView.textView!.text!)
//        self.toolbarView.textView?.text = ""
//    }
//    
//    
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//     
//        let currentText = textField.text ?? ""
//        guard let stringRange = Range(range, in: currentText) else { return false }
//    
//        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
//        if(updatedText.count > 0){
//            //activate send button
//            self.toolbarView.sendButton?.isEnabled = true
//        }else{
//            //deactivate send button
//            self.toolbarView.sendButton?.isEnabled = false
//        }
//        
//        return true
//    }
//
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//
//}
