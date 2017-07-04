//
//  GenreViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var genre = ["","sake","japanese","french","ramen"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    //選択した行が何番目かを保存するための数字
    var selectedIndex = -1
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    //cellの個数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genre.count
    }
    
    //cellの中身を決める
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row{
            
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            
            //cell accesoryType decision
            cell.accessoryType = .none
            
            //top cell text 料理ジャンルを選択
            cell.textLabel?.text = "料理ジャンルを選択"
            
            //top cell textcolor change
            cell.textLabel?.textColor = UIColor.white
            
            //top cell backgournd color change
            cell.backgroundColor = UIColor.blue
            
            return cell
            
        default:
            
            //cell create
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
            //cell accesoryType decision
            cell.accessoryType = .disclosureIndicator
        
            cell.textLabel?.text = genre[indexPath.row]
        
            return cell
            
        }
    }
    
    //cellが押された時に実行するメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //選択された行番号をメンバ変数に格納
        selectedIndex = indexPath.row
        
        if selectedIndex == 0 {
            return
        }
        else {
        //セグエを指定して画面移動
        self.performSegue(withIdentifier: "showDetail", sender: nil)
        }
    }
    
    //segueを使って画面移動する時に実行される（そのメソッドをoverrideで書き換えてる）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //次の画面をインスタンス化(as:ダウンキャスト型変換)
        var vc = segue.destination as! ViewController
        
        //次の画面のプロパティに選択された行番号を指定
        vc.sIndex = selectedIndex
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
