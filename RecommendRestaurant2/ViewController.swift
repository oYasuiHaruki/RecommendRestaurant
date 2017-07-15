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
    
    
    
    
    var testManager:CLLocationManager = CLLocationManager()
    
    
    
    //structのitemのインスタンスを作成
    var item : Item? = nil
    
    //GenreViewControllerから送られた情報を保存
    var sIndex = 0
    
    //店が何番目かを保存する数
    var num = 0
    
    //店の情報が載ったUIViewの作成
    var baseView:UIView = UIView(frame: CGRect(x: 100, y: 200, width: 250, height: 300))
    
    //写真を置くUIImageViewの作成
    var myPicture:UIImageView = UIImageView(frame: CGRect(x: 25, y: 10, width: 200, height: 200))
    
    //viewの中に店名を表記
    var myLabel:UILabel = UILabel(frame: CGRect(x: 25, y: 200, width: 200, height: 30))
    
    //viewの中にcatch文を表記
    var myLabel2:UILabel = UILabel(frame: CGRect(x: 25, y: 250, width: 200, height: 30))

    
    
    
    var divisor : CGFloat!
    
    //グローバル変数を使うために定義
    var appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
      
        

        
        
        //デリゲート先を自分に設定する。
        testManager.delegate = self
        
        
        //位置情報の利用許可を変更する画面をポップアップ表示する。
        testManager.requestWhenInUseAuthorization()
        
        //位置情報の取得を要求する。
        testManager.requestLocation()
        
        
        
        
        
        divisor = (view.frame.width / 2) / 0.61
    
        //判別するために色をつける
        baseView.backgroundColor = UIColor.orange
        
        baseView.center = CGPoint(x: view.center.x, y: view.center.y)

        
        //初期画面の写真を表示
        myPicture.sd_setImage(with: item?.photoURLs[num])
        
        //テキストを表示
        myLabel.text = "\(item?.storeNames[num] as! String)"
        
        //テキストを表示
        myLabel2.text = "\(item?.catchInformation[num] as! String)"

        

        
        // スワイプを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))
        
        // viewにジェスチャーを登録
        self.baseView.addGestureRecognizer(Pan)
        
        
        //元々のviewの上に作成したbaseViewを載せる
        self.view.addSubview(baseView)
        
        // baseViewの上にmyPictureを載せる
        self.baseView.addSubview(myPicture)
        
        //baseViewの上にmyLabelを配置
        self.baseView.addSubview(myLabel)
        
        self.baseView.addSubview(myLabel2)
        
//        self.baseView.layer.borderColor = UIColor.brown as! CGColor
//        myPicture.layer.borderWidth = 10
        
        baseView.layer.cornerRadius = 10.0
        baseView.layer.masksToBounds = true

        
//        myPicture.layer.cornerRadius = 10.0
//        myPicture.layer.masksToBounds = true

         
    }
    
    
      
    @IBAction func moveMap(_ sender: UIButton) {
        
        
        let myGeocoder:CLGeocoder = CLGeocoder()
        
        var str = item?.address[num]
        
        let arr2 = str?.components(separatedBy: "　")
        let arr3 = arr2?[0].components(separatedBy: " ")
        
        print(arr3?[0])   // apple
//        print(arr2?[1])   // orange
        
        
        var address1 = convertHalfWidthToFullWidth(half:(arr3?[0])!)
        
        
        print(address1)
        
        
        
        //住所を座標に変換する。
        myGeocoder.geocodeAddressString(address1, completionHandler: {(placemarks, error) in
            
//            print(self.item?.address)
            //item.addressに配列としてちゃんと入ってない可能性
            print(self.num)
//            print(placemarks)
//  if(error == nil) {
    for placemark in placemarks! {
        let location:CLLocation = placemark.location!
        
//        print("location:\(location)")
        
        
        //マップアプリに渡す目的地の位置情報を作る。
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let placemark = MKPlacemark(coordinate:coordinate, addressDictionary:nil)
        let mapItem = MKMapItem(placemark: placemark)
        
        //起動オプション
        let option:[String:AnyObject] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving as AnyObject, //車で移動
            MKLaunchOptionsMapTypeKey : MKMapType.hybrid.rawValue as AnyObject]  //地図表示はハイブリッド
        
        //マップアプリを起動する。
        mapItem.openInMaps(launchOptions: option)
        
        
    }
//        }
//  else {
//    print("エラー")
//    
//            }
        })}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func newPage(){
        
        num += 1
        
        //新規のbaseViewを作成
        baseView = UIView(frame: CGRect(x: 100, y: 100, width: 250, height: 350))
        
        //写真を表示
        myPicture = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 250))
        myPicture.sd_setImage(with: item?.photoURLs[num])
        
        //店名を表示
        myLabel = UILabel(frame: CGRect(x: 10, y: 260, width: 200, height: 150))
        myLabel.text = "\(item?.storeNames[num] as! String)"
        
        //backgroundColorを変更
        baseView.backgroundColor = UIColor.orange
        
        //gesturePanを定義
        let Pan = UIPanGestureRecognizer(target: self, action: #selector(self.PanView(sender:)))  //Swift3
        
        //viewたちを追加
        view.addSubview(baseView)
        baseView.addSubview(myPicture)
        baseView.addSubview(myLabel)
        baseView.addGestureRecognizer(Pan)

        
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
        card.center = CGPoint(x: baseView.center.x , y: baseView.center.y )
        
        
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
            
            
            if card.center.x < 50 {
                // Move off to the left side
                UIView.animate(withDuration: 0.3, animations: {
                    card.center = CGPoint(x: card.center.x - 50, y: card.center.y + 75)
                    card.alpha = 0
                    self.num += 1
                    self.newPage()
                    
                })
                return
            } else if card.center.x > (view.frame.width - 75) {
                // Move off to the right side
                UIView.animate(withDuration: 1, animations: {
                    card.center = CGPoint(x: card.center.x + 50, y: card.center.y + 75)
                    card.alpha = 0
                    self.num += 1
                    self.newPage()
                })
                return
            
            
            }
            UIView.animate(withDuration: 1, animations: {
//                
                card.center = CGPoint(x:225 ,y:275)
//                self.thumbImageView.alpha = 0
                card.alpha = 1
                card.transform = .identity
            })
            
        
        
        
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
////        leftPan.direction = .left
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












}

