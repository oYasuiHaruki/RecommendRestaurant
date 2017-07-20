//
//  GenreViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit
import MapKit
import SwiftGifOrigin

class GenreViewController: UIViewController, CLLocationManagerDelegate,UICollectionViewDataSource,UICollectionViewDelegate {

    //qucik food タイトル
    
    
//    UICollectionViewDataSource,UICollectionViewDelegate
    
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    
    @IBOutlet weak var genreNavigation: UINavigationItem!
    
    @IBOutlet weak var ajanLabel: UILabel!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var gifLoading: UIImageView!
    
    
    
    let queue:DispatchQueue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.default)
    
    
    
    //選択した行が何番目かを保存するための数字
    var selectedIndex = -1
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //struct Itemのインスタンス作成
    var Items : [Item] = []
    
    
    var myLocationManager: CLLocationManager!
    
    var latitude:Double = 0
    
    var longitude:Double = 0

    var genrePictures:[String] =
        
        ["izakaya",
         "diningbar",
         "sousakuryouri",
         "wasyoku",
         "nihonnryouri",
         "suhsi",
         "syabusyabu",
         "udon",
         "yousyoku",
         "steak",
         "italian",
         "french",
         "pasta",
         "bistoro",
         "tyuka",
         "kanntouryouri",
         "shisenn",
         "shanhai",
         "pekinn",
         "yakiniku",
         "kannkokuryouri",
         "ajian",
         "thai",
         "indo",
         "spein",
         "karaoke",
         "bar",
         "ramenn",
         "cafe",
         "okonomiyaki"]

    
    
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)

        myCollectionView.isHidden = true
        
        self.navigationController?.isNavigationBarHidden = true
        
        queue.async {() -> Void in
          
            
            
            
            
            
            self.gifLoading.image = UIImage.gif(name: "loading1")
            
            
            
            
            
            
            
            
            
            
            
            
            
           
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        

        self.genreNavigation.accessibilityElementsHidden = true
        
        
        
        
        
        
        
        
        
        let status = CLLocationManager.authorizationStatus()
        if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied{
            return
        }
        
        self.myLocationManager = CLLocationManager()
        self.myLocationManager.delegate = self
        
        if status == CLAuthorizationStatus.notDetermined {
            self.myLocationManager.requestWhenInUseAuthorization()
        }
        
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        self.myLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.myLocationManager.distanceFilter = kCLDistanceFilterNone
        
        self.myLocationManager.requestLocation()
        
        
        
        
        
        
        
        
        self.myCollectionView.delegate = self
        self.myCollectionView.dataSource = self
        
        
        
        
        
//        myTableView.delegate = self
//        myTableView.dataSource = self
        // Do any additional setup after loading the view.
        
        //hotpepperの情報を取ってくる
        let url = URL(string: "http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=847b52fd31d7b663&lat=35.0334&lng=135.7986&range=3&order=1&format=json&count=100")
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
            
            //店のcatch文をcatchInformationとして保存
            let catchInformaton:String = genreDictionary["catch"] as! String
            
            //営業時間をopenTimeとして保存
            let openTime:String = eachStoreInfomation["open"] as! String
            
            
            //平均価格をpriccとして保存
            let budget:NSDictionary = eachStoreInfomation["budget"] as! NSDictionary
            let price:String = budget["average"] as! String
            
            
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
                self.appDelegate.izakaya["storename"]?.append(storeName)
                self.appDelegate.izakaya["address"]?.append(address)
                self.appDelegate.izakaya["photo"]?.append(photoDataURL)
                self.appDelegate.izakaya["catch"]?.append(catchInformaton)
                self.appDelegate.izakaya["price"]?.append(price)
                self.appDelegate.izakaya["openTime"]?.append(openTime)
            case "ダイニングバー":
                self.appDelegate.diningbar["storename"]?.append(storeName)
                self.appDelegate.diningbar["address"]?.append(address)
                self.appDelegate.diningbar["photo"]?.append(photoDataURL)
                self.appDelegate.diningbar["catch"]?.append(catchInformaton)
                self.appDelegate.diningbar["price"]?.append(price)
                self.appDelegate.diningbar["openTime"]?.append(openTime)
            case "創作料理":
                self.appDelegate.sousakuryouri["storename"]?.append(storeName)
                self.appDelegate.sousakuryouri["address"]?.append(address)
                self.appDelegate.sousakuryouri["photo"]?.append(photoDataURL)
                self.appDelegate.sousakuryouri["catch"]?.append(catchInformaton)
                self.appDelegate.sousakuryouri["price"]?.append(price)
                self.appDelegate.sousakuryouri["openTime"]?.append(openTime)
            case "和食":
                self.appDelegate.wasyoku["storename"]?.append(storeName)
                self.appDelegate.wasyoku["address"]?.append(address)
                self.appDelegate.wasyoku["photo"]?.append(photoDataURL)
                self.appDelegate.wasyoku["catch"]?.append(catchInformaton)
                self.appDelegate.wasyoku["price"]?.append(price)
                self.appDelegate.wasyoku["openTime"]?.append(openTime)
            case "日本料理・懐石":
                self.appDelegate.nihonnryouri["storename"]?.append(storeName)
                self.appDelegate.nihonnryouri["address"]?.append(address)
                self.appDelegate.nihonnryouri["photo"]?.append(photoDataURL)
                self.appDelegate.nihonnryouri["catch"]?.append(catchInformaton)
                self.appDelegate.nihonnryouri["price"]?.append(price)
                self.appDelegate.nihonnryouri["openTime"]?.append(openTime)
            case "寿司":
                self.appDelegate.suhsi["storename"]?.append(storeName)
                self.appDelegate.suhsi["address"]?.append(address)
                self.appDelegate.suhsi["photo"]?.append(photoDataURL)
                self.appDelegate.suhsi["catch"]?.append(catchInformaton)
                self.appDelegate.suhsi["price"]?.append(price)
                self.appDelegate.suhsi["openTime"]?.append(openTime)
            case "しゃぶしゃぶ・すき焼き":
                self.appDelegate.syabusyabu["storename"]?.append(storeName)
                self.appDelegate.syabusyabu["address"]?.append(address)
                self.appDelegate.syabusyabu["photo"]?.append(photoDataURL)
                self.appDelegate.syabusyabu["catch"]?.append(catchInformaton)
                self.appDelegate.syabusyabu["price"]?.append(price)
                self.appDelegate.syabusyabu["openTime"]?.append(openTime)
            case "うどん・そば":
                self.appDelegate.udon["storename"]?.append(storeName)
                self.appDelegate.udon["address"]?.append(address)
                self.appDelegate.udon["photo"]?.append(photoDataURL)
                self.appDelegate.udon["catch"]?.append(catchInformaton)
                self.appDelegate.udon["price"]?.append(price)
                self.appDelegate.udon["openTime"]?.append(openTime)
            case "洋食":
                self.appDelegate.yousyoku["storename"]?.append(storeName)
                self.appDelegate.yousyoku["address"]?.append(address)
                self.appDelegate.yousyoku["photo"]?.append(photoDataURL)
                self.appDelegate.yousyoku["catch"]?.append(catchInformaton)
                self.appDelegate.yousyoku["price"]?.append(price)
                self.appDelegate.yousyoku["openTime"]?.append(openTime)
            case "ステーキ・ハンバーグ・カレー":
                self.appDelegate.steak["storename"]?.append(storeName)
                self.appDelegate.steak["address"]?.append(address)
                self.appDelegate.steak["photo"]?.append(photoDataURL)
                self.appDelegate.steak["catch"]?.append(catchInformaton)
                self.appDelegate.steak["price"]?.append(price)
                self.appDelegate.steak["openTime"]?.append(openTime)
            case "イタリアン・フレンチ":
                self.appDelegate.italian["storename"]?.append(storeName)
                self.appDelegate.italian["address"]?.append(address)
                self.appDelegate.italian["photo"]?.append(photoDataURL)
                self.appDelegate.italian["catch"]?.append(catchInformaton)
                self.appDelegate.italian["price"]?.append(price)
                self.appDelegate.italian["openTime"]?.append(openTime)
            case "パスタ・ピザ":
                self.appDelegate.pasta["storename"]?.append(storeName)
                self.appDelegate.pasta["address"]?.append(address)
                self.appDelegate.pasta["photo"]?.append(photoDataURL)
                self.appDelegate.pasta["catch"]?.append(catchInformaton)
                self.appDelegate.pasta["price"]?.append(price)
                self.appDelegate.pasta["openTime"]?.append(openTime)
            case "ビストロ":
                self.appDelegate.bistoro["storename"]?.append(storeName)
                self.appDelegate.bistoro["address"]?.append(address)
                self.appDelegate.bistoro["photo"]?.append(photoDataURL)
                self.appDelegate.bistoro["catch"]?.append(catchInformaton)
                self.appDelegate.bistoro["price"]?.append(price)
                self.appDelegate.bistoro["openTime"]?.append(openTime)
            case "中華":
                self.appDelegate.tyuka["storename"]?.append(storeName)
                self.appDelegate.tyuka["address"]?.append(address)
                self.appDelegate.tyuka["photo"]?.append(photoDataURL)
                self.appDelegate.tyuka["catch"]?.append(catchInformaton)
                self.appDelegate.tyuka["price"]?.append(price)
                self.appDelegate.tyuka["openTime"]?.append(openTime)
            case "広東料理":
                self.appDelegate.kanntouryouri["storename"]?.append(storeName)
                self.appDelegate.kanntouryouri["address"]?.append(address)
                self.appDelegate.kanntouryouri["photo"]?.append(photoDataURL)
                self.appDelegate.kanntouryouri["catch"]?.append(catchInformaton)
                self.appDelegate.kanntouryouri["price"]?.append(price)
                self.appDelegate.kanntouryouri["openTime"]?.append(openTime)
            case "四川料理":
                self.appDelegate.shisenn["storename"]?.append(storeName)
                self.appDelegate.shisenn["address"]?.append(address)
                self.appDelegate.shisenn["photo"]?.append(photoDataURL)
                self.appDelegate.shisenn["catch"]?.append(catchInformaton)
                self.appDelegate.shisenn["price"]?.append(price)
                self.appDelegate.shisenn["openTime"]?.append(openTime)
            case "上海料理":
                self.appDelegate.shanhai["storename"]?.append(storeName)
                self.appDelegate.shanhai["address"]?.append(address)
                self.appDelegate.shanhai["photo"]?.append(photoDataURL)
                self.appDelegate.shanhai["catch"]?.append(catchInformaton)
                self.appDelegate.shanhai["price"]?.append(price)
                self.appDelegate.shanhai["openTime"]?.append(openTime)
            case "北京料理":
                self.appDelegate.pekinn["storename"]?.append(storeName)
                self.appDelegate.pekinn["address"]?.append(address)
                self.appDelegate.pekinn["photo"]?.append(photoDataURL)
                self.appDelegate.pekinn["catch"]?.append(catchInformaton)
                self.appDelegate.pekinn["price"]?.append(price)
                self.appDelegate.pekinn["openTime"]?.append(openTime)
            case "焼肉・韓国料理":
                self.appDelegate.yakiniku["storename"]?.append(storeName)
                self.appDelegate.yakiniku["address"]?.append(address)
                self.appDelegate.yakiniku["photo"]?.append(photoDataURL)
                self.appDelegate.yakiniku["catch"]?.append(catchInformaton)
                self.appDelegate.yakiniku["price"]?.append(price)
                self.appDelegate.yakiniku["openTime"]?.append(openTime)
            case "アジアン":
                self.appDelegate.ajian["storename"]?.append(storeName)
                self.appDelegate.ajian["address"]?.append(address)
                self.appDelegate.ajian["photo"]?.append(photoDataURL)
                self.appDelegate.ajian["catch"]?.append(catchInformaton)
                self.appDelegate.ajian["price"]?.append(price)
                self.appDelegate.ajian["openTime"]?.append(openTime)
            case "タイ・ベトナム料理":
                self.appDelegate.thai["storename"]?.append(storeName)
                self.appDelegate.thai["address"]?.append(address)
                self.appDelegate.thai["photo"]?.append(photoDataURL)
                self.appDelegate.thai["catch"]?.append(catchInformaton)
                self.appDelegate.thai["price"]?.append(price)
                self.appDelegate.thai["openTime"]?.append(openTime)
            case "インド料理":
                self.appDelegate.indo["storename"]?.append(storeName)
                self.appDelegate.indo["address"]?.append(address)
                self.appDelegate.indo["photo"]?.append(photoDataURL)
                self.appDelegate.indo["catch"]?.append(catchInformaton)
                self.appDelegate.indo["price"]?.append(price)
                self.appDelegate.indo["openTime"]?.append(openTime)
            case "スペイン・地中海料理":
                self.appDelegate.spein["storename"]?.append(storeName)
                self.appDelegate.spein["address"]?.append(address)
                self.appDelegate.spein["photo"]?.append(photoDataURL)
                self.appDelegate.spein["catch"]?.append(catchInformaton)
                self.appDelegate.spein["price"]?.append(price)
                self.appDelegate.spein["openTime"]?.append(openTime)
            case "カラオケ":
                self.appDelegate.karaoke["storename"]?.append(storeName)
                self.appDelegate.karaoke["address"]?.append(address)
                self.appDelegate.karaoke["photo"]?.append(photoDataURL)
                self.appDelegate.karaoke["catch"]?.append(catchInformaton)
                self.appDelegate.karaoke["price"]?.append(price)
                self.appDelegate.karaoke["openTime"]?.append(openTime)
            case "バー・カクテル":
                self.appDelegate.bar["storename"]?.append(storeName)
                self.appDelegate.bar["address"]?.append(address)
                self.appDelegate.bar["photo"]?.append(photoDataURL)
                self.appDelegate.bar["catch"]?.append(catchInformaton)
                self.appDelegate.bar["price"]?.append(price)
                self.appDelegate.bar["openTime"]?.append(openTime)
            case "ラーメン":
                self.appDelegate.ramenn["storename"]?.append(storeName)
                self.appDelegate.ramenn["address"]?.append(address)
                self.appDelegate.ramenn["photo"]?.append(photoDataURL)
                self.appDelegate.ramenn["catch"]?.append(catchInformaton)
                self.appDelegate.ramenn["price"]?.append(price)
                self.appDelegate.ramenn["openTime"]?.append(openTime)
            case "カフェ・スイーツ":
                self.appDelegate.cafe["storename"]?.append(storeName)
                self.appDelegate.cafe["address"]?.append(address)
                self.appDelegate.cafe["photo"]?.append(photoDataURL)
                self.appDelegate.cafe["catch"]?.append(catchInformaton)
                self.appDelegate.cafe["price"]?.append(price)
                self.appDelegate.cafe["openTime"]?.append(openTime)
            case "お好み焼き・もんじゃ・鉄板焼き":
                self.appDelegate.okonomiyaki["storename"]?.append(storeName)
                self.appDelegate.okonomiyaki["address"]?.append(address)
                self.appDelegate.okonomiyaki["photo"]?.append(photoDataURL)
                self.appDelegate.okonomiyaki["catch"]?.append(catchInformaton)
                self.appDelegate.okonomiyaki["price"]?.append(price)
                self.appDelegate.okonomiyaki["openTime"]?.append(openTime)
            default:
            print("不明のジャンルが入りました")
            print(genreName)
            }
            }
        
            //並べ替えのため作成(店名)
            var amountArray: NSArray =
                
                [self.appDelegate.izakaya["storename"]!,
                 self.appDelegate.diningbar["storename"]!,
                 self.appDelegate.sousakuryouri["storename"]!,
                 self.appDelegate.wasyoku["storename"]!,
                 self.appDelegate.nihonnryouri["storename"]!,
                 self.appDelegate.suhsi["storename"]!,
                 self.appDelegate.syabusyabu["storename"]!,
                 self.appDelegate.udon["storename"]!,
                 self.appDelegate.yousyoku["storename"]!,
                 self.appDelegate.steak["storename"]!,
                 self.appDelegate.italian["storename"]!,
                 self.appDelegate.french["storename"]!,
                 self.appDelegate.pasta["storename"]!,
                 self.appDelegate.bistoro["storename"]!,
                 self.appDelegate.tyuka["storename"]!,
                 self.appDelegate.kanntouryouri["storename"]!,
                 self.appDelegate.shisenn["storename"]!,
                 self.appDelegate.shanhai["storename"]!,
                 self.appDelegate.pekinn["storename"]!,
                 self.appDelegate.yakiniku["storename"]!,
                 self.appDelegate.kannkokuryouri["storename"]!,
                 self.appDelegate.ajian["storename"]!,
                 self.appDelegate.thai["storename"]!,
                 self.appDelegate.indo["storename"]!,
                 self.appDelegate.spein["storename"]!,
                 self.appDelegate.karaoke["storename"]!,
                 self.appDelegate.bar["storename"]!,
                 self.appDelegate.ramenn["storename"]!,
                 self.appDelegate.cafe["storename"]!,
                 self.appDelegate.okonomiyaki["storename"]!]
            
            
            //並べ替えのため作成(写真)
            var amountArray1: NSArray =
            
                [self.appDelegate.izakaya["photo"]!,
                 self.appDelegate.diningbar["photo"]!,
                 self.appDelegate.sousakuryouri["photo"]!,
                 self.appDelegate.wasyoku["photo"]!,
                 self.appDelegate.nihonnryouri["photo"]!,
                 self.appDelegate.suhsi["photo"]!,
                 self.appDelegate.syabusyabu["photo"]!,
                 self.appDelegate.udon["photo"]!,
                 self.appDelegate.yousyoku["photo"]!,
                 self.appDelegate.steak["photo"]!,
                 self.appDelegate.italian["photo"]!,
                 self.appDelegate.french["photo"]!,
                 self.appDelegate.pasta["photo"]!,
                 self.appDelegate.bistoro["photo"]!,
                 self.appDelegate.tyuka["photo"]!,
                 self.appDelegate.kanntouryouri["photo"]!,
                 self.appDelegate.shisenn["photo"]!,
                 self.appDelegate.shanhai["photo"]!,
                 self.appDelegate.pekinn["photo"]!,
                 self.appDelegate.yakiniku["photo"]!,
                 self.appDelegate.kannkokuryouri["photo"]!,
                 self.appDelegate.ajian["photo"]!,
                 self.appDelegate.thai["photo"]!,
                 self.appDelegate.indo["photo"]!,
                 self.appDelegate.spein["photo"]!,
                 self.appDelegate.karaoke["photo"]!,
                 self.appDelegate.bar["photo"]!,
                 self.appDelegate.ramenn["photo"]!,
                 self.appDelegate.cafe["photo"]!,
                 self.appDelegate.okonomiyaki["photo"]!]
            
            var amountArray2: NSArray =
                
                [self.appDelegate.izakaya["address"]!,
                 self.appDelegate.diningbar["address"]!,
                 self.appDelegate.sousakuryouri["address"]!,
                 self.appDelegate.wasyoku["address"]!,
                 self.appDelegate.nihonnryouri["address"]!,
                 self.appDelegate.suhsi["address"]!,
                 self.appDelegate.syabusyabu["address"]!,
                 self.appDelegate.udon["address"]!,
                 self.appDelegate.yousyoku["address"]!,
                 self.appDelegate.steak["address"]!,
                 self.appDelegate.italian["address"]!,
                 self.appDelegate.french["address"]!,
                 self.appDelegate.pasta["address"]!,
                 self.appDelegate.bistoro["address"]!,
                 self.appDelegate.tyuka["address"]!,
                 self.appDelegate.kanntouryouri["address"]!,
                 self.appDelegate.shisenn["address"]!,
                 self.appDelegate.shanhai["address"]!,
                 self.appDelegate.pekinn["address"]!,
                 self.appDelegate.yakiniku["address"]!,
                 self.appDelegate.kannkokuryouri["address"]!,
                 self.appDelegate.ajian["address"]!,
                 self.appDelegate.thai["address"]!,
                 self.appDelegate.indo["address"]!,
                 self.appDelegate.spein["address"]!,
                 self.appDelegate.karaoke["address"]!,
                 self.appDelegate.bar["address"]!,
                 self.appDelegate.ramenn["address"]!,
                 self.appDelegate.cafe["address"]!,
                 self.appDelegate.okonomiyaki["address"]!]

            //並べ替えのため作成(catch文)
            var amountArray3: NSArray =
            
                [self.appDelegate.izakaya["catch"]!,
                 self.appDelegate.diningbar["catch"]!,
                 self.appDelegate.sousakuryouri["catch"]!,
                 self.appDelegate.wasyoku["catch"]!,
                 self.appDelegate.nihonnryouri["catch"]!,
                 self.appDelegate.suhsi["catch"]!,
                 self.appDelegate.syabusyabu["catch"]!,
                 self.appDelegate.udon["catch"]!,
                 self.appDelegate.yousyoku["catch"]!,
                 self.appDelegate.steak["catch"]!,
                 self.appDelegate.italian["catch"]!,
                 self.appDelegate.french["catch"]!,
                 self.appDelegate.pasta["catch"]!,
                 self.appDelegate.bistoro["catch"]!,
                 self.appDelegate.tyuka["catch"]!,
                 self.appDelegate.kanntouryouri["catch"]!,
                 self.appDelegate.shisenn["catch"]!,
                 self.appDelegate.shanhai["catch"]!,
                 self.appDelegate.pekinn["catch"]!,
                 self.appDelegate.yakiniku["catch"]!,
                 self.appDelegate.kannkokuryouri["catch"]!,
                 self.appDelegate.ajian["catch"]!,
                 self.appDelegate.thai["catch"]!,
                 self.appDelegate.indo["catch"]!,
                 self.appDelegate.spein["catch"]!,
                 self.appDelegate.karaoke["catch"]!,
                 self.appDelegate.bar["catch"]!,
                 self.appDelegate.ramenn["catch"]!,
                 self.appDelegate.cafe["catch"]!,
                 self.appDelegate.okonomiyaki["catch"]!]

            //並べ替えのため作成(平均価格)
            var amountArray4: NSArray =
                
                [self.appDelegate.izakaya["price"]!,
                 self.appDelegate.diningbar["price"]!,
                 self.appDelegate.sousakuryouri["price"]!,
                 self.appDelegate.wasyoku["price"]!,
                 self.appDelegate.nihonnryouri["price"]!,
                 self.appDelegate.suhsi["price"]!,
                 self.appDelegate.syabusyabu["price"]!,
                 self.appDelegate.udon["price"]!,
                 self.appDelegate.yousyoku["price"]!,
                 self.appDelegate.steak["price"]!,
                 self.appDelegate.italian["price"]!,
                 self.appDelegate.french["price"]!,
                 self.appDelegate.pasta["price"]!,
                 self.appDelegate.bistoro["price"]!,
                 self.appDelegate.tyuka["price"]!,
                 self.appDelegate.kanntouryouri["price"]!,
                 self.appDelegate.shisenn["price"]!,
                 self.appDelegate.shanhai["price"]!,
                 self.appDelegate.pekinn["price"]!,
                 self.appDelegate.yakiniku["price"]!,
                 self.appDelegate.kannkokuryouri["price"]!,
                 self.appDelegate.ajian["price"]!,
                 self.appDelegate.thai["price"]!,
                 self.appDelegate.indo["price"]!,
                 self.appDelegate.spein["price"]!,
                 self.appDelegate.karaoke["price"]!,
                 self.appDelegate.bar["price"]!,
                 self.appDelegate.ramenn["price"]!,
                 self.appDelegate.cafe["price"]!,
                 self.appDelegate.okonomiyaki["price"]!]
            
            
            //並べ替えのため作成(営業時間)
            var amountArray5: NSArray =
                
                [self.appDelegate.izakaya["openTime"]!,
                 self.appDelegate.diningbar["openTime"]!,
                 self.appDelegate.sousakuryouri["openTime"]!,
                 self.appDelegate.wasyoku["openTime"]!,
                 self.appDelegate.nihonnryouri["openTime"]!,
                 self.appDelegate.suhsi["openTime"]!,
                 self.appDelegate.syabusyabu["openTime"]!,
                 self.appDelegate.udon["openTime"]!,
                 self.appDelegate.yousyoku["openTime"]!,
                 self.appDelegate.steak["openTime"]!,
                 self.appDelegate.italian["openTime"]!,
                 self.appDelegate.french["openTime"]!,
                 self.appDelegate.pasta["openTime"]!,
                 self.appDelegate.bistoro["openTime"]!,
                 self.appDelegate.tyuka["openTime"]!,
                 self.appDelegate.kanntouryouri["openTime"]!,
                 self.appDelegate.shisenn["openTime"]!,
                 self.appDelegate.shanhai["openTime"]!,
                 self.appDelegate.pekinn["openTime"]!,
                 self.appDelegate.yakiniku["openTime"]!,
                 self.appDelegate.kannkokuryouri["openTime"]!,
                 self.appDelegate.ajian["openTime"]!,
                 self.appDelegate.thai["openTime"]!,
                 self.appDelegate.indo["openTime"]!,
                 self.appDelegate.spein["openTime"]!,
                 self.appDelegate.karaoke["openTime"]!,
                 self.appDelegate.bar["openTime"]!,
                 self.appDelegate.ramenn["openTime"]!,
                 self.appDelegate.cafe["openTime"]!,
                 self.appDelegate.okonomiyaki["openTime"]!]
            

            
            
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
             "ステーキ",
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
             "お好み焼き"]
            
            
            
            
            
        //Items配列にItemインスタンスを入れていく
        for n in 0...genreNames.count - 1 {
            
            if (amountArray[n] as AnyObject).count != 0 {
                self.Items.append(Item(genreName: genreNames[n], storeNames: amountArray[n] as! [String], storeCount: (amountArray[n] as AnyObject).count, photoURLs: amountArray1[n] as! [URL],address:  amountArray2[n] as! [String],catchInformation: amountArray3[n] as! [String], price: amountArray4[n] as! [String], openTime: amountArray5[n] as! [String], genrePicture: self.genrePictures[n])
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
            
            self.Items = self.Items.sorted(by: sortedByCount)
            
            print(self.Items)
            
            
     
        }catch{
            print("エラーが起きました")
            return
        }
            
            
            self.myCollectionView.reloadData()
            self.myCollectionView.isHidden = false
            self.myCollectionView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
            self.ajanLabel.isHidden = true
            self.titleLabel.isHidden = true
            self.navigationController?.isNavigationBarHidden = false
            
            
            
    }
    }
