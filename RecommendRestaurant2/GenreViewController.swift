//
//  GenreViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    
    //選択した行が何番目かを保存するための数字
    var selectedIndex = -1
    
    //料理のジャンルを入れる配列
    var genreArray: [String] = ["",]

    //料理の写真を保存する配列
    var foodPictures: [URL] = []
    
    //データ型で写真を保存する配列
    var fodPicturesData: [Data] = []
    
    //店名を保存する配列
    var storeNameArray : [String] = []
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //hotpepperの情報を取ってくる
        let url = URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=847b52fd31d7b663&lat=34.67&lng=135.52&range=5&order=4&format=json&count=20")
        let request = URLRequest(url: url!)
        let jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        let jsonDic = (try! JSONSerialization.jsonObject(with: jsondata, options: [])) as! NSDictionary
        
        do{
        var result:NSDictionary
        result = jsonDic["results"] as! NSDictionary
        //
        var resultArray:NSArray
        resultArray = result["shop"] as! NSArray
            
        var number = 0
        var izakayaStoreNames: [String] = []
        var izakayaPhotos: [URL] = []
        
        while number < resultArray.count {
            var eachStoreInfomation:NSDictionary
            eachStoreInfomation = resultArray[number] as! NSDictionary
        //            print(rest2Name)
        
        //            storeName.text = rest2Name
        //
            var storeName:String
            storeName = eachStoreInfomation["name"] as! String
            
            //店の名前をstoreArray配列に追加
            storeNameArray.append(storeName)
                
            let genreDictionary:NSDictionary = eachStoreInfomation["genre"] as! NSDictionary
            let genreName:String = genreDictionary["name"] as! String
            
            //ジャンル名をgenreArray配列に追加
            genreArray.append(genreName)
            
            //写真の情報をAPIから取ってくる
            let photoDictionary:NSDictionary = eachStoreInfomation["photo"] as! NSDictionary
            let photoDictionaryPc:NSDictionary = photoDictionary["pc"] as! NSDictionary
            let photoDataString:String = photoDictionaryPc["l"] as! String
            let photoDataURL:URL = URL(string: photoDataString)!
            
            //URL型の写真の情報をfoodPictures配列に保存
            foodPictures.append(photoDataURL)
                
            //配列の要素数取り出すための処理
            number += 1
                
                
                
            //データをジャンルごとに保存していく
            if genreName == "居酒屋" {
                izakayaStoreNames.append(storeName)
                izakayaPhotos.append(photoDataURL)
                    
            }
                 
                
            }
            
                
            
            
            appDelegate.izakaya["storename"] = izakayaStoreNames
            appDelegate.izakaya["photo"] = izakayaPhotos

            print(appDelegate.izakaya)
            
//            var photoData:Array = appDelegate.izakaya["photo"] as! NSArray as Array
            
            
            
            
//            
//            
//            var num = 0
//            
//            while num < photoData.count {
//            //写真をdata型の配列に保存する
//            let catPictureURL = URL(string: photoData[num] as! String) // We can force unwrap because we are 100% certain the constructor will not return nil in this case.
//            
//            let session = URLSession(configuration: .default)
//            
//            // Define a download task. The download task will download the contents of the URL as a Data object and then you can do what you wish with that data.
//            let downloadPicTask = session.dataTask(with: catPictureURL!) { (data, response, error) in
//                // The download has finished.
//                if let e = error {
//                    print("Error downloading cat picture: \(e)")
//                } else {
//                    // No errors found.
//                    // It would be weird if we didn't have a response, so check for that too.
//                    if let res = response as? HTTPURLResponse {
//                        print("Downloaded cat picture with response code \(res.statusCode)")
//                        if let imageData = data {
//                            // Finally convert that Data into an image and do what you wish with it.
//                            let image = UIImage(data: imageData)
//                            
//                            self.fodPicturesData.append(imageData)
//                            
//
//                        } else {
//                            print("Couldn't get image: Image is nil")
//                        }
//                    } else {
//                        print("Couldn't get response code for some reason")
//                    }
//                }
//                }
//            
//            downloadPicTask.resume()
//            
//            }
//                
//                print(fodPicturesData)
//            
//            
            
        //
        }catch{
            
        }

       
        
        
        
        //            print(rest2Name)
        
        //            storeName.text = rest2Name
        //
//        var name:String
//        name = rest2Name["name"] as! String
//        print(name)

//        print(storeName)
//        print(genreArray)
//        print(foodPictures)
        
        
        
        
        
        
    }

    //cellの個数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genreArray.count
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
        
            cell.textLabel?.text = genreArray[indexPath.row]
        
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
        
        vc.restaurantName = appDelegate.izakaya["storename"] as! [String]
//
//        vc.myPicures = foodPictures
    }
    
    
//    func get_image(_ url_str:String, _ imageView:UIImageView,num:Int) {
//        let url:URL = URL(string: )
//    }
//    
    
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
