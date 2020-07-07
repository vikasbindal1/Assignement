
//
//  EventDetailViewController.swift
//  Assignment-IOS
//
//  Created by Vikas Gupta on 06/07/20.
//  Copyright © 2020 Vikas Gupta. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import Kingfisher
import GoogleMaps
import MapKit
import CoreLocation
class MyPlacemark: CLPlacemark {}

class EventDetailViewController: UIViewController{
    
    @IBOutlet weak var tbleventDetail: UITableView!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var btnAddTickets: UIButton!
    @IBOutlet weak var btnPromoteEvents: UIButton!
    
    // MARK: - Properties
    let headerViewMaxHeight: CGFloat = 250
    let headerViewMinHeight: CGFloat = 44 + UIApplication.shared.statusBarFrame.height

    
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    var responseData : JSON = []
    var arraySctionTittle = ["", "", "","View event organizer", "View event oponsers", "View Event Performers"]
    
     var HeaderViewY = UIView()
    var pagerCollectionViewArray = ["Overview", "Addintional Info", "Contact", "Comment"]
    
    var selectedIndex : IndexPath = IndexPath(row: 0, section: 0)
    var selectedSection = 3
    
    var sectionValue = 0
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        tbleventDetail.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tbleventDetail.register(UINib(nibName: "OverviewTableViewCell", bundle: nil), forCellReuseIdentifier: "OverviewTableViewCell")
        tbleventDetail.register(UINib(nibName: "PagerTableViewCell", bundle: nil), forCellReuseIdentifier: "PagerTableViewCell")
        tbleventDetail.register(UINib(nibName: "ViewEventTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewEventTableViewCell")
        
        btnAddTickets.layer.cornerRadius = 8
        btnAddTickets.clipsToBounds = true
        
        btnPromoteEvents.layer.cornerRadius = 8
        btnPromoteEvents.clipsToBounds = true
        
        postRequest(remainingUrl: "", parameters: ["user_id" : "0", "event_id" : "12", "longitude" : "78.1245", "latitude" : "12.1245"]) { (response) in
           
            self.responseData = response
            
            self.lblTittle.text = self.responseData["data"]["ev_title"].stringValue
            
            self.tbleventDetail.reloadData()
            
        }
        
        
    }