//
//    //cellの個数を決める
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return Items.count + 1
//    
//    }
//    
//    //cellの中身を決める
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        switch indexPath.row{
//            
//        case 0:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//            
//            //cell accesoryType decision
//            cell.accessoryType = .none
//            
//            //top cell text 料理ジャンルを選択
//            cell.textLabel?.text = "料理ジャンルを選択"
//            
//            //top cell textcolor change
//            cell.textLabel?.textColor = UIColor.white
//            
//            //top cell backgournd color change
//            cell.backgroundColor = UIColor.blue
//            
//            return cell
//            
//        default:
//            
//            //cell create
//            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        
//            //cell accesoryType decision
//            cell.accessoryType = .disclosureIndicator
//        
//            cell.textLabel?.text = Items[indexPath.row - 1].genreName + "                           \(Items[indexPath.row - 1].storeCount)"
//            
//            return cell
//            
//        }
//    }
    
//    //cellが押された時に実行するメソッド
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        //選択された行番号をメンバ変数に格納
//        selectedIndex = indexPath.row
//        
//        if selectedIndex == 0 {
//            return
//        }
//        else {
//        //セグエを指定して画面移動
//        self.performSegue(withIdentifier: "showDetail", sender: nil)
//        }
//    }
//    
    
    //segueを使って画面移動する時に実行される（そのメソッドをoverrideで書き換えてる）
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //次の画面をインスタンス化(as:ダウンキャスト型変換)
        var vc = segue.destination as! ViewController
        
        //次の画面のプロパティに選択された行番号を指定
        vc.item = Items[selectedIndex]
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
    

    
    
    
    
    
    
    // MARK: - UICollectionViewDelegate Protocol
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.title.text = Items[indexPath.row].genreName
        cell.title.textColor = UIColor.white
        cell.image.image = UIImage(named: Items[indexPath.row].genrePicture + ".jpeg")
        cell.backgroundColor = .orange
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Items.count
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //選択された行番号をメンバ変数に格納
        selectedIndex = indexPath.row
        
//        if selectedIndex == 0 {
//            return
//        }
//        else {
            //セグエを指定して画面移動
            self.performSegue(withIdentifier: "showDetail", sender: nil)
//        }

    }
    
    
    
}

    
    
    
    
    
    
    
    


