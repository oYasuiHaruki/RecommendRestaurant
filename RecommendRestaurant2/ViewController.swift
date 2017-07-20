//
//  ViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit
import SDWebImage
import MapKit
import CoreLocation



class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    
    @IBOutlet weak var countNum: UILabel!
    
    
    @IBOutlet weak var denominator: UILabel!
    
    
    
    //現在地の取得のために生成
    var testManager:CLLocationManager = CLLocationManager()
    
    
    
    //structのitemのインスタンスを作成
    var item : Item? = nil
    
    //店が何番目かを保存する数
    var num = 0
    
    //店の情報が載ったUIViewの作成
    var baseView:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
    
    //情報を囲むビューの作成
    var baseView2:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
    
    //写真を置くUIImageViewの作成
    var myPicture:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
    var myPicture2:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
    
    
    
    //店名を表記したラベルの作成
    var myLabelStoreName:UILabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 60))
    var myLabelStoreName2:UILabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 60))
    
    //catch文を表記したラベルの作成
    var myLabelCatchSentence:UILabel = UILabel(frame: CGRect(x: 0, y: 230, width: 210, height: 60))
    var myLabelCatchSentence2:UILabel = UILabel(frame: CGRect(x: 0, y: 230, width: 210, height: 60))
    
    //営業時間を表記したラベルの作成
    var myLabelOpenTime:UILabel = UILabel(frame: CGRect(x: 0, y: 280, width: 210, height: 30))
    var myLabelOpenTime2:UILabel = UILabel(frame: CGRect(x: 0, y: 280, width: 210, height: 30))
    
    //価格を表記したラベルの作成
    var myLabelPrice:UILabel = UILabel(frame: CGRect(x: 0, y: 310, width: 210, height: 30))
    var myLabelPrice2:UILabel = UILabel(frame: CGRect(x: 0, y: 310, width: 210, height: 30))

    //navigationのラベル
    @IBOutlet weak var viewTitle: UINavigationItem!
    
    
    
    
    
    var divisor : CGFloat!
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var goMap: UIButton!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
//        myLabelStoreName.backgroundColor = UIColor.orange
        
//        baseView.addSubview(baseView2)
        
//        let attrText = NSMutableAttributedString(string: "\(num + 1)/\((item?.storeCount)!)")
//        print(attrText)
//        attrText.addAttribute(NSForegroundColorAttributeName, value: UIColor.red, range: NSMakeRange(0, 3))
//        countNum.attributedText = attrText
        
        
        self.navigationController?.navigationBar.tintColor = .orange
        
        
        
        
        
        
        
        
        //navigationのタイトルを編集
        viewTitle.title = item?.genreName
        
        
        goMap.imageView?.image = UIImage(named: "Maps-icon4.png")
        //assetsの中に入れたら.pngの表記が入らない
        //×1,2,3の中に入れる
        
//        var amountStore:Int = (item?.storeCount)!
        
        
        countNum.text = "\(num + 1)"
        denominator.text = "/\((item?.storeCount)!)"
        
        
        //デリゲート先を自分に設定する。(CLLocationManagerDelegatのデリゲート)
        testManager.delegate = self
        
        
        //位置情報の利用許可を変更する画面をポップアップ表示する。
        testManager.requestWhenInUseAuthorization()
        
        //位置情報の取得を要求する。
        testManager.requestLocation()
        
        
        
        
        
        divisor = (view.frame.width / 2) / 0.61
    
        //baseView(カード)の色をつける
        baseView.backgroundColor = .white
        baseView2.backgroundColor = .white
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
        baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 30)
    

        
        
        //初期画面の写真を表示
        myPicture.sd_setImage(with: item?.photoURLs[num])
        myPicture.contentMode = .scaleToFill
        if (item?.storeCount)! == 1 {
        }else{
        myPicture2.sd_setImage(with: item?.photoURLs[num + 1])
        myPicture2.contentMode = .scaleToFill
        }
        
        
        //テキスト・フォントを設定
        myLabelStoreName.text = "\(item?.storeNames[num] as! String)"
        myLabelStoreName.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 20)
        myLabelStoreName.font = UIFont.boldSystemFont(ofSize: 20)
        myLabelStoreName.textAlignment = .center
        myLabelStoreName.numberOfLines = 0
        myLabelStoreName.textColor = UIColor.orange
        
        if (item?.storeCount)! == 1 {
        }else{
        myLabelStoreName2.text = "\(item?.storeNames[num + 1] as! String)"
        myLabelStoreName2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 20)
        myLabelStoreName2.font = UIFont.boldSystemFont(ofSize: 20)
        myLabelStoreName2.textAlignment = .center
        myLabelStoreName2.numberOfLines = 0
        myLabelStoreName2.textColor = UIColor.orange
        }
        
        myLabelCatchSentence.text = "\(item?.catchInformation[num] as! String)"
        myLabelCatchSentence.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        myLabelCatchSentence.textAlignment = .center
        myLabelCatchSentence.numberOfLines = 0
        
        if (item?.storeCount)! == 1 {
        }else{
        myLabelCatchSentence2.text = "\(item?.catchInformation[num + 1] as! String)"
        myLabelCatchSentence2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        myLabelCatchSentence2.textAlignment = .center
        myLabelCatchSentence2.numberOfLines = 0
        }
        
        
        var timeString:String = ""
        
        let time = item?.openTime[num].components(separatedBy: "（料理")
        var timeNum:Int = (time?.count)!
        
        for n in 0...timeNum - 1{
            if n == 0{
                timeString += (time?[n])!
            }
            else{
                var timeAnotherString = time?[n].components(separatedBy:  "）")
                timeString += (timeAnotherString?[1])!
            }
            
        }
        print(time)
        print(timeString)
        
        var timeString2:String = ""
        
        if (item?.storeCount)! == 1 {
        }else{
        let time2 = item?.openTime[num + 1].components(separatedBy: "（料理")
        var timeNum2:Int = (time2?.count)!
        
        for n in 0...timeNum2 - 1{
            if n == 0{
                timeString2 += (time2?[n])!
            }
            else{
                var timeAnotherString2 = time2?[n].components(separatedBy:  "）")
                timeString2 += (timeAnotherString2?[1])!
            }
            
        }
        print(timeString2)
        }
        
