//
//  LikedListTableViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class LikedListTableViewController: UITableViewController {

    // いいね」された名前の一覧
    var likedUser: [[String : String]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // xibをこのテーブルビューのセルに接続
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: "Cell")
        
    }

    // 必須:セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedUser.count
    }
    // セルの高さを設定
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    // 必須:セルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        // いいねされた人物のデータを代入し表示
        cell.faceImageView?.image = UIImage(named: likedUser[indexPath.row]["imageName"] ?? "")
        cell.nameLabel?.text = likedUser[indexPath.row]["name"]
        cell.occupationLabel?.text = likedUser[indexPath.row]["job"]
        cell.birthplaceLabel?.text = likedUser[indexPath.row]["place"]
        // 戻り値
        return cell
    }

}
