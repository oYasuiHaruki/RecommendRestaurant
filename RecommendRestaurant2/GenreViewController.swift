//
//  GenreViewController.swift
//  RecommendRestaurant2
//
//  Created by 安井春輝 on 2017/06/27.
//  Copyright © 2017 haruki yasui. All rights reserved.
//

import UIKit

class GenreViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var genre = ["","居酒屋","和食","洋食","ラーメン"]
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTableView.delegate = self
        myTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genre.count
    }
    
    
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