//        print(item?.openTime[num])
//        print(timeString)
        myLabelOpenTime.text = timeString
        myLabelOpenTime.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelOpenTime.textAlignment = .center
        myLabelOpenTime.numberOfLines = 0
        
        if (item?.storeCount)! == 1 {
        }else{
        myLabelOpenTime2.text = timeString2
        myLabelOpenTime2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelOpenTime2.textAlignment = .center
        myLabelOpenTime2.numberOfLines = 0
        }
        
        myLabelPrice.text = "平均予算：\(item?.price[num] as! String)"
        myLabelPrice.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelPrice.textAlignment = .center
        myLabelPrice.numberOfLines = 0
        
        if (item?.storeCount)! == 1 {
        }else{
        myLabelPrice2.text = "平均予算：\(item?.price[num + 1] as! String)"
        myLabelPrice2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelPrice2.textAlignment = .center
        myLabelPrice2.numberOfLines = 0
        }

        
        // スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))
        
        // baseViewにジェスチャーを登録
      
//        self.baseView2.addGestureRecognizer(Pan)
        self.baseView.addGestureRecognizer(Pan)
        //元々のviewの上に作成したbaseViewを載せる
        if (item?.storeCount)! == 1 {
        }else{
        self.view.addSubview(baseView2)
        }
        self.view.addSubview(baseView)
        
        
        // baseViewの上にmyPictureを載せる
        self.baseView.addSubview(myPicture)
        self.baseView2.addSubview(myPicture2)
        
        //baseViewの上にmyLabelを配置
        baseView.addSubview(myLabelStoreName)
        baseView.addSubview(myLabelCatchSentence)
        baseView.addSubview(myLabelOpenTime)
        baseView.addSubview(myLabelPrice)
        
        baseView2.addSubview(myLabelStoreName2)
        baseView2.addSubview(myLabelCatchSentence2)
        baseView2.addSubview(myLabelOpenTime2)
        baseView2.addSubview(myLabelPrice2)
        
//        self.baseView.layer.borderColor = UIColor.brown as! CGColor
//        myPicture.layer.borderWidth = 10
        
        //baseViewの角を丸くする
//        baseView.layer.borderWidth = 10
//        let shadowView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        baseView.backgroundColor = UIColor(red: 89/255, green: 172/255, blue: 255/255, alpha: 1)
//        shadow.center = baseView.center
        
//        myPicture.layer.cornerRadius = 10
        myPicture.layer.masksToBounds = true
        
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = false

        baseView2.layer.cornerRadius = 10
        baseView2.layer.masksToBounds = false

        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.5 // 透明度
        baseView.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView.layer.shadowRadius = 5 // ぼかし量
        
        baseView2.layer.shadowColor = UIColor.black.cgColor
        baseView2.layer.shadowOpacity = 0.5 // 透明度
        baseView2.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView2.layer.shadowRadius = 5 // ぼかし量

