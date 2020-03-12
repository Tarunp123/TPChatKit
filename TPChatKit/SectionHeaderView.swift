//
//  SectionHeaderView.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 11/10/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {


    private var dateLabel = UILabel()
    
    
    func setupHeaderViewForDate(date: Date){
        
        self.dateLabel.removeFromSuperview()

        self.dateLabel.text = date.getHeaderViewString()
        self.dateLabel.font = HEADER_DATE_FONT.withSize(HEADER_DATE_FONT_SIZE)
        self.dateLabel.textColor = HEADER_DATE_LABEL_TEXT_COLOR
        self.dateLabel.textAlignment = .center
        self.dateLabel.backgroundColor = HEADER_DATE_LABEL_BACKGROUND_COLOR
        self.dateLabel.layer.cornerRadius = 8
        self.dateLabel.clipsToBounds = true
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.dateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        let requiredSize = UILabel.getSizeToFitText(text: self.dateLabel.text!, font: self.dateLabel.font, fontPointSize: self.dateLabel.font.pointSize, maxWidth: self.frame.width, maxHeight: nil)
        self.dateLabel.widthAnchor.constraint(equalToConstant: requiredSize.width*1.5).isActive = true
        self.dateLabel.heightAnchor.constraint(equalToConstant: requiredSize.height*1.5).isActive = true
        
    }
    

}