        func postRequest(remainingUrl:String, parameters: [String:Any] , completion: @escaping ((_ data: JSON) -> Void)) {
            print("parameters posted : ",parameters)
            
             let completeUrl = "http://saudicalendar.com/api/user/getEventDetail/" + remainingUrl

            print ("complete url : ", completeUrl)
            showActivityIndicator(uiView: self.view)
            Alamofire.request(completeUrl, method: .post, parameters: parameters, encoding: URLEncoding.httpBody).responseJSON { response in
                //debugPrint(response)
                if(response.data != nil){
                     self.activityIndicator.stopAnimating()//self.HIDE_ACTIVITY()
                    let swiftyJsonVar = JSON(response.result.value)
                    print("ResponseData : ",swiftyJsonVar)
                    completion(swiftyJsonVar)
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    
                }
                else
                {
                    self.activityIndicator.stopAnimating()
                    print("No response")
                    SVProgressHUD.showError(withStatus: "Unable to process request. Please try again.")
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    
    
    func SHOW_ACTIVITY(){
          
          SVProgressHUD.setBackgroundColor(UIColor.clear)
          SVProgressHUD.show()
          SVProgressHUD.setDefaultMaskType(.clear)

      }

      func HIDE_ACTIVITY(){
          
          SVProgressHUD.dismiss()
          
      }
    
    
    func showActivityIndicator(uiView: UIView){
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
           activityIndicator.center = uiView.center
           activityIndicator.hidesWhenStopped = true
           activityIndicator.style = .large
           uiView.addSubview(activityIndicator)
           activityIndicator.startAnimating()
    }
    
    

    
    
}


extension EventDetailViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 3{
            return 0
        }else{
            return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0{
            lblTittle.isHidden = true
            let cell = tbleventDetail.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            
            let imgURLString = self.responseData["data"]["ev_image"][0]["image"].stringValue
                    let newImageUrlStr = imgURLString.replacingOccurrences(of: " ", with: "%20")
                    let imageUrl =  URL(string:newImageUrlStr)
                   // cell.imgBanner.af_setImage(withURL:imageUrl!)
                    cell.imgHeader.kf.setImage(with: imageUrl)
            
            cell.lblType.text = self.responseData["data"]["category_name"].stringValue
            //"Entertainment"
            
            
            cell.lblTittle.text = self.responseData["data"]["ev_title"].stringValue
            cell.lblDesc.text = self.responseData["data"]["ev_event_type_name"].stringValue
            cell.lblView.text = self.responseData["data"]["ev_views"].stringValue
            cell.lblLike.text = self.responseData["data"]["ev_like"].stringValue
            cell.lblGroup.text = self.responseData["data"]["ev_like"].stringValue
            cell.lblDistance.text = "\((self.responseData["data"]["distance"].intValue)/1000) KM"
            
            
           
            
            
            return cell
        }else if indexPath.section == 1{
            
            let cell = tbleventDetail.dequeueReusableCell(withIdentifier: "PagerTableViewCell", for: indexPath) as! PagerTableViewCell
            cell.pagerCollectionView.delegate = self
            cell.pagerCollectionView.dataSource = self
            
            cell.pagerCollectionView.reloadData()
            return cell
            
        }else if indexPath.section == 2{
            
            let cell = tbleventDetail.dequeueReusableCell(withIdentifier: "OverviewTableViewCell", for: indexPath) as! OverviewTableViewCell
            let startDate =  self.responseData["data"]["ev_start_date"].stringValue
            let endDate =  self.responseData["data"]["ev_end_date"].stringValue
            var startDate1 = ""
            var endDate1 = ""
            if startDate != ""{
                startDate1 = convertDateFormater(startDate)
            }
            if endDate != ""{
                endDate1 = convertDateFormater(endDate)
            }
            cell.lblDate.text = "\(startDate1) - \(endDate1)"
            
            cell.lblTIme.text = "\(self.responseData["data"]["ev_start_time"].stringValue) - \(self.responseData["data"]["ev_end_time"].stringValue)"
            
            cell.lblPlace.text = "Arabic & Urdu"
            cell.lblGender.text = "Mens & Womens"
            cell.lbAGE.text = "10 - 25 years"
            
            cell.lblDetail.text = self.responseData["data"]["ev_description"].stringValue
            
            cell.lblEventCountry.text = "\(self.responseData["data"]["ev_region"].stringValue) , \(self.responseData["data"]["ev_country"].stringValue)"
            
            cell.lblEventAddress.text = self.responseData["data"]["ev_address"].stringValue
            let latitude = self.responseData["data"]["ev_lat"].doubleValue
            let longitude = self.responseData["data"]["ev_long"].doubleValue
            if latitude != 0.0 && longitude != 0.0{
                let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
                cell.viewMap.setRegion(region, animated: true)
                cell.viewMap.isUserInteractionEnabled = false
            }


            return cell
        }else {
            
            let cell = tbleventDetail.dequeueReusableCell(withIdentifier: "ViewEventTableViewCell", for: indexPath) as! ViewEventTableViewCell
            cell.eventCollectionView.delegate = self
            cell.eventCollectionView.dataSource = self
            cell.eventCollectionView.reloadData()
            sectionValue = indexPath.section
            
            return cell
        }
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section >= 3{
            if selectedSection == indexPath.section{
                return 180.0
            }else{
                return 0.0
            }
        }
        return UITableView.automaticDimension
    }
    

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let HeaderSectionCell = Bundle.main.loadNibNamed("EventHeaderTableViewCell", owner: self, options: nil)?.first as! EventHeaderTableViewCell
        HeaderSectionCell.btnPlusAction.tag = section
        
        HeaderSectionCell.btnPlusAction.addTarget(self, action: #selector(getSectionIndex), for: .touchUpInside)
        
        if selectedSection == section {
            HeaderSectionCell.btnPlusAction.setTitle("-", for: .normal)
        }
        
        HeaderSectionCell.lblHeaderName.text = arraySctionTittle[section]
        HeaderViewY = HeaderSectionCell
        return HeaderViewY
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visiableCells = tbleventDetail.visibleCells
        if let cell = visiableCells.first as? HeaderTableViewCell {
            if lblTittle.alpha <= 1.0{
                 lblTittle.isHidden = false
              // lblTittle.alpha += 0.005
            }else{
                debugPrint("not show")
            }
        }
    }
      
    
}

extension EventDetailViewController: UIScrollViewDelegate {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let y: CGFloat = scrollView.contentOffset.y
//        let newHeaderViewHeight: CGFloat = headerViewHeightConstraint.constant - y
//
//        if newHeaderViewHeight > headerViewMaxHeight {
//            headerViewHeightConstraint.constant = headerViewMaxHeight
//        } else if newHeaderViewHeight < headerViewMinHeight {
//            headerViewHeightConstraint.constant = headerViewMinHeight
//        } else {
//            headerViewHeightConstraint.constant = newHeaderViewHeight
//            scrollView.contentOffset.y = 0 // block scroll view
//        }
//    }
}


extension EventDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView.tag == 0{
            _ = UIFont(name: "Helvetica", size: 14)
            let fontAttributes = [NSAttributedString.Key: Any]() // it says name, but a UIFont works
            let myText = pagerCollectionViewArray[indexPath.row]
            let size = (myText as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
            return CGSize(width: size.width + 30, height: 48)
        }else{
            return CGSize(width: 140, height: 150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0{
            return pagerCollectionViewArray.count
        }else{
            if sectionValue == 3{
                return self.responseData["data"]["event_organizer"].count
            }else if sectionValue == 4{
                return self.responseData["data"]["event_sponser"].count
            }
            else{
                return self.responseData["data"]["event_performer"].count
            }
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 0{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagerCollectionViewID", for: indexPath) as! PagerCollectionViewCell
            
            cell.lblPager.text = pagerCollectionViewArray[indexPath.row]
            if selectedIndex == indexPath{
                cell.viewBottom.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
                cell.lblPager.textColor = UIColor.black
            }
            else{
                cell.lblPager.textColor = UIColor.darkGray
                cell.viewBottom.backgroundColor = UIColor.white
            }
            
            return cell
            
        }else{
            
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewEventCollectionViewCell1", for: indexPath) as! ViewEventCollectionViewCell
            
              if sectionValue == 3{
                
                cell.lblName.text = self.responseData["data"]["event_organizer"][indexPath.item]["o_name"].stringValue
                
                let imgURLString = self.responseData["data"]["event_organizer"][indexPath.item]["o_logo"].stringValue
                let newImageUrlStr = imgURLString.replacingOccurrences(of: " ", with: "%20")
                let imageUrl =  URL(string:newImageUrlStr)
                cell.imgUser.kf.setImage(with: imageUrl)
                
               }else if sectionValue == 4{
                    cell.lblName.text = self.responseData["data"]["event_sponser"][indexPath.item]["s_name"].stringValue
                               
                    let imgURLString = self.responseData["data"]["event_sponser"][indexPath.item]["s_logo"].stringValue
                               let newImageUrlStr = imgURLString.replacingOccurrences(of: " ", with: "%20")
                               let imageUrl =  URL(string:newImageUrlStr)
                               cell.imgUser.kf.setImage(with: imageUrl)
                }
                else{
                    cell.lblName.text = self.responseData["data"]["event_performer"][indexPath.item]["p_name"].stringValue
                    
                    let imgURLString = self.responseData["data"]["event_performer"][indexPath.item]["p_logo"].stringValue
                    let newImageUrlStr = imgURLString.replacingOccurrences(of: " ", with: "%20")
                    let imageUrl =  URL(string:newImageUrlStr)
                    cell.imgUser.kf.setImage(with: imageUrl)
                }
            
            
          return cell
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView.tag == 0 {
            selectedIndex = indexPath
            collectionView.reloadData()
        }
        
    }
    
    @objc func getSectionIndex(_ sender: UIButton){
        selectedSection = sender.tag
        tbleventDetail.reloadData()
    }
    
    func convertDateFormater(_ date: String) -> String
       {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd"
           let date = dateFormatter.date(from: date)
           dateFormatter.dateFormat = "dd MMM yyyy"
           return  dateFormatter.string(from: date!)

       }
    
}