//        baseView.addSubview(shadowView)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        
//        baseView.layer.cornerRadius = 10.0
//        baseView.layer.masksToBounds = true
//

//        //写真を丸くする
//        myPicture.layer.cornerRadius = 10.0
//        myPicture.layer.masksToBounds = true
//
        
    }
    
    
    
    
    
    
    //mapボタンを押した時に発動
    @IBAction func moveMap(_ sender: UIButton) {
        
        
        let myGeocoder:CLGeocoder = CLGeocoder()
        
        //店の住所を
        var str = item?.address[num]
        
        let arr2 = str?.components(separatedBy: "　")
        let arr3 = arr2?[0].components(separatedBy: " ")
        
        print(arr3?[0])   // apple
//        print(arr2?[1])   // orange
        
        
//        var address1 = convertHalfWidthToFullWidth(half:(arr3?[0])!)
        
        
//        print(address1)
        
        
        
        //住所を座標に変換する。
        myGeocoder.geocodeAddressString((arr3?[0])!, completionHandler: {(placemarks, error) in
            
//            print(self.item?.address)
            //item.addressに配列としてちゃんと入ってない可能性
            print(self.num)
//            print(placemarks)
  if(error == nil) {
    for placemark in placemarks! {
        let location:CLLocation = placemark.location!
        
//        print("location:\(location)")
        
        
        //マップアプリに渡す目的地の位置情報を作る。
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let placemark = MKPlacemark(coordinate:coordinate, addressDictionary:nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        //起動オプション
        let option:[String:AnyObject] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeWalking as AnyObject, //車で移動
            MKLaunchOptionsMapTypeKey : MKMapType.hybrid.rawValue as AnyObject]  //地図表示はハイブリッド
        
        //マップアプリを起動する。
        mapItem.openInMaps(launchOptions: option)
        
        
    }
        }
  else {
    
    print("エラー")
    
            }
        })}
    
    
    //新しいカードを作成するメソッド
    func newPage(){
        
        
        
        baseView2.isHidden = true

//        if num == (item?.storeCount)! {
//            num = 0
//        }
        
        
//        let time = item?.openTime[num].components(separatedBy: "（料理")
//        var timeNum:Int = (time?.count)!
//        var time1:String = ""
//        for n in 0...timeNum - 1{
//            if n == 0{
//                time1 += (time?[n])!
//            }
//            else{
//                var time2 = time?[n].components(separatedBy:  "）")
//                time1 += (time2?[1])!
//            }
//            
//        }

        let time = item?.openTime[num].components(separatedBy: "（料理")
        var timeNum:Int = (time?.count)!
        var timeString:String = ""
        for n in 0...timeNum - 1{
            if n == 0{
                timeString += (time?[n])!
            }
            else{
                var timeAnotherString = time?[n].components(separatedBy:  "）")
                timeString += (timeAnotherString?[1])!
            }
            
        }
        
        if num == (item?.storeCount)! - 1 {
            
            let time2 = item?.openTime[0].components(separatedBy: "（料理")
            var timeNum2:Int = (time2?.count)!
            var timeString2:String = ""
            for n in 0...timeNum2 - 1{
                if n == 0{
                    timeString2 += (time2?[n])!
                }
                else{
                    var timeAnotherString2 = time2?[n].components(separatedBy:  "）")
                    timeString2 += (timeAnotherString2?[1])!
                }
                
            }
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            //新規のbaseViewを作成
            baseView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
            baseView2 = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
            
            baseView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
            baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 30)
            
            //        baseView.layer.borderColor = UIColor.orange as! CGColor
            
            //写真を表示
            //        myPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            myPicture.sd_setImage(with: item?.photoURLs[num])
            myPicture2.sd_setImage(with: item?.photoURLs[0])
            ////
            //        //店名を表示
            //        myLabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 150))
            myLabelStoreName.text = "\((item?.storeNames[num])!)"
            myLabelStoreName2.text = "\((item?.storeNames[0])!)"
            
            //テキストを表示
            myLabelCatchSentence.text = "\((item?.catchInformation[num])!)"
            myLabelCatchSentence2.text = "\((item?.catchInformation[0])!)"
            
            myLabelOpenTime.text = timeString
            myLabelOpenTime2.text = timeString2
            
            myLabelPrice.text = "平均予算：\((item?.price[num])!)"
            myLabelPrice2.text = "平均予算：\((item?.price[0])!)"
            
            
            
            //backgroundColorを変更
            baseView.backgroundColor = .white
            baseView2.backgroundColor = .white
            
            
            //gesturePanを定義
            let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))  //Swift3
            
            
