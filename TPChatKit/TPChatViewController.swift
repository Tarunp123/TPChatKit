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
    private var otherParticipants : [TPPerson] = [TPPerson(id: "2", name: "John Smith")]
    
    private lazy var dummyMsgs : [Messageable] = [TPTextMessage(id: "1", text: "Hi John", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "2", text: "Hey Tarun", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "3", text: "Let's catup for a movie. What do you say? 😇", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "4", text: "Sure! which one?🤫", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "5", text: "Infinity Wars?😎🤩🚀", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "6", text: "or do you have any suggestion?🤨", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "7", text: "Infinity wars sounds good! Will meet you at your place at 4:00pm 👍🏻", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "1", text: "Hi John", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "2", text: "Hey Tarun", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "3", text: "Let's catup for a movie. What do you say? 😇", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "4", text: "Sure! which one?🤫", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "5", text: "Infinity Wars?😎🤩🚀", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "6", text: "or do you have any suggestion?🤨", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "7", text: "Infinity wars sounds good! Will meet you at your place at 4:00pm 👍🏻", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "1", text: "Hi John", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "2", text: "Hey Tarun", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "3", text: "Let's catup for a movie. What do you say? 😇", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "4", text: "Sure! which one?🤫", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "5", text: "Infinity Wars?😎🤩🚀", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "6", text: "or do you have any suggestion?🤨", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "7", text: "Infinity wars sounds good! Will meet you at your place at 4:00pm 👍🏻", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "1", text: "Hi John", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "2", text: "Hey Tarun", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "3", text: "Let's catup for a movie. What do you say? 😇", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "4", text: "Sure! which one?🤫", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming),
                                                  TPTextMessage(id: "5", text: "Infinity Wars?😎🤩🚀", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "6", text: "or do you have any suggestion?🤨", timestamp: nil, sender: me, category: .Outgoing),
                                                  TPTextMessage(id: "7", text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", timestamp: nil, sender: self.otherParticipants.first!, category: .Incoming)]
    
    private lazy var messages : [Messageable] = []

    
    //View
    private var chatView : TPChatView?

    lazy var toolbar : TPChatViewToolbar =  {
        let toolbar = TPChatViewToolbar(frame: CGRect(x: 0, y: 0, width: self.chatView!.frame.width, height: TOOLBAR_HEIGHT))
        toolbar.sendButton?.addTarget(self, action: #selector(didClickSendButton(sender:)), for: .touchUpInside)
        toolbar.sendButton?.isEnabled = false
        toolbar.textView?.delegate = self
        return toolbar
    }()
    
    
    
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
        

//            for _ in 0..<100{
                for index in 0..<self.dummyMsgs.count{
                    self.messages.append(self.dummyMsgs[index])
                }
//            }
        
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
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        //Configure Nav bar
        self.title = otherParticipants.first!.name
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
        return CGSize(width: collectionView.frame.width , height: TPMessageCollectionViewCell.getCellHeightForMsg(message: messages[indexPath.row]))
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : TPMessageCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: MESSGAE_CELL_ID, for: indexPath) as! TPMessageCollectionViewCell
        cell.createMessageBubbleForMessage(message: messages[indexPath.row] as! TPTextMessage)
        return cell;
    }
    
    
    //MARK:- Send Button Targets
    @IBAction func didClickSendButton(sender: UIButton){
        let newMessage = TPTextMessage(id: "\(self.messages.count)", text: self.toolbar.textView!.text!.trimmingCharacters(in: .whitespacesAndNewlines), timestamp: Date(), sender: me, category: .Outgoing)
        self.messages.append(newMessage)
        self.chatView?.messagesCollectionView?.reloadData()
        self.chatView?.messagesCollectionView?.scrollToBottom()
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
    }
    
    //MARK:- Keyboard events
    @objc func handleKeyboardNotification(notification: NSNotification){
        
        if notification.name == NSNotification.Name.UIKeyboardWillHide{
            self.chatView?.messagesCollectionView?.contentInset = UIEdgeInsets.zero
        }else if notification.name == .UIKeyboardWillChangeFrame{
            guard let userInfo = notification.userInfo else{
                return
            }

            let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            self.chatView?.messagesCollectionView?.contentInset = .init(top: 0, left: 0, bottom: keyboardViewEndFrame.height - TOOLBAR_HEIGHT, right: 0)
            self.chatView?.messagesCollectionView?.scrollIndicatorInsets = self.chatView!.messagesCollectionView!.contentInset
            self.chatView?.messagesCollectionView?.scrollToBottom()
        }
    
    }
    
}

