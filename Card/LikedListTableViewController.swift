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
       
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil),forCellReuseIdentifier: "Cell")
        
    }

    // MARK: - Table view data source

    // 必須:セルの数を返すメソッド
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // いいねされたユーザーの数
        return likedUser.count
    }
    
   


    // 必須:セルの設定
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell

        // いいねされた名前を表示
        cell.faceImageView?.image = UIImage(named: likedUser[indexPath.row]["imageName"] ?? "")
        cell.nameLabel?.text = likedUser[indexPath.row]["name"]
        cell.occupationLabel?.text = likedUser[indexPath.row]["job"]
        cell.birthplaceLabel?.text = likedUser[indexPath.row]["place"]
        return cell
    }

}
