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
    var attachmentButton: UIButton?
    private var sendButtonWidthConstraint : NSLayoutConstraint?
//    private var attachmentButtonWidthConstraint: NSLayoutConstraint?
//    private var textViewLeadingConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.autoresizingMask = .flexibleHeight
        self.setupBackgroundView()
        self.setupToolbarItems()
    }
    
    private func setupBackgroundView(){
        self.backgroundView = UIView(frame: self.frame)
        self.backgroundView?.backgroundColor = UIColor.groupTableViewBackground
        self.addSubview(self.backgroundView!)
        self.backgroundView?.translatesAutoresizingMaskIntoConstraints =  false
        self.backgroundView?.autoresizingMask = .flexibleHeight
        self.backgroundView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.backgroundView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.backgroundView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.backgroundView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    

    
    private func setupToolbarItems(){

        //Send Button
        self.sendButton = UIButton()
        self.sendButton?.setBackgroundImage(UIImage(named: "sendMsgBtn0"), for: .disabled)
        self.sendButton?.setBackgroundImage(UIImage(named: "sendMsgBtn0")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.sendButton?.setBackgroundImage(UIImage(named: "sendMsgBtn1")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.highlighted)
        self.sendButton?.imageView?.tintColor = .systemBlue
        self.backgroundView?.addSubview(self.sendButton!)
        self.sendButton?.translatesAutoresizingMaskIntoConstraints = false
        self.sendButton?.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -7.5).isActive = true
        self.sendButton?.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12.5).isActive = true
        self.sendButtonWidthConstraint = self.sendButton?.widthAnchor.constraint(equalToConstant: 0)
        self.sendButtonWidthConstraint?.isActive = true
        self.sendButton?.heightAnchor.constraint(equalToConstant: TOOLBAR_BUTTON_HEIGHT).isActive = true

        //Attachment button
        self.attachmentButton = UIButton()
        self.attachmentButton?.setBackgroundImage(UIImage(named: "attachmentIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        self.attachmentButton?.tintColor = .systemBlue
        self.backgroundView?.addSubview(self.attachmentButton!)
        self.attachmentButton?.translatesAutoresizingMaskIntoConstraints = false
        self.attachmentButton?.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 7.5).isActive = true
        self.attachmentButton?.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -12.5).isActive = true
        self.attachmentButton?.widthAnchor.constraint(equalToConstant: TOOLBAR_BUTTON_WIDTH).isActive = true
        self.attachmentButton?.heightAnchor.constraint(equalToConstant: TOOLBAR_BUTTON_HEIGHT).isActive = true
        
        //Text field
        self.textView = UITextView()
        self.textView?.backgroundColor = TOOLBAR_TEXTVIEW_BACKGROUND_COLOR
        self.textView?.layer.cornerRadius = 8
        self.textView?.text = INPUT_FIELD_PLACEHOLDER
        self.textView?.textColor = TOOLBAR_TEXTVIEW_PLACEHOLDER_COLOR
        self.textView?.textContainer.lineBreakMode = .byWordWrapping
        self.textView?.font = MESSAGE_TEXT_FONT
        self.textView?.isScrollEnabled = false
        self.textView?.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        self.backgroundView?.addSubview(self.textView!)
        self.textView?.translatesAutoresizingMaskIntoConstraints = false
        self.textView?.topAnchor.constraint(equalTo: self.topAnchor, constant: 7.5).isActive = true
        self.textView?.leadingAnchor.constraint(equalTo: self.attachmentButton!.trailingAnchor, constant: 7.5).isActive = true
        self.textView?.trailingAnchor.constraint(equalTo: self.sendButton!.leadingAnchor, constant: -7.5).isActive = true
        self.textView?.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -7.5).isActive = true
        
    }
    
    override var intrinsicContentSize: CGSize {
        get{
            let requiredHeight = self.textView!.sizeThatFits(CGSize(width: self.textView!.bounds.width, height: TOOLBAR_MAX_HEIGHT - 15)).height
            return CGSize(width: self.bounds.width, height: requiredHeight + 15 > TOOLBAR_MAX_HEIGHT ? TOOLBAR_MAX_HEIGHT : requiredHeight + 15)
        }
    }
    
    
    func updateToolbar(){
        print(#function)
        self.invalidateIntrinsicContentSize()
        
        //enable or disable scroll for text view
        if(self.frame.height >= TOOLBAR_MAX_HEIGHT){
            self.textView?.isScrollEnabled = true
        }else{
            self.textView?.isScrollEnabled = false
        }
        
        //update elements
        let cleanedText = self.textView?.text.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        UIView.animate(withDuration: 1) {
            if cleanedText.isEmpty || cleanedText.elementsEqual(INPUT_FIELD_PLACEHOLDER) {  //Input bar is empty
                self.sendButtonWidthConstraint?.constant = 0
            }else { //Input bar is not empty
                self.sendButtonWidthConstraint?.constant = TOOLBAR_BUTTON_WIDTH
            }
        }

    }
    

    
//    override func didMoveToWindow() {
//        super.didMoveToWindow()
//        if #available(iOS 11.0, *) {
//            if let window = self.window {
//                self.bottomAnchor.constraintLessThanOrEqualToSystemSpacingBelow(window.safeAreaLayoutGuide.bottomAnchor, multiplier: 1.0).isActive = true
//            }
//        }
//    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