//            //baseViewの角を丸くする
//            baseView.layer.cornerRadius = 10.0
//            baseView.layer.masksToBounds = true
//            baseView2.layer.cornerRadius = 10.0
//            baseView2.layer.masksToBounds = true
            
            
            
            //        //写真を丸くする
            //        myPicture.layer.cornerRadius = 10.0
            //        myPicture.layer.masksToBounds = true
            
            
            
            //viewたちを追加
            view.addSubview(baseView2)
            view.addSubview(baseView)
            
            //        baseView.sendSubview(toBack: baseView2)
            baseView.addSubview(myPicture)
            baseView.addSubview(myLabelStoreName)
            baseView.addSubview(myLabelCatchSentence)
            baseView.addSubview(myLabelOpenTime)
            baseView.addSubview(myLabelPrice)
            baseView.addGestureRecognizer(Pan)
            
            //        baseView2.sendSubview(toBack: baseView2)
            baseView2.addSubview(myPicture2)
            baseView2.addSubview(myLabelStoreName2)
            baseView2.addSubview(myLabelCatchSentence2)
            baseView2.addSubview(myLabelOpenTime2)
            baseView2.addSubview(myLabelPrice2)
            //        baseView2.addGestureRecognizer(Pan)
            
            //        baseView2.addGestureRecognizer(Pan)
            
            
            countNum.text = "\(num + 1)"
            denominator.text = "/\((item?.storeCount)!)"
            
            

        }
        else{
        let time2 = item?.openTime[num + 1].components(separatedBy: "（料理")
        var timeNum2:Int = (time2?.count)!
        var timeString2:String = ""
        for n in 0...timeNum2 - 1{
            if n == 0{
                timeString2 += (time2?[n])!
            }
            else{
                var timeAnotherString2 = time2?[n].components(separatedBy:  "）")
                timeString2 += (timeAnotherString2?[1])!
            }
            
        }

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        //新規のbaseViewを作成
        baseView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
        baseView2 = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 360))
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 30)
        baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 30)
        
//        baseView.layer.borderColor = UIColor.orange as! CGColor
        
        //写真を表示
//        myPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        myPicture.sd_setImage(with: item?.photoURLs[num])
        myPicture2.sd_setImage(with: item?.photoURLs[num + 1])
////
//        //店名を表示
//        myLabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 150))
        myLabelStoreName.text = "\((item?.storeNames[num])!)"
        myLabelStoreName2.text = "\((item?.storeNames[num + 1])!)"
        
        //テキストを表示
        myLabelCatchSentence.text = "\((item?.catchInformation[num])!)"
        myLabelCatchSentence2.text = "\((item?.catchInformation[num + 1])!)"
    
        myLabelOpenTime.text = timeString
        myLabelOpenTime2.text = timeString2
        
        myLabelPrice.text = "平均予算：\((item?.price[num])!)"
        myLabelPrice2.text = "平均予算：\((item?.price[num + 1])!)"
        

        
        //backgroundColorを変更
        baseView.backgroundColor = .white
        baseView2.backgroundColor = .white
        
        
        //gesturePanを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))  //Swift3
        
        
//        //baseViewの角を丸くする
//        baseView.layer.cornerRadius = 10.0
//        baseView.layer.masksToBounds = true
//        baseView2.layer.cornerRadius = 10.0
//        baseView2.layer.masksToBounds = true

        
        
//        //写真を丸くする
//        myPicture.layer.cornerRadius = 10.0
//        myPicture.layer.masksToBounds = true
        
        

        //viewたちを追加
        view.addSubview(baseView2)
        view.addSubview(baseView)
        
//        baseView.sendSubview(toBack: baseView2)
        baseView.addSubview(myPicture)
        baseView.addSubview(myLabelStoreName)
        baseView.addSubview(myLabelCatchSentence)
        baseView.addSubview(myLabelOpenTime)
        baseView.addSubview(myLabelPrice)
        baseView.addGestureRecognizer(Pan)
        
//        baseView2.sendSubview(toBack: baseView2)
        baseView2.addSubview(myPicture2)
        baseView2.addSubview(myLabelStoreName2)
        baseView2.addSubview(myLabelCatchSentence2)
        baseView2.addSubview(myLabelOpenTime2)
        baseView2.addSubview(myLabelPrice2)
//        baseView2.addGestureRecognizer(Pan)
        
