//
//  TableViewCell.swift
//  Card
//
//  Created by 中村泰輔 on 2019/08/15.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    // 顔の画像を受け取る変数
    @IBOutlet weak var faceImageView: UIImageView!
    // 名前ラベル
    @IBOutlet weak var nameLabel: UILabel!
    // 職業ラベル
    @IBOutlet weak var occupationLabel: UILabel!
    // 出身地ラベル
    @IBOutlet weak var birthplaceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
