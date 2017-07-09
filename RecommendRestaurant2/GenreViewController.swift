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
    
    
    struct Item {
        var genreName = "居酒屋"
        var storeNames:[String] = []
        var storeCount = 0
    }
    
    var result1 : [Item] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //hotpepperの情報を取ってくる
        let url = URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=847b52fd31d7b663&lat=35.01&lng=135.7556&range=5&order=4&format=json&count=20")
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
            switch genreName {
            case "居酒屋":
                appDelegate.izakaya["storename"]?.append(storeName)
                appDelegate.izakaya["photo"]?.append(photoDataURL)
            case "ダイニングバー":
                appDelegate.diningbar["storename"]?.append(storeName)
                appDelegate.diningbar["photo"]?.append(photoDataURL)
            case "創作料理":
                appDelegate.sousakuryouri["storename"]?.append(storeName)
                appDelegate.sousakuryouri["photo"]?.append(photoDataURL)
            case "和食":
                appDelegate.wasyoku["storename"]?.append(storeName)
                appDelegate.wasyoku["photo"]?.append(photoDataURL)
            case "日本料理・懐石":
                appDelegate.nihonnryouri["storename"]?.append(storeName)
                appDelegate.nihonnryouri["photo"]?.append(photoDataURL)
            case "寿司":
                appDelegate.suhsi["storename"]?.append(storeName)
                appDelegate.suhsi["photo"]?.append(photoDataURL)
            case "しゃぶしゃぶ・すき焼き":
                appDelegate.syabusyabu["storename"]?.append(storeName)
                appDelegate.syabusyabu["photo"]?.append(photoDataURL)
            case "うどん・そば":
                appDelegate.udon["storename"]?.append(storeName)
                appDelegate.udon["photo"]?.append(photoDataURL)
            case "洋食":
                appDelegate.yousyoku["storename"]?.append(storeName)
                appDelegate.yousyoku["photo"]?.append(photoDataURL)
            case "ステーキ・ハンバーグ・カレー":
                appDelegate.steak["storename"]?.append(storeName)
                appDelegate.steak["photo"]?.append(photoDataURL)
            case "イタリアン・フレンチ":
                appDelegate.italian["storename"]?.append(storeName)
                appDelegate.italian["photo"]?.append(photoDataURL)
            case "パスタ・ピザ":
                appDelegate.pasta["storename"]?.append(storeName)
                appDelegate.pasta["photo"]?.append(photoDataURL)
            case "ビストロ":
                appDelegate.bistoro["storename"]?.append(storeName)
                appDelegate.bistoro["photo"]?.append(photoDataURL)
            case "中華":
                appDelegate.tyuka["storename"]?.append(storeName)
                appDelegate.tyuka["photo"]?.append(photoDataURL)
            case "広東料理":
                appDelegate.kanntouryouri["storename"]?.append(storeName)
                appDelegate.kanntouryouri["photo"]?.append(photoDataURL)
            case "四川料理":
                appDelegate.shisenn["storename"]?.append(storeName)
                appDelegate.shisenn["photo"]?.append(photoDataURL)
            case "上海料理":
                appDelegate.shanhai["storename"]?.append(storeName)
                appDelegate.shanhai["photo"]?.append(photoDataURL)
            case "北京料理":
                appDelegate.pekinn["storename"]?.append(storeName)
                appDelegate.pekinn["photo"]?.append(photoDataURL)
            case "焼肉・韓国料理":
                appDelegate.yakiniku["storename"]?.append(storeName)
                appDelegate.yakiniku["photo"]?.append(photoDataURL)
            case "アジアン":
                appDelegate.ajian["storename"]?.append(storeName)
                appDelegate.ajian["photo"]?.append(photoDataURL)
            case "タイ・ベトナム料理":
                appDelegate.thai["storename"]?.append(storeName)
                appDelegate.thai["photo"]?.append(photoDataURL)
            case "インド料理":
                appDelegate.indo["storename"]?.append(storeName)
                appDelegate.indo["photo"]?.append(photoDataURL)
            case "スペイン・地中海料理":
                appDelegate.spein["storename"]?.append(storeName)
                appDelegate.spein["photo"]?.append(photoDataURL)
            case "カラオケ":
                appDelegate.karaoke["storename"]?.append(storeName)
                appDelegate.karaoke["photo"]?.append(photoDataURL)
            case "バー・カクテル":
                appDelegate.bar["storename"]?.append(storeName)
                appDelegate.bar["photo"]?.append(photoDataURL)
            case "ラーメン":
                appDelegate.ramenn["storename"]?.append(storeName)
                appDelegate.ramenn["photo"]?.append(photoDataURL)
            case "カフェ":
                appDelegate.cafe["storename"]?.append(storeName)
                appDelegate.cafe["photo"]?.append(photoDataURL)
            case "スイーツ":
                appDelegate.sweets["storename"]?.append(storeName)
                appDelegate.sweets["photo"]?.append(photoDataURL)
            case "お好み焼き・もんじゃ・鉄板焼き":
                appDelegate.okonomiyaki["storename"]?.append(storeName)
                appDelegate.okonomiyaki["photo"]?.append(photoDataURL)
            default:
            print("不明のジャンルが入りました")
            }
           
            }
            
            
            