//        baseView2.addGestureRecognizer(Pan)

        
        countNum.text = "\(num + 1)"
        denominator.text = "/\((item?.storeCount)!)"
        
        }
        
        myPicture.layer.masksToBounds = true
        
        baseView.layer.cornerRadius = 10
        baseView.layer.masksToBounds = false
        
        baseView.layer.shadowColor = UIColor.black.cgColor
        baseView.layer.shadowOpacity = 0.5 // 透明度
        baseView.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView.layer.shadowRadius = 5 // ぼかし量
        
        
        
        
        
        myPicture2.layer.masksToBounds = true
        
        baseView2.layer.cornerRadius = 10
        baseView2.layer.masksToBounds = false
        
        baseView2.layer.shadowColor = UIColor.black.cgColor
        baseView2.layer.shadowOpacity = 0.5 // 透明度
        baseView2.layer.shadowOffset = CGSize(width: 5, height: 5) // 距離
        baseView2.layer.shadowRadius = 5 // ぼかし量
        
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Swift.Error) {
        print("エラー")
    }

    
    //gesturePanのメソッド
    func PanView(sender: UIPanGestureRecognizer) {
        
        //gestureが実行された部品をsenderとしている
        let card = sender.view!
        
        //gestureで動かした分を数値化
        let point = sender.translation(in: view)
        
        
        let xFromCenter = card.center.x - view.center.x
        
        //動かしているviewの中心位置を元の位置とgestureで動かした分の和にしている
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
        
        let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        
//        if xFromCenter > 0  {
//            thumbImageView.image = #imageLiteral(resourceName: "thumbUp")
//            thumbImageView.tintColor = UIColor.green
//        } else {
//            thumbImageView.image = #imageLiteral(resourceName: "thumbDown")
//            thumbImageView.tintColor = UIColor.red
//        }
        
        
//        thumbImageView.alpha =  abs(xFromCenter) / view.center.x
        
        //gestureが最後に指が離れた時に呼ばれる
       
        if sender.state == UIGestureRecognizerState.ended {
            
            if (item?.storeCount)! == 1 {
            }else {
            if card.center.x < 50 {
                // Move off to the left side
                UIView.animate(withDuration: 1, animations: {
//                    card.center = CGPoint(x:  0, y:  75)
                    card.alpha = 0
                    self.num += 1
                    
                    
                })
                if num == (item?.storeCount)! {
                    num = 0
                }
                self.newPage()
                return
            } else if card.center.x > (view.frame.width - 75) {
                // Move off to the right side
                UIView.animate(withDuration: 1, animations: {
//                    card.center = CGPoint(x: 100, y: 75)
                    card.alpha = 0
                    self.num += 1
                    
                })
                if num == (item?.storeCount)! {
                    num = 0
                }
                self.newPage()
                return
            
            
            }
            }
            UIView.animate(withDuration: 1, animations: {
//                
                card.center = CGPoint(x: self.view.center.x ,y: self.view.center.y - 30)
//                self.thumbImageView.alpha = 0
                card.alpha = 1
                card.transform = .identity
            }
            )
            
        
        
        
        //重複させないための数字
//        self.num += 1
        
        //numがいくつかを確認
//        print(num)
        
        
//        //animationで移動させる
//        UIView.animate(withDuration: 1, animations: {
//            self.baseView.center = CGPoint(x: self.baseView.center.x - 500 + point.x, y: self.baseView.center.y + 75 + point.y)
//            //            self.myPicture.center = CGPoint(x: self.baseView.center.x - 500, y: self.baseView.center.y + 25)
//            //            self.myLabel.center = CGPoint(x: self.baseView.center.x - 500, y: self.baseView.center.y + 25)
//            
//            self.baseView.alpha = 0
//            self.myPicture.alpha = 0
//            self.myLabel.alpha = 0
//            
//            self.newPage()
//            self.showPicture()
//            
//        })
       
//        //let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeCodeViewController.leftSwipeView(_:)))  //Swit2.2以前
//        let leftPan = UIPanGestureRecognizer(target: self, action: #selector(self.leftPanView(sender:)))  //Swift3
//        // レフトスワイプのみ反応するようにする
//        leftPan.direction = .left
//        // viewにジェスチャーを登録
//        self.baseView.addGestureRecognizer(leftPan)
//
//        self.newPage()
//        
        return
            
    }
    
   
  
    }



    func convertHalfWidthToFullWidth(half:String) -> String {
        let str = NSMutableString(string: half) as CFMutableString
        CFStringTransform(str, nil, kCFStringTransformFullwidthHalfwidth, false)
        return str as String
    }


    @IBAction func goBack(_ sender: UIButton) {
        if item?.storeCount == 1{
            return
        }
        if num == 0 {
            num = (item?.storeCount)! - 1
        }else {
        num -= 1
        }
        self.newPage()
        return
    }










}

