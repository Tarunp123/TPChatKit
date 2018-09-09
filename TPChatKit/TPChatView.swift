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
        
        self.setupCollectionsView()
    }
    
    
    //Initializing and Configuring Messages Collection View
    private func setupCollectionsView(){
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        self.messagesCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - TOOLBAR_HEIGHT), collectionViewLayout: collectionViewLayout)
        self.messagesCollectionView?.backgroundColor = UIColor.white
        
        self.messagesCollectionView?.register(TPMessageCollectionViewCell.self, forCellWithReuseIdentifier: MESSGAE_CELL_ID)
        self.addSubview(self.messagesCollectionView!)
    }
    
    

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    

}