//            appDelegate.izakaya["storename"] = izakayaStoreNames
//            appDelegate.izakaya["photo"] = izakayaPhotos

            
            
            var amountDictionary:NSDictionary = ["居酒屋":appDelegate.izakaya["storename"]!,"ダイニングバー":appDelegate.diningbar["storename"]!,"創作料理":appDelegate.sousakuryouri["storename"]!,"和食":appDelegate.wasyoku["storename"]!,"日本料理・懐石":appDelegate.nihonnryouri["storename"]!,"寿司":appDelegate.suhsi["storename"]!,"しゃぶしゃぶ・すき焼き":appDelegate.syabusyabu["storename"]!,"うどん・そば":appDelegate.udon["storename"]!,"洋食":appDelegate.yousyoku["storename"]!,"ステーキ・ハンバーグ・カレー":appDelegate.steak["storename"]!,"イタリアン":appDelegate.italian["storename"]!,"フレンチ":appDelegate.french["storename"]!,"パスタ・ピザ":appDelegate.pasta["storename"]!,"ビストロ":appDelegate.bistoro["storename"]!,"中華":appDelegate.tyuka["storename"]!,"広東料理":appDelegate.kanntouryouri["storename"]!,"四川料理":appDelegate.shisenn["storename"]!,"上海料理":appDelegate.shanhai["storename"]!,"北京料理":appDelegate.pekinn["storename"]!,"焼肉":appDelegate.yakiniku["storename"]!,"韓国料理":appDelegate.kannkokuryouri["storename"]!,"アジアン":appDelegate.ajian["storename"]!,"タイ・ベトナム料理":appDelegate.thai["storename"]!,"インド料理":appDelegate.indo["storename"]!,"スペイン・地中海料理":appDelegate.spein["storename"]!,"カラオケ":appDelegate.karaoke["storename"]!,"バー・カクテル":appDelegate.bar["storename"]!,"ラーメン":appDelegate.ramenn["storename"]!,"カフェ":appDelegate.cafe["storename"]!,"スイーツ":appDelegate.sweets["storename"]!,"お好み焼き・もんじゃ・鉄板焼き":appDelegate.okonomiyaki["storename"]!]
            
            var amountArray: NSArray = [appDelegate.izakaya["storename"]!,appDelegate.diningbar["storename"]!,appDelegate.sousakuryouri["storename"]!,appDelegate.wasyoku["storename"]!,appDelegate.nihonnryouri["storename"]!,appDelegate.suhsi["storename"]!,appDelegate.syabusyabu["storename"]!,appDelegate.udon["storename"]!,appDelegate.yousyoku["storename"]!,appDelegate.steak["storename"]!,appDelegate.italian["storename"]!,appDelegate.french["storename"]!,appDelegate.pasta["storename"]!,appDelegate.bistoro["storename"]!,appDelegate.tyuka["storename"]!,appDelegate.kanntouryouri["storename"]!,appDelegate.shisenn["storename"]!,appDelegate.shanhai["storename"]!,appDelegate.pekinn["storename"]!,appDelegate.yakiniku["storename"]!,appDelegate.kannkokuryouri["storename"]!,appDelegate.ajian["storename"]!,appDelegate.thai["storename"]!,appDelegate.indo["storename"]!,appDelegate.spein["storename"]!,appDelegate.karaoke["storename"]!,appDelegate.bar["storename"]!,appDelegate.ramenn["storename"]!,appDelegate.cafe["storename"]!,appDelegate.sweets["storename"]!,appDelegate.okonomiyaki["storename"]!]
            

            
//            var amountArray: NSArray = [appDelegate.izakaya["storename"],appDelegate.diningbar["storename"],appDelegate.sousakuryouri["storename"]] as! NSArray
            
            
            var genreNames = ["居酒屋", "ダイニングバー", "創作料理", "和食", "日本料理・懐石", "寿司", "しゃぶしゃぶ・すき焼き", "うどん・そば", "洋食", "ステーキ・ハンバーグ・カレー", "イタリアン" ,"フレンチ" ,"パスタ・ピザ" ,"ビストロ", "中華", "広東料理", "四川料理", "上海料理", "北京料理", "焼肉", "韓国料理", "アジアン", "タイ・ベトナム料理", "インド料理", "スペイン・地中海料理", "カラオケ", "バー・カクテル", "ラーメン", "カフェ", "スイーツ", "お好み焼き・もんじゃ・鉄板焼き"]
            
           
            
            var num1 = genreNames.count

            var items: [Item] = []
            
            for n in 0...genreNames.count - 1 {
            
                if (amountArray[n] as AnyObject).count != 0 {
                items.append(Item(genreName: genreNames[n], storeNames: amountArray[n] as! [String], storeCount: (amountArray[n] as AnyObject).count))
                }
            }
