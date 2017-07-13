//
//  GenreViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit
import MapKit


class GenreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    //選択した行が何番目かを保存するための数字
    var selectedIndex = -1
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //struct Itemのインスタンス作成
    var Items : [Item] = []
    
    
    var myLocationManager: CLLocationManager!
    
    var latitude:Double = 0
    
    var longitude:Double = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied{
            return
        }
        
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        
        if status == CLAuthorizationStatus.notDetermined {
            myLocationManager.requestWhenInUseAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        myLocationManager.distanceFilter = kCLDistanceFilterNone
        
        myLocationManager.requestLocation()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //hotpepperの情報を取ってくる
        let url = URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=847b52fd31d7b663&lat=35.01&lng=135.7556&range=5&order=4&format=json&count=100")
        let request = URLRequest(url: url!)
        let jsondata = (try! NSURLConnection.sendSynchronousRequest(request, returning: nil))
        let jsonDic = (try! JSONSerialization.jsonObject(with: jsondata, options: [])) as! NSDictionary
        
        do{
        //resultsキーを指定して全ての情報を取得
        var result:NSDictionary
        result = jsonDic["results"] as! NSDictionary
        
        //店の情報を取得
        var resultArray:NSArray
        resultArray = result["shop"] as! NSArray
            
        //店の情報がarray型で入ってるので、whileで回して全ての情報を取得
        var number = 0
        var izakayaStoreNames: [String] = []
        var izakayaPhotos: [URL] = []
        
        
        while number < resultArray.count {
            
            //それぞれの店の情報をeachStoreInforamtionに保存
            var eachStoreInfomation:NSDictionary
            eachStoreInfomation = resultArray[number] as! NSDictionary
        
            //店の名前をstoreNameとして保存
            let storeName: String = eachStoreInfomation["name"] as! String

            //店の住所をaddressとして保存
            let address: String = eachStoreInfomation["address"] as! String
            
            //ジャンルの名前をgenreNameとして保存
            let genreDictionary:NSDictionary = eachStoreInfomation["genre"] as! NSDictionary
            let genreName :String = genreDictionary["name"] as! String
            
            
            
            //写真の情報をAPIから取ってくる
            let photoDictionary:NSDictionary = eachStoreInfomation["photo"] as! NSDictionary
            let photoDictionaryPc:NSDictionary = photoDictionary["pc"] as! NSDictionary
            let photoDataString:String = photoDictionaryPc["l"] as! String
            let photoDataURL:URL = URL(string: photoDataString)!
            
            
            //配列の要素数取り出すための処理
            number += 1
            
            
            var items: [Item] = []

                
            //データをジャンルごとに保存する
            switch genreName {
            case "居酒屋":
                appDelegate.izakaya["storename"]?.append(storeName)
                appDelegate.izakaya["address"]?.append(address)
                appDelegate.izakaya["photo"]?.append(photoDataURL)
            case "ダイニングバー":
                appDelegate.diningbar["storename"]?.append(storeName)
                appDelegate.diningbar["address"]?.append(address)
                appDelegate.diningbar["photo"]?.append(photoDataURL)
            case "創作料理":
                appDelegate.sousakuryouri["storename"]?.append(storeName)
                appDelegate.sousakuryouri["address"]?.append(address)
                appDelegate.sousakuryouri["photo"]?.append(photoDataURL)
            case "和食":
                appDelegate.wasyoku["storename"]?.append(storeName)
                appDelegate.wasyoku["address"]?.append(address)
                appDelegate.wasyoku["photo"]?.append(photoDataURL)
            case "日本料理・懐石":
                appDelegate.nihonnryouri["storename"]?.append(storeName)
                appDelegate.nihonnryouri["address"]?.append(address)
                appDelegate.nihonnryouri["photo"]?.append(photoDataURL)
            case "寿司":
                appDelegate.suhsi["storename"]?.append(storeName)
                appDelegate.suhsi["address"]?.append(address)
                appDelegate.suhsi["photo"]?.append(photoDataURL)
            case "しゃぶしゃぶ・すき焼き":
                appDelegate.syabusyabu["storename"]?.append(storeName)
                appDelegate.syabusyabu["address"]?.append(address)
                appDelegate.syabusyabu["photo"]?.append(photoDataURL)
            case "うどん・そば":
                appDelegate.udon["storename"]?.append(storeName)
                appDelegate.udon["address"]?.append(address)
                appDelegate.udon["photo"]?.append(photoDataURL)
            case "洋食":
                appDelegate.yousyoku["storename"]?.append(storeName)
                appDelegate.yousyoku["address"]?.append(address)
                appDelegate.yousyoku["photo"]?.append(photoDataURL)
            case "ステーキ・ハンバーグ・カレー":
                appDelegate.steak["storename"]?.append(storeName)
                appDelegate.steak["address"]?.append(address)
                appDelegate.steak["photo"]?.append(photoDataURL)
            case "イタリアン・フレンチ":
                appDelegate.italian["storename"]?.append(storeName)
                appDelegate.italian["address"]?.append(address)
                appDelegate.italian["photo"]?.append(photoDataURL)
            case "パスタ・ピザ":
                appDelegate.pasta["storename"]?.append(storeName)
                appDelegate.pasta["address"]?.append(address)
                appDelegate.pasta["photo"]?.append(photoDataURL)
            case "ビストロ":
                appDelegate.bistoro["storename"]?.append(storeName)
                appDelegate.bistoro["address"]?.append(address)
                appDelegate.bistoro["photo"]?.append(photoDataURL)
            case "中華":
                appDelegate.tyuka["storename"]?.append(storeName)
                appDelegate.tyuka["address"]?.append(address)
                appDelegate.tyuka["photo"]?.append(photoDataURL)
            case "広東料理":
                appDelegate.kanntouryouri["storename"]?.append(storeName)
                appDelegate.kanntouryouri["address"]?.append(address)
                appDelegate.kanntouryouri["photo"]?.append(photoDataURL)
            case "四川料理":
                appDelegate.shisenn["storename"]?.append(storeName)
                appDelegate.shisenn["address"]?.append(address)
                appDelegate.shisenn["photo"]?.append(photoDataURL)
            case "上海料理":
                appDelegate.shanhai["storename"]?.append(storeName)
                appDelegate.shanhai["address"]?.append(address)
                appDelegate.shanhai["photo"]?.append(photoDataURL)
            case "北京料理":
                appDelegate.pekinn["storename"]?.append(storeName)
                appDelegate.pekinn["address"]?.append(address)
                appDelegate.pekinn["photo"]?.append(photoDataURL)
            case "焼肉・韓国料理":
                appDelegate.yakiniku["storename"]?.append(storeName)
                appDelegate.yakiniku["address"]?.append(address)
                appDelegate.yakiniku["photo"]?.append(photoDataURL)
            case "アジアン":
                appDelegate.ajian["storename"]?.append(storeName)
                appDelegate.ajian["address"]?.append(address)
                appDelegate.ajian["photo"]?.append(photoDataURL)
            case "タイ・ベトナム料理":
                appDelegate.thai["storename"]?.append(storeName)
                appDelegate.thai["address"]?.append(address)
                appDelegate.thai["photo"]?.append(photoDataURL)
            case "インド料理":
                appDelegate.indo["storename"]?.append(storeName)
                appDelegate.indo["address"]?.append(address)
                appDelegate.indo["photo"]?.append(photoDataURL)
            case "スペイン・地中海料理":
                appDelegate.spein["storename"]?.append(storeName)
                appDelegate.spein["address"]?.append(address)
                appDelegate.spein["photo"]?.append(photoDataURL)
            case "カラオケ":
                appDelegate.karaoke["storename"]?.append(storeName)
                appDelegate.karaoke["address"]?.append(address)
                appDelegate.karaoke["photo"]?.append(photoDataURL)
            case "バー・カクテル":
                appDelegate.bar["storename"]?.append(storeName)
                appDelegate.bar["address"]?.append(address)
                appDelegate.bar["photo"]?.append(photoDataURL)
            case "ラーメン":
                appDelegate.ramenn["storename"]?.append(storeName)
                appDelegate.ramenn["address"]?.append(address)
                appDelegate.ramenn["photo"]?.append(photoDataURL)
            case "カフェ":
                appDelegate.cafe["storename"]?.append(storeName)
                appDelegate.cafe["address"]?.append(address)
                appDelegate.cafe["photo"]?.append(photoDataURL)
            case "スイーツ":
                appDelegate.sweets["storename"]?.append(storeName)
                appDelegate.sweets["address"]?.append(address)
                appDelegate.sweets["photo"]?.append(photoDataURL)
            case "お好み焼き・もんじゃ・鉄板焼き":
                appDelegate.okonomiyaki["storename"]?.append(storeName)
                appDelegate.okonomiyaki["address"]?.append(address)
                appDelegate.okonomiyaki["photo"]?.append(photoDataURL)
            default:
            print("不明のジャンルが入りました")
            }
            }
        
        //並べ替えのため作成(店名)
        var amountArray: NSArray =
            
            [appDelegate.izakaya["storename"]!,
             appDelegate.diningbar["storename"]!,
             appDelegate.sousakuryouri["storename"]!,
             appDelegate.wasyoku["storename"]!,
             appDelegate.nihonnryouri["storename"]!,
             appDelegate.suhsi["storename"]!,
             appDelegate.syabusyabu["storename"]!,
             appDelegate.udon["storename"]!,
             appDelegate.yousyoku["storename"]!,
             appDelegate.steak["storename"]!,
             appDelegate.italian["storename"]!,
             appDelegate.french["storename"]!,
             appDelegate.pasta["storename"]!,
             appDelegate.bistoro["storename"]!,
             appDelegate.tyuka["storename"]!,
             appDelegate.kanntouryouri["storename"]!,
             appDelegate.shisenn["storename"]!,
             appDelegate.shanhai["storename"]!,
             appDelegate.pekinn["storename"]!,
             appDelegate.yakiniku["storename"]!,
             appDelegate.kannkokuryouri["storename"]!,
             appDelegate.ajian["storename"]!,
             appDelegate.thai["storename"]!,
             appDelegate.indo["storename"]!,
             appDelegate.spein["storename"]!,
             appDelegate.karaoke["storename"]!,
             appDelegate.bar["storename"]!,
             appDelegate.ramenn["storename"]!,
             appDelegate.cafe["storename"]!,
             appDelegate.sweets["storename"]!,
             appDelegate.okonomiyaki["storename"]!]

            
        //並べ替えのため作成(写真)
        var amountArray1: NSArray =
            
            [appDelegate.izakaya["photo"]!,
             appDelegate.diningbar["photo"]!,
             appDelegate.sousakuryouri["photo"]!,
             appDelegate.wasyoku["photo"]!,
             appDelegate.nihonnryouri["photo"]!,
             appDelegate.suhsi["photo"]!,
             appDelegate.syabusyabu["photo"]!,
             appDelegate.udon["photo"]!,
             appDelegate.yousyoku["photo"]!,
             appDelegate.steak["photo"]!,
             appDelegate.italian["photo"]!,
             appDelegate.french["photo"]!,
             appDelegate.pasta["photo"]!,
             appDelegate.bistoro["photo"]!,
             appDelegate.tyuka["photo"]!,
             appDelegate.kanntouryouri["photo"]!,
             appDelegate.shisenn["photo"]!,
             appDelegate.shanhai["photo"]!,
             appDelegate.pekinn["photo"]!,
             appDelegate.yakiniku["photo"]!,
             appDelegate.kannkokuryouri["photo"]!,
             appDelegate.ajian["photo"]!,
             appDelegate.thai["photo"]!,
             appDelegate.indo["photo"]!,
             appDelegate.spein["photo"]!,
             appDelegate.karaoke["photo"]!,
             appDelegate.bar["photo"]!,
             appDelegate.ramenn["photo"]!,
             appDelegate.cafe["photo"]!,
             appDelegate.sweets["photo"]!,
             appDelegate.okonomiyaki["photo"]!]
            
        var amountArray2: NSArray =
                
            [appDelegate.izakaya["address"]!,
             appDelegate.diningbar["address"]!,
             appDelegate.sousakuryouri["address"]!,
             appDelegate.wasyoku["address"]!,
             appDelegate.nihonnryouri["address"]!,
             appDelegate.suhsi["address"]!,
             appDelegate.syabusyabu["address"]!,
             appDelegate.udon["address"]!,
             appDelegate.yousyoku["address"]!,
             appDelegate.steak["address"]!,
             appDelegate.italian["address"]!,
             appDelegate.french["address"]!,
             appDelegate.pasta["address"]!,
             appDelegate.bistoro["address"]!,
             appDelegate.tyuka["address"]!,
             appDelegate.kanntouryouri["address"]!,
             appDelegate.shisenn["address"]!,
             appDelegate.shanhai["address"]!,
             appDelegate.pekinn["address"]!,
             appDelegate.yakiniku["address"]!,
             appDelegate.kannkokuryouri["address"]!,
             appDelegate.ajian["address"]!,
             appDelegate.thai["address"]!,
             appDelegate.indo["address"]!,
             appDelegate.spein["address"]!,
             appDelegate.karaoke["address"]!,
             appDelegate.bar["address"]!,
             appDelegate.ramenn["address"]!,
             appDelegate.cafe["address"]!,
             appDelegate.sweets["address"]!,
             appDelegate.okonomiyaki["address"]!]

        
            
            
        //並べ替えのための作成(ジャンル名)
        var genreNames =
            
            ["居酒屋",
             "ダイニングバー",
             "創作料理",
             "和食",
             "日本料理・懐石",
             "寿司",
             "しゃぶしゃぶ・すき焼き",
             "うどん・そば",
             "洋食",
             "ステーキ・ハンバーグ・カレー",
             "イタリアン" ,
             "フレンチ" ,
             "パスタ・ピザ" ,
             "ビストロ",
             "中華",
             "広東料理",
             "四川料理",
             "上海料理",
             "北京料理",
             "焼肉",
             "韓国料理",
             "アジアン",
             "タイ・ベトナム料理",
             "インド料理",
             "スペイン・地中海料理",
             "カラオケ",
             "バー・カクテル",
             "ラーメン",
             "カフェ",
             "スイーツ",
             "お好み焼き・もんじゃ・鉄板焼き"]
            
        //Items配列にItemインスタンスを入れていく
        for n in 0...genreNames.count - 1 {
            
            if (amountArray[n] as AnyObject).count != 0 {
                Items.append(Item(genreName: genreNames[n], storeNames: amountArray[n] as! [String], storeCount: (amountArray[n] as AnyObject).count, photoURLs: amountArray1[n] as! [URL],address:  amountArray2[n] as! [String])
            )}
            
        }
            
            
            

            
        //配列の順番をsortする準備
        typealias SortDescriptor<Value> = (Value, Value) -> Bool
            
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
        
        //店の店数の多い順に並べ替える
        let sortedByCount: SortDescriptor<Item> = { $0.storeCount > $1.storeCount }
            
            Items = Items.sorted(by: sortedByCount)
            
            print(Items)
     
        }catch{
            print("エラーが起きました")
            return
        }
    }

    //cellの個数を決める
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.count + 1
    
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
        
            cell.textLabel?.text = Items[indexPath.row - 1].genreName + "                           \(Items[indexPath.row - 1].storeCount)"
            
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
        vc.item = Items[selectedIndex - 1]
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
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = manager.location {
            latitudeLabel.text = "緯度:\(location.coordinate.latitude)"
            longitudeLabel.text = "経度:\(location.coordinate.longitude)"
            
            //メンバ変数に現在地の経度と緯度を代入
            appDelegate.latitude = location.coordinate.latitude
            appDelegate.longitude = location.coordinate.longitude
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("エラー")
    }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
