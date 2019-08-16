//
//  ViewController.swift
//  Card
//
//  Created by 原田悠嗣 on 2019/08/10.
//  Copyright © 2019 原田悠嗣. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // viewの動作をコントロールする
    @IBOutlet weak var baseCard: UIView!
    // スワイプ中にgood or bad の表示
    @IBOutlet weak var likeImage: UIImageView!
    // ユーザーカード
    
    @IBOutlet weak var person1: UIView!
    @IBOutlet weak var personImageView1: UIImageView!
    @IBOutlet weak var personName1: UILabel!
    @IBOutlet weak var personJob1: UILabel!
    @IBOutlet weak var personPlace1: UILabel!
    
    @IBOutlet weak var person2: UIView!
    @IBOutlet weak var personImageView2: UIImageView!
    @IBOutlet weak var personName2: UILabel!
    @IBOutlet weak var personJob2: UILabel!
    @IBOutlet weak var personPlace2: UILabel!
    
    // 「いいね」をされた名前の配列
    var likedName: [String] = []
    // ベースカードの中心
    var centerOfCard: CGPoint!
    // ユーザーカードの配列
    var personList: [UIView] = []
    // どちらのビューを表示させるか
    var selectedCardCount: Int = 0
    // 現在表示させているユーザーリストの番号
    var showUserCount : Int = 0
    // 次に表示させるユーザーリストの番号
    var nextShowUserCount : Int = 2
    
    // ユーザーリストデータ
    let userList: [UserData] = [
        UserData(imageView: #imageLiteral(resourceName: "津田梅子"), name: "津田梅子",job: "教師", place: "千葉", backgroundColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)),
        UserData(imageView: #imageLiteral(resourceName: "ジョージワシントン"), name: "ジョージワシントン", job: "大統領", place: "アメリカ", backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)),
        UserData(imageView: #imageLiteral(resourceName: "ガリレオガリレイ"), name: "ガリレオガリレイ", job: "物理学者", place: "アメリカ", backgroundColor: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)),
        UserData(imageView: #imageLiteral(resourceName: "板垣退助"), name: "板垣退助", job: "議員", place: "高知", backgroundColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)),
        UserData(imageView: #imageLiteral(resourceName: "ジョン万次郎"), name: "ジョン万次郎", job: "冒険家", place: "アメリカ", backgroundColor:#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1) )
    ]
    
    // viewのレイアウト処理が完了した時に呼ばれる
    override func viewDidLayoutSubviews() {
        // ベースカードの中心を代入
        centerOfCard = baseCard.center
    }
    
    // ロード完了時に呼ばれる
    override func viewDidLoad() {
        super.viewDidLoad()
        // personListにperson1から5を追加
        personList.append(person1)
        personList.append(person2)
        
        settingCard()
        
    }
    // セグエによる遷移前に呼ばれる
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToLikedList" {
            let vc = segue.destination as! LikedListTableViewController
            // LikedListTableViewControllerのlikedName(左)にViewCountrollewのLikedName(右)を代入
            vc.likedName = likedName
        }
    }
    // 完全に遷移が行われ、スクリーン上からViewControllerが表示されなくなったときに呼ばれる
    override func viewDidDisappear(_ animated: Bool) {
        settingCard()
    }
    
    func settingCard() {
        // カウント初期化
        selectedCardCount = 0
        showUserCount = 0
        nextShowUserCount = 2
        
        // リスト初期化
        likedName = []
        // ビューを元に戻す
        self.view.sendSubviewToBack(person2)
        // alpha値を元に戻す
        person1.alpha = 1
        person2.alpha = 1
        // 一枚目の人物をViewに表示
        setUserCard(showUserNum: 0)
        // Viewに次のものに変更
        selectedCardCount = 1
        // 二枚目のViewに遷移
        setUserCard(showUserNum: 1)
        // カウントを元に戻す
        selectedCardCount = 0
        
    }
    // 次のカードへの遷移
    func nextCard(){
        // 画面を背面に持っていく
        self.view.sendSubviewToBack(personList[selectedCardCount])
        // カードの角度と位置を元に戻す
        personList[selectedCardCount].center = centerOfCard
        personList[selectedCardCount].transform = .identity
        
        // 全てのViewがデータを読み取り終わった際の処理
        if nextShowUserCount < userList.count {
            
            setUserCard(showUserNum : nextShowUserCount)
        } else {
            // Viewを真っ白にする
            person2.alpha = 0
        }
        showUserCount += 1
        nextShowUserCount += 1
        
        if showUserCount >= userList.count {
            person1.alpha = 0
            // 遷移処理
            performSegue(withIdentifier: "ToLikedList", sender: self)
        }
        
        selectedCardCount = showUserCount % 2
    }
    
    // ベースカードを元に戻す
    func resetCard() {
        // 位置を戻す
        baseCard.center = centerOfCard
        // 角度を戻す
        baseCard.transform = .identity
        
    }
    
    // 表示されるViewにどのデータを入れるかを定める
    func setUserCard(showUserNum : Int){
        // 表示されているユーザーのカードを格納
        let user = userList[showUserNum]
        // 表示されるViewについてデータを入れていく
        if selectedCardCount == 0 {
            // 背景色
            person1.backgroundColor = user.backgroundColor
            // 名前
            personName1.text = user.name
            // 仕事
            personJob1.text = user.job
            // 出身地
            personPlace1.text = user.place
            // 画像表示
            personImageView1.image = user.imageView
            
        } else {
            // 背景色
            person2.backgroundColor = user.backgroundColor
            // 名前
            personName2.text = user.name
            // 仕事
            personJob2.text = user.job
            // 出身地
            personPlace2.text = user.place
            // 画像表示
            personImageView2.image = user.imageView
        }
        
    }
    
    // スワイプ処理
    @IBAction func swipeCard(_ sender: UIPanGestureRecognizer) {
        // ベースカード
        let card = sender.view!
        // 動いた距離
        let point = sender.translation(in: view)
        // 取得できた距離をcard.centerに加算
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        // ユーザーカードにも同じ動きをさせる
        personList[selectedCardCount].center = CGPoint(x: card.center.x + point.x, y:card.center.y + point.y)
        // 元々の位置と移動先との差
        let xfromCenter = card.center.x - view.center.x
        // 角度をつける処理
        card.transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        // ユーザーカードに角度をつける
        personList[selectedCardCount].transform = CGAffineTransform(rotationAngle: xfromCenter / (view.frame.width / 2) * -0.785)
        
        // likeImageの表示のコントロール
        if xfromCenter > 0 {
            // goodを表示
            likeImage.image = #imageLiteral(resourceName: "いいね")
            likeImage.isHidden = false
        } else if xfromCenter < 0 {
            // badを表示
            likeImage.image = #imageLiteral(resourceName: "よくないね")
            likeImage.isHidden = false
        }
        
        // 元の位置に戻す処理
        if sender.state == UIGestureRecognizer.State.ended {
            
            if card.center.x < 50 {
                // 左に大きくスワイプしたときの処理
                skipCard(distance: -500, button: nil)
                // likeImageを隠す
                likeImage.isHidden = true
                
            } else if card.center.x > self.view.frame.width - 50 {
                // likeImageを隠す
                likeImage.isHidden = true
                // いいねリストに追加
                likedName.append(userList[showUserCount].name)
                skipCard(distance: 500, button: nil)
                
            } else {
                // アニメーションをつける
                UIView.animate(withDuration: 0.5, animations: {
                    // ユーザーカードを元の位置に戻す
                    self.personList[self.selectedCardCount].center = self.centerOfCard
                    // ユーザーカードの角度を元の位置に戻す
                    self.personList[self.selectedCardCount].transform = .identity
                    // ベースカードの角度と位置を戻す
                    self.resetCard()
                    // likeImageを隠す
                    self.likeImage.isHidden = true
                })
            }
        }
    }
    
    // カードを飛ばす処理をまとめる
    func skipCard(distance: CGFloat, button: UIButton?) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.resetCard()
            self.personList[self.selectedCardCount].center = CGPoint(x:self.personList[self.selectedCardCount].center.x + distance, y:self.personList[self.selectedCardCount].center.y)
        })
        // ボタンを連打させない、スワイプしている時に起こるバグを防ぐ
        button?.isEnabled = false
        // ボタンを使えなくする
        if button != nil {
            // 遷移している際に0.5秒間をdelayさせる
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:{
                // 次のカードヘボ処理
                self.nextCard()
                // ボタンを使用可能にする
                button?.isEnabled = true
            })
            
        } else {
            // 次のカードヘの処理
            nextCard()
        }
        // リセット
        resetCard()
    }
    
    // よくないねボタン
    @IBAction func dislikeButtonTapped(_ sender: UIButton) {
        // dislikeの際に飛ばす数値を設定
        skipCard(distance: -500, button: sender)
    }
    
    // いいねボタン
    @IBAction func likeButtonTaped(_ sender: UIButton) {
        sender.isEnabled = false
        // いいねリストに追加
        likedName.append(userList[showUserCount].name)
        // likeの際に飛ばす数値を設定
        skipCard(distance: 500, button: sender)
    }
}