//            let items: [Item] = [
//                Item(genreName: genreNames[0], storeNames: amountArray[0] as! [String], storeCount: (amountArray[0] as AnyObject).count),
//                Item(genreName: genreNames[1], storeNames: amountArray[1] as! [String], storeCount: (amountArray[1] as AnyObject).count),
//                Item(genreName: genreNames[2], storeNames: amountArray[2] as! [String], storeCount: (amountArray[2] as AnyObject).count),
//                Item(genreName: genreNames[3], storeNames: amountArray[3] as! [String], storeCount: (amountArray[3] as AnyObject).count),
//                Item(genreName: genreNames[4], storeNames: amountArray[4] as! [String], storeCount: (amountArray[4] as AnyObject).count),
//                Item(genreName: genreNames[5], storeNames: amountArray[5] as! [String], storeCount: (amountArray[5] as AnyObject).count),
//                Item(genreName: genreNames[6], storeNames: amountArray[6] as! [String], storeCount: (amountArray[6] as AnyObject).count),
//                Item(genreName: genreNames[7], storeNames: amountArray[7] as! [String], storeCount: (amountArray[7] as AnyObject).count),
//                Item(genreName: genreNames[8], storeNames: amountArray[8] as! [String], storeCount: (amountArray[8] as AnyObject).count),
//                Item(genreName: genreNames[9], storeNames: amountArray[9] as! [String], storeCount: (amountArray[9] as AnyObject).count),
//                Item(genreName: genreNames[10], storeNames: amountArray[10] as! [String], storeCount: (amountArray[10] as AnyObject).count),
//                Item(genreName: genreNames[11], storeNames: amountArray[11] as! [String], storeCount: (amountArray[11] as AnyObject).count),
//                Item(genreName: genreNames[12], storeNames: amountArray[12] as! [String], storeCount: (amountArray[12] as AnyObject).count),
//                Item(genreName: genreNames[13], storeNames: amountArray[13] as! [String], storeCount: (amountArray[13] as AnyObject).count),
//                Item(genreName: genreNames[14], storeNames: amountArray[14] as! [String], storeCount: (amountArray[14] as AnyObject).count),
//                Item(genreName: genreNames[15], storeNames: amountArray[15] as! [String], storeCount: (amountArray[15] as AnyObject).count),
//                Item(genreName: genreNames[16], storeNames: amountArray[16] as! [String], storeCount: (amountArray[16] as AnyObject).count),
//                Item(genreName: genreNames[17], storeNames: amountArray[17] as! [String], storeCount: (amountArray[17] as AnyObject).count),
//                Item(genreName: genreNames[18], storeNames: amountArray[18] as! [String], storeCount: (amountArray[18] as AnyObject).count),
//                Item(genreName: genreNames[19], storeNames: amountArray[19] as! [String], storeCount: (amountArray[19] as AnyObject).count),
//                Item(genreName: genreNames[20], storeNames: amountArray[20] as! [String], storeCount: (amountArray[20] as AnyObject).count),
//                Item(genreName: genreNames[21], storeNames: amountArray[21] as! [String], storeCount: (amountArray[21] as AnyObject).count)
//            ]
//            }
//            print(items)
            
            //配列の順番をsortするのを試みる！
            typealias SortDescriptor<Value> = (Value, Value) -> Bool
//
//            
            //create method to combine some sort conditions
            func combine<Value>(sortDescriptors: [SortDescriptor<Value>]) -> SortDescriptor<Value> {

                return { lhs, rhs in
                    for isOrderedBefore in sortDescriptors {
                        if isOrderedBefore(lhs,rhs) { return true }
                        if isOrderedBefore(rhs,lhs) { return false }
                    }
                    return false
                }
            }
            
            
            let sortedByCount: SortDescriptor<Item> = { $0.storeCount > $1.storeCount }
            
            result1 = items.sorted(by: sortedByCount)
            
//            _ = result1.map {
//                print($0)
//            }
            
            print(result1)
            print(result1.count)
            
            
            
            
            
            
            
            
//            let byValue = {
//                (elem1:(key: String, val: Array), elem2:(key: String, val: Array))->Bool in
//                if elem1.val.count < elem2.val.count {
//                    return true
//                } else {
//                    return false
//                }
//            }
//            let sortedDict = amount.sort(byValue)
//          
            
            
//            amount.sorted{(object1:(key: String, val: Array), object2(key: String, val: Array)) -> Bool in
//                if object1.val.count < object2.val.count {
//                    return object1 < object2
//                } else {
//                    return object1 > object2
//                }
//            }
//        
            
//            var num = 0
//            
//            while num < amount.count {
//                if num == 0 {
//                    appDelegate.amount = []
//                }
//                if amount[num].count != 0 {
//                    appDelegate.amount.append(amount[num])
//                }
//                
//                num += 1
//            }
//            
//            print(genreArray)
//            print(appDelegate.amount)
            
            
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
        return result1.count + 1
    
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
        
            cell.textLabel?.text = result1[indexPath.row - 1].genreName
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
