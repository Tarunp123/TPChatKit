//
//  TPChatView.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 9/3/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class TPChatView: UIView {

    var messagesCollectionView : UICollectionView?
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = CHAT_VIEW_BACKGROUND_COLOR
        self.setupCollectionsView()
    }
    
    
    //Initializing and Configuring Messages Collection View
    private func setupCollectionsView(){
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        collectionViewLayout.headerReferenceSize = .init(width: self.frame.width, height: headerDateHeight+20)
        collectionViewLayout.sectionHeadersPinToVisibleBounds = true
        
        self.messagesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - TOOLBAR_HEIGHT), collectionViewLayout: collectionViewLayout)
        self.messagesCollectionView?.collectionViewLayout = collectionViewLayout
        self.messagesCollectionView?.backgroundColor = UIColor.clear//UIColor(red: 227/255.0, green: 216/255.0, blue: 218/255.0, alpha: 1.0)
        self.messagesCollectionView?.alwaysBounceVertical = true
        self.messagesCollectionView?.showsVerticalScrollIndicator = true
        self.messagesCollectionView?.showsHorizontalScrollIndicator = false
        self.messagesCollectionView?.register(TPTextMessageCollectionViewCell.self, forCellWithReuseIdentifier: TEXT_MESSGAE_CELL_ID)
        self.messagesCollectionView?.register(TPPictureMessageCollectionViewCell.self, forCellWithReuseIdentifier: PICTURE_MESSGAE_CELL_ID)
        self.addSubview(self.messagesCollectionView!)
        self.messagesCollectionView?.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HEADER_VIEW_ID)
        self.messagesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.messagesCollectionView?.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        self.messagesCollectionView?.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.messagesCollectionView?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -TOOLBAR_HEIGHT).isActive = true
        self.messagesCollectionView?.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    

}
