//
//  ViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
    //GenreViewControllerから送られた情報を保存
    var sIndex = 0
    
    //仮の店名の保存（後でぐるなびのAPIから持ってくる）
    var restaurantName = ["jolibeee","chawokey","coffeeshop","oishi"]
    
    //店が何番目かを保存する数
    var num = 0
    
    //店の情報が載ったUIViewの作成
    var baseView:UIView = UIView(frame: CGRect(x: 100, y: 100, width: 250, height: 350))
    
    //写真の情報を保存
    var myPicures:[String] = ["","izakaya","wasyoku","yousyoku","ra-menn"]
    
    //写真を置くUIImageViewの作成
    var myPicture:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
    
    //viewの中に店名を表記
    var myLabel:UILabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        //判別するために色をつける
        baseView.backgroundColor = UIColor.green
        
        print(sIndex)
        //写真の中身を決める
        myPicture.image = UIImage(named : myPicures[sIndex] + ".jpeg")
        
        //labelの中身を決める
        myLabel.text = "\(restaurantName[num])"
        
        //元々のviewの上に作成したbaseViewを載せる
        self.view.addSubview(baseView)
        
        // baseViewの上にmyPictureを載せる
        self.baseView.addSubview(myPicture)
        
        //baseViewの上にmyLabelを配置
        self.baseView.addSubview(myLabel)
 
    }
    //viewを左に飛ばして、再びviewを作成する
    @IBAction func throwAway(_ sender: UIButton) {
        
        //最後まで読まれていたら初期化する
        if self.num == 3 {
            self.num = -1
        }
        
        //重複させないための数字
        self.num += 1
        
        //numがいくつかを確認
        print(num)
        
        
        //animationで移動させる
        UIView.animate(withDuration: 1, animations: {
            self.baseView.center = CGPoint(x: self.baseView.center.x - 500, y: self.baseView.center.y + 75)
            self.myPicture.center = CGPoint(x: self.baseView.center.x - 500, y: self.baseView.center.y + 25)
            self.myLabel.center = CGPoint(x: self.baseView.center.x - 500, y: self.baseView.center.y + 25)
            
            self.baseView.alpha = 0
            self.myPicture.alpha = 0
            self.myLabel.alpha = 0
            
            self.newPage()
            
        })
        return
    }
    
    
    @IBAction func `return`(_ sender: UIButton) {
        
        if self.num == 0 {
            self.num = restaurantName.count - 1
        }
        else{
        //表示するものを元に戻すために数字を一つ減らす
        self.num -= 1
        }
        
        //numがいくつかを確認
        print(num)
        
        UIView.animate(withDuration: 1, animations: {
            
            self.baseView.alpha = 0
            self.myPicture.alpha = 0
            
            self.newPage()
        })
        return
    }
    
    @IBAction func go(_ sender: UIButton) {
        
        //最後まで読まれていたら初期化する
        if self.num == 3 {
            self.num = -1
        }

        //重複させないための数字
        self.num += 1
        
        //numがいくつかを確認
        print(num)
        
        UIView.animate(withDuration: 1, animations: {
            self.baseView.center = CGPoint(x: self.baseView.center.x + 500, y: self.baseView.center.y + 75)
            self.myPicture.center = CGPoint(x: self.baseView.center.x + 500, y: self.baseView.center.y + 25)
            self.baseView.alpha = 0
            self.myPicture.alpha = 0
            
            self.newPage()
        })
        return
        

    }
    
    func newPage(){
            //new UIView make
            self.baseView = UIView(frame: CGRect(x: 100, y: 100, width: 250, height: 350))
            self.myPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            self.myPicture.image = UIImage(named : self.myPicures[self.sIndex] + ".jpeg")
            self.myLabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 50))
            self.myLabel.text = "\(self.restaurantName[self.num])"
            
            
            
            self.baseView.backgroundColor = UIColor.green
            
            self.view.addSubview(self.baseView)
            self.baseView.addSubview(self.myPicture)
            self.baseView.addSubview(self.myLabel)
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
  
}

