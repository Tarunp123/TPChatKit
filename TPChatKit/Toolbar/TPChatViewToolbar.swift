//
//  TPChatViewToolbar.swift
//  TPChatViewToolbar
//
//  Created by Tarun Prajapati on 9/3/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPChatViewToolbar: UIView {

    var backgroundView : UIView?
    var textView : UITextView?
    var sendButton : UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupBackgroundView()
        self.setupToolbarItems()
    }
    
    private func setupBackgroundView(){
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = UIColor.groupTableViewBackground//(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
        self.addSubview(self.backgroundView!)
        self.backgroundView?.translatesAutoresizingMaskIntoConstraints =  false
        self.backgroundView?.autoresizingMask = .flexibleHeight
        self.backgroundView?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        self.backgroundView?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        self.backgroundView?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        self.backgroundView?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    

    
    private func setupToolbarItems(){

        //Send Button
        self.sendButton = UIButton()
        self.sendButton?.setBackgroundImage(#imageLiteral(resourceName: "sendMsgBtn1"), for: .normal)
        self.sendButton?.setBackgroundImage(#imageLiteral(resourceName: "sendMsgBtn0"), for: UIControlState.disabled)
        self.sendButton?.setBackgroundImage(#imageLiteral(resourceName: "sendMsgBtnFilled"), for: UIControlState.highlighted)
        self.backgroundView?.addSubview(self.sendButton!)
        self.sendButton?.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton?.trailingAnchor.constraint(equalTo: self.backgroundView!.trailingAnchor, constant: -7.5).isActive = true
        self.sendButton?.bottomAnchor.constraint(equalTo: self.backgroundView!.bottomAnchor, constant: -12.5).isActive = true
        self.sendButton?.widthAnchor.constraint(equalToConstant: TOOLBAR_BUTTON_WIDTH).isActive = true
        self.sendButton?.heightAnchor.constraint(equalToConstant: TOOLBAR_BUTTON_HEIGHT).isActive = true

        //Text field
        self.textView = UITextView()
        self.textView?.backgroundColor = UIColor.white
        self.textView?.layer.cornerRadius = 8
        self.textView?.text = INPUT_FIELD_PLACEHOLDER
        self.textView?.textColor = UIColor.lightGray
        self.textView?.textContainer.lineBreakMode = .byWordWrapping
        self.textView?.font = UIFont.preferredFont(forTextStyle: .body)
        self.backgroundView?.addSubview(self.textView!)
        self.textView?.translatesAutoresizingMaskIntoConstraints = false
        self.textView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 7.5).isActive = true
        self.textView?.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7.5).isActive = true
        self.textView?.trailingAnchor.constraint(equalTo: self.sendButton!.leadingAnchor, constant: -7.5).isActive = true
        self.textView?.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor, constant: -7.5).isActive = true
        
    }
    
    
    func updateToolbarHeightBasedOnMessage(message: String){
        
    }
    

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if #available(iOS 11.0, *) {
            if let window = self.window {
                self.bottomAnchor.constraintLessThanOrEqualToSystemSpacingBelow(window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0).isActive = true
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
