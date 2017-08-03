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
    var baseView:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
    
    //情報を囲むビューの作成
    var baseView2:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
    
    //写真を置くUIImageViewの作成
    var myPicture:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
    var myPicture2:UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
    
    //店名を表記したラベルの作成
    var myLabelStoreName:UILabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 60))
    var myLabelStoreName2:UILabel = UILabel(frame: CGRect(x: 0, y: 200, width: 250, height: 60))
    
    //catch文を表記したラベルの作成
    var myLabelCatchSentence:UILabel = UILabel(frame: CGRect(x: 0, y: 250, width: 250, height: 60))
    var myLabelCatchSentence2:UILabel = UILabel(frame: CGRect(x: 0, y: 250, width: 250, height: 60))
    
    //営業時間を表記したラベルの作成
    var myLabelOpenTime:UILabel = UILabel(frame: CGRect(x: 0, y: 300, width: 250, height: 60))
    var myLabelOpenTime2:UILabel = UILabel(frame: CGRect(x: 0, y: 300, width: 250, height: 60))
    
    //価格を表記したラベルの作成
    var myLabelPrice:UILabel = UILabel(frame: CGRect(x: 0, y: 350, width: 250, height: 60))
    var myLabelPrice2:UILabel = UILabel(frame: CGRect(x: 0, y: 350, width: 250, height: 60))

    //navigationのタイトルラベル
    @IBOutlet weak var viewTitle: UINavigationItem!
    
    var divisor : CGFloat!
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //Mapに飛ぶボタン
    @IBOutlet weak var goMap: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        self.navigationController?.navigationBar.tintColor = .orange
        
        //navigationのタイトルを編集
        viewTitle.title = item?.genreName
        
        goMap.imageView?.image = UIImage(named: "Maps-icon4.png")
        
        //カードが現在何枚目かを示す数字
        countNum.text = "\(num + 1)"
        
        //そのジャンルにカードが何枚あるかを示す数字
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
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 10)
        baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 10)
    
        //初期画面の写真を表示
        myPicture.sd_setImage(with: item?.photoURLs[num])
        myPicture.contentMode = .scaleToFill
        
        //カードが１枚の時以外に実行
        if (item?.storeCount)! != 1 {
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
        
        if (item?.storeCount)! != 1 {
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
        
        if (item?.storeCount)! != 1 {
        myLabelCatchSentence2.text = "\(item?.catchInformation[num + 1] as! String)"
        myLabelCatchSentence2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 15)
        myLabelCatchSentence2.textAlignment = .center
        myLabelCatchSentence2.numberOfLines = 0
        }
        
        
        //文字列の編集を行う
        
        //part1
        var timeString:String = ""
        var time = item?.openTime[num].components(separatedBy: "（料理")
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
        
        //part2
        var timeString2:String = ""
        if (item?.storeCount)! != 1 {
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
        }

        //編集したテキストを表示(開店時間)
        myLabelOpenTime.text = timeString
        myLabelOpenTime.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelOpenTime.textAlignment = .center
        myLabelOpenTime.numberOfLines = 0
        
        if (item?.storeCount)! != 1 {
        myLabelOpenTime2.text = timeString2
        myLabelOpenTime2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelOpenTime2.textAlignment = .center
        myLabelOpenTime2.numberOfLines = 0
        }
        
        //平均予算をテキストに表示
        myLabelPrice.text = "平均予算：\(item?.price[num] as! String)"
        myLabelPrice.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelPrice.textAlignment = .center
        myLabelPrice.numberOfLines = 0
        
        if (item?.storeCount)! != 1 {
        myLabelPrice2.text = "平均予算：\(item?.price[num + 1] as! String)"
        myLabelPrice2.font =  UIFont(name: "HelveticaNeue-UltraLight", size: 12)
        myLabelPrice2.textAlignment = .center
        myLabelPrice2.numberOfLines = 0
        }
        
        // スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))
        
        // baseViewにジェスチャーを登録
        self.baseView.addGestureRecognizer(Pan)
        
        //元々のviewの上に作成したbaseViewを載せる
        //baseViewをbaseView2の上にのせる
        if (item?.storeCount)! != 1 {
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
        
        //baseViewの角を丸くする
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
    }
    
    //mapボタンを押した時に発動
    @IBAction func moveMap(_ sender: UIButton) {
        
        let myGeocoder:CLGeocoder = CLGeocoder()
        
        //店の住所をstrに保存
        var str = item?.address[num]
        let arr2 = str?.components(separatedBy: "　")
        let arr3 = arr2?[0].components(separatedBy: " ")
        
        //住所を座標に変換する。
        myGeocoder.geocodeAddressString((arr3?[0])!, completionHandler: {(placemarks, error) in
        
        //item.addressに配列としてちゃんと入ってない可能性
        if(error == nil) {
            for placemark in placemarks! {
                let location:CLLocation = placemark.location!
                
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
        //mapアプリが起動できなかった時
        else {
            //アクションシートを作成
            let alertController = UIAlertController(title: "エラーが起きました。", message: "申し訳ありません。地図が読み取れませんでした。\nこのお店の住所は\n\((self.item?.address[self.num])!)です。", preferredStyle: .alert)
            
            //アクティビティ１ボタンを追加
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
     
            //アクションシートを表示
            self.present(alertController, animated: true, completion: nil)
        }})
    }
    
    
    //新しいカードを作成するメソッド
    func newPage(){
        
        //baseView2を隠す
        baseView2.isHidden = true
        
        //時間を編集
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
        
        //カードが最後の場合
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
            baseView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
            baseView2 = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
            
            baseView.center = CGPoint(x: view.center.x, y: view.center.y - 10)
            baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 10)
            
            //  baseView.layer.borderColor = UIColor.orange as! CGColor
            
            //写真を表示
            //  myPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
            myPicture.sd_setImage(with: item?.photoURLs[num])
            myPicture2.sd_setImage(with: item?.photoURLs[0])
            
            //店名を表示
            //myLabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 150))
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
            
            //viewたちを追加
            view.addSubview(baseView2)
            view.addSubview(baseView)
            
            //baseView.sendSubview(toBack: baseView2)
            baseView.addSubview(myPicture)
            baseView.addSubview(myLabelStoreName)
            baseView.addSubview(myLabelCatchSentence)
            baseView.addSubview(myLabelOpenTime)
            baseView.addSubview(myLabelPrice)
            baseView.addGestureRecognizer(Pan)
            
            //baseView2.sendSubview(toBack: baseView2)
            baseView2.addSubview(myPicture2)
            baseView2.addSubview(myLabelStoreName2)
            baseView2.addSubview(myLabelCatchSentence2)
            baseView2.addSubview(myLabelOpenTime2)
            baseView2.addSubview(myLabelPrice2)
            
            countNum.text = "\(num + 1)"
            denominator.text = "/\((item?.storeCount)!)"
        }
         
        //カードが最後じゃない場合
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
        baseView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
        baseView2 = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 400))
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y - 10)
        baseView2.center = CGPoint(x: view.center.x, y: view.center.y - 10)
        
        //写真を表示
        myPicture.sd_setImage(with: item?.photoURLs[num])
        myPicture2.sd_setImage(with: item?.photoURLs[num + 1])

        //店名を表示
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

        //viewたちを追加
        view.addSubview(baseView2)
        view.addSubview(baseView)
        
        //baseView.sendSubview(toBack: baseView2)
        baseView.addSubview(myPicture)
        baseView.addSubview(myLabelStoreName)
        baseView.addSubview(myLabelCatchSentence)
        baseView.addSubview(myLabelOpenTime)
        baseView.addSubview(myLabelPrice)
        baseView.addGestureRecognizer(Pan)
        
        //baseView2.sendSubview(toBack: baseView2)
        baseView2.addSubview(myPicture2)
        baseView2.addSubview(myLabelStoreName2)
        baseView2.addSubview(myLabelCatchSentence2)
        baseView2.addSubview(myLabelOpenTime2)
        baseView2.addSubview(myLabelPrice2)
        
        countNum.text = "\(num + 1)"
        denominator.text = "/\((item?.storeCount)!)"
        }
        
        //myPicture.layer.masksToBounds = true
        
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
        card.center = CGPoint(x: card.center.x + (point.x)/4, y: card.center.y + (point.y)/4)
        
        let scale = min(100/abs(xFromCenter), 1)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor).scaledBy(x: scale, y: scale)
        
        //gestureが最後に指が離れた時に呼ばれる
       
        if sender.state == UIGestureRecognizerState.ended {
            
            if (item?.storeCount)! == 1 {
            }else {
            if card.center.x < 50 {
                // Move off to the left side
                UIView.animate(withDuration: 1, animations: {
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
                card.center = CGPoint(x: self.view.center.x ,y: self.view.center.y - 10)
                card.alpha = 1
                card.transform = .identity
            }
            )
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

