//
//  TPChatViewController.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 7/25/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit



class TPChatViewController: UIViewController, UITextViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    //Initializing with dummy data
    private var me : TPPerson! = TPPerson(id: "1", name: "Tarun Prajapati")
    private var otherParticipants : [TPPerson] = [TPPerson(id: "3", name: "John Smith", senderNameFontColor: .orange), TPPerson(id: "2", name: "Carl Jhonson", senderNameFontColor: UIColor(red: 0, green: 173/255.0, blue: 197/255.0, alpha: 1.0))]
    
    
    private lazy var dummyMsgs : [TPMessage] = [TPTextMessage(id: "1", text: "Hi John and Carl", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "2", text: "Hey Tarun", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "3", text: "Hey man", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "4", text: "Wassup", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "5", text: "Have you heard of TPChatKit?", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "6", text: "What is it?🤔", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "7", text: "Sounds like a UI Kit🤔", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "8", text: "It's a cool chat kit that you can use in your iOS App to add chat functionality in very less time😎", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "9", text: "It will really accelerate your app's developement process🚀", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "10", text: "Wow!!🤩", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "11", text: "Do you have it's link or something?", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "12", text: "Sure! Here's the link - https://github.com/Tarunp123/TPChatKit", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "13", text: "Thanks Tarun! Will definitely check it out!😍", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "14", text: "Will definitely check it out!😍", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "15", text: "Hey Tarun! Is this your framework?", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "16", text: "??", timestamp: nil, sender: self.otherParticipants[1], category: .Incoming),
                                                  TPTextMessage(id: "17", text: "Yup", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "18", text: "How is it?", timestamp: nil, sender: me, category: .Outgoing),
                                                  
                                                  
                                                ]
    
    private lazy var messages : [TPMessage] = []
    
    //View
    private var chatView : TPChatView?

    lazy var toolbar : TPChatViewToolbar =  {
        let toolbar = TPChatViewToolbar(frame: CGRect(x: 0, y: 0, width: self.chatView!.frame.width, height: TOOLBAR_HEIGHT))
        toolbar.sendButton?.addTarget(self, action: #selector(didClickSendButton(sender:)), for: .touchUpInside)
        toolbar.sendButton?.isEnabled = false
        toolbar.textView?.delegate = self
        return toolbar
    }()
    
    
    //MARK: Initializers
    
    init(chatType: TPChatType) {
        super.init(nibName: nil, bundle: nil)
        
        currentChatType = chatType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: View LifeCycle Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Intializing View
        self.chatView = TPChatView(frame: self.view.bounds)
        self.view = self.chatView!
        self.chatView!.messagesCollectionView?.delegate = self
        self.chatView!.messagesCollectionView?.dataSource = self
        self.chatView?.messagesCollectionView?.keyboardDismissMode = .interactive
        
        //Defining max width a message bubble can take
        msgBubbleMaxWidth = self.chatView!.messagesCollectionView!.frame.width * 0.80
        

        //Loading Dummy Messages
        for index in 0..<self.dummyMsgs.count{
            self.addNewMessage(message: self.dummyMsgs[index])
        }
        
        //Storing current font point size to automatically reload all the message bubbles
        //when user changes the font point size while app is running.
        currentFontPointSize = MESSAGE_TEXT_FONT_SIZE
        
    }

    

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        msgBubbleMaxWidth = size.width * 0.80

        viewSizeTransitionedAt = Date()
    
        self.chatView?.messagesCollectionView?.reloadData()
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Add Observers
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        //Configure Nav bar
        self.title = "Homies"
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationItem.largeTitleDisplayMode = .never
        
    }
    

    
    //MARK: Input Accessory View
    override var inputAccessoryView: UIView?{
        get{
            return self.toolbar
        }
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    //MARK:- App Delegate Observers
    @objc
    func applicationDidBecomeActive(){
        
        guard let currentPointSize = currentFontPointSize else{
            return
        }
        
        //Font size has not changed
        if currentPointSize == MESSAGE_TEXT_FONT_SIZE{
            return
        }
        
        //Font size has changed
        
        //Update timestamp when size of view components changed
        viewSizeTransitionedAt = Date()
        
        //update point size
        currentFontPointSize = MESSAGE_TEXT_FONT_SIZE
        
        //update input text view font
        self.toolbar.textView?.font = MESSAGE_TEXT_FONT
        
        //reload messages
        self.chatView!.messagesCollectionView?.reloadData()
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    //MARK: CollectionView DataSource methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: TPTextMessageCollectionViewCell.getCellHeightForMsg(message: messages[indexPath.row]))
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TPTextMessageCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: MESSGAE_CELL_ID, for: indexPath) as? TPTextMessageCollectionViewCell
        cell.createMessageBubbleForMessage(message: messages[indexPath.row] as! TPTextMessage)
        let longPressGR = TPLongPressGestureRecognizer(target: self, action: #selector(didLongPressMessage(gestureRecognizer: )))
        longPressGR.message = messages[indexPath.row]
        longPressGR.minimumPressDuration = MESSAGE_BUBBLE_LONG_PRESS_DURATION
        cell.messageBubble.addGestureRecognizer(longPressGR)
        return cell;
    }
    
    
    //MARK:- CollectionView Delegate methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.longPressedMessageBubble = nil
        self.longPressedMessage = nil
    }
    
    //MARK:- Message Long Press Events
    private var longPressedMessageBubble : TPMessageBubbleView?
    private var longPressedMessage : TPMessage?
    
    @objc
    func didLongPressMessage(gestureRecognizer: TPLongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended{
            if let message = gestureRecognizer.message{
                longPressedMessage = message
                if let menu = menuForMessage(message: message), let bubbleView = gestureRecognizer.view as? TPMessageBubbleView {
                    longPressedMessageBubble = bubbleView
                    _ = bubbleView.becomeFirstResponder()
                    menu.setMenuVisible(true, animated: true)
                    menu.setTargetRect(bubbleView.bounds, in: bubbleView)
                }
                
            }
        }
    }
    
    
    //MARK:- Menu for Message
    private func menuForMessage(message: TPMessage) -> UIMenuController? {
        if let messageType = message.type{
            var menuItems = [UIMenuItem]()
            switch messageType {
            case .Text:
                let copyMenuItem = UIMenuItem(title: "Copy", action: #selector(didTapCopyMenuItem(menuItem:)))
                menuItems.append(copyMenuItem)
            }
        
            let menuController = UIMenuController.shared
            menuController.menuItems = menuItems
            return menuController
        }
        return nil
    }

    
    //MARK:- Message MenuItem Selectors
    @objc func didTapCopyMenuItem(menuItem: UIMenuItem){
        if let message = longPressedMessage{
            if let messageType = message.type{
                switch messageType {
                case .Text:
                    UIPasteboard.general.string = (message as! TPTextMessage).text
                }
            }
        }
    }
        
        
    
    //MARK:- Add New Messages
    func addNewMessage(message: TPMessage) {
        let newMessage = message
        
        //Updating isPreviousMessageFromThisSender for new Message
        if let lastMessage = self.messages.last{
            if lastMessage.sender == message.sender{
                newMessage.isPreviousMessageFromThisSender =  true
            }else{
                newMessage.isPreviousMessageFromThisSender =  false
            }
        }
        
        self.messages.append(newMessage)
        self.chatView?.messagesCollectionView?.reloadData()
        self.chatView?.messagesCollectionView?.scrollToBottom()
    }
    
    
    //MARK:- Send Button Targets
    @IBAction func didClickSendButton(sender: UIButton){
        let newMessage = TPTextMessage(id: "\(self.messages.count)", text: self.toolbar.textView!.text!.trimmingCharacters(in: .whitespacesAndNewlines), timestamp: Date(), sender: me, category: .Outgoing)
        self.addNewMessage(message: newMessage)
        self.toolbar.textView?.text = ""
        self.toolbar.updateToolbarHeight()
        self.toolbar.sendButton?.isEnabled = false        
    }
    
    
    //MARK:- TextView Delegates
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text).trimmingCharacters(in: .whitespacesAndNewlines)
        
        //activate or deactivate the send button
        self.toolbar.sendButton?.isEnabled = updatedText.count > 0
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //Update toolbar height
        self.toolbar.updateToolbarHeight()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == INPUT_FIELD_PLACEHOLDER{
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == ""{
            textView.text = INPUT_FIELD_PLACEHOLDER
            textView.textColor = UIColor.lightGray
        }
        self.toolbar.updateToolbarHeight()
    }
    
    
    
    //MARK:- Keyboard events
    @objc func handleKeyboardNotification(notification: NSNotification){
        
        if notification.name == UIResponder.keyboardWillHideNotification{
            self.chatView?.messagesCollectionView?.contentInset = UIEdgeInsets.zero
        }else if notification.name == UIResponder.keyboardWillChangeFrameNotification{
            guard let userInfo = notification.userInfo else{
                return
            }

            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            self.chatView?.messagesCollectionView?.contentInset = .init(top: 0, left: 0, bottom: keyboardViewEndFrame.height - TOOLBAR_HEIGHT + PADDING_BETWEEN_CELLS_FROM_DIFFERENT_USERS, right: 0)
            self.chatView?.messagesCollectionView?.scrollIndicatorInsets = self.chatView!.messagesCollectionView!.contentInset
            self.chatView?.messagesCollectionView?.scrollToBottom()
        }
    
    }
    
    
    
    
}

