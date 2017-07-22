//
//  customeCell.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/07/14.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var title:UILabel!
    @IBOutlet var image:UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
}
