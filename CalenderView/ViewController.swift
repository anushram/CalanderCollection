//
//  ViewController.swift
//  CalendarView
//
//  Created by K Saravana Kumar on 19/06/19.
//  Copyright © 2019 K Saravana Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    private let cellIdentifier = "calendarCollectionViewCell"
    private let cellReuseIdentifier = "calendarReuseCollectionViewCell"
    
    @IBOutlet weak var calendarCollView: UICollectionView!
    
    @IBOutlet weak var dateMonth: UILabel!
    
    var monthInfo: [SectionDateInformation:[CellDateInformation]] =  [SectionDateInformation:[CellDateInformation]]()
    
    var sectionInfo = [SectionDateInformation]()
    
    var currentDate = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var lastDate:Date
        
        var lastDateComponenet:Date
        
        currentDate = DateFormatManager.sharedInstance.getCurrentDateString()
        
        print(currentDate)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.calendarCollView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellReuseIdentifier)
        
        
        
//        calendarCollView.register(UINib.init(nibName: "HeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:cellReuseIdentifier)
        
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        
//        let firstDateString = DateFormatManager.sharedInstance.getStringFromDateWithFormat(date: NSDate(), format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
        //"01/01/2019"
        
        let firstDate = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: "01/01/2017", format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
        
        let secondDate = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: "01/01/2025", format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
        
        //let date1 = calendar.startOfDay(for: firstDate as! Date) as Date
        //let date2 = calendar.startOfDay(for: secondDate as! Date) as Date
        
        
        
        var date1 = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: DateFormatManager.sharedInstance.getStringFromDateWithFormat(date: calendar.startOfDay(for: firstDate! as Date) as NSDate, format: DateFormatManager.sharedInstance.kDateMonthYearFormat), format: DateFormatManager.sharedInstance.kDateMonthYearFormat)! as Date
        
        var date2 = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: DateFormatManager.sharedInstance.getStringFromDateWithFormat(date: calendar.startOfDay(for: secondDate! as Date) as NSDate, format: DateFormatManager.sharedInstance.kDateMonthYearFormat), format: DateFormatManager.sharedInstance.kDateMonthYearFormat)! as Date
        
        let components = calendar.dateComponents([.weekday], from: date1, to: date2)
        lastDate = date1
        lastDateComponenet = date1
        
        //var [[SectionDateInformation:[CellDateInformation]]] = <#value#>
        
        
        
        
        while date1 < date2 {
            
            let sectionDate = SectionDateInformation()
            
            let date1String = DateFormatManager.sharedInstance.getStringFromDateWithFormat(date: date1 as NSDate, format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
            
            let valMonth = Calendar.current.dateComponents([.month], from: date1)
            let valYear = Calendar.current.dateComponents([.year], from: date1)
            
            sectionDate.dateInfo = date1String
            sectionDate.monthInfo = valMonth.month!
            sectionDate.yearInfo = valYear.year!
            
            lastDateComponenet = Calendar.current.date(byAdding: .month, value: 1, to: lastDateComponenet)!
            
            var cellDateInformationArray = [CellDateInformation]()
            
            while date1 < lastDateComponenet {
                
                
                
                let calldate :CellDateInformation = CellDateInformation()
                
                let val = Calendar.current.dateComponents([.weekday], from: date1)
                
                let valDay = Calendar.current.dateComponents([.day], from: date1)
                
                let valMonth = Calendar.current.dateComponents([.month], from: date1)
                
                print("weekDay",val.weekday!,valDay.day!,valMonth.month!)
                let date1String = DateFormatManager.sharedInstance.getStringFromDateWithFormat(date: date1 as NSDate, format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
                
             date1 = Calendar.current.date(byAdding: .day, value: 1, to: date1)!
                
                
                calldate.dayInfo = valDay.day!
                calldate.dateInfo = date1String
                calldate.weekDayInfo = val.weekday!
                calldate.monthInfo = valMonth.month!
                
                cellDateInformationArray.append(calldate)
                
            //let componentsVal = calendar.dateComponents([.weekday], from: date1, to: date2)
                
            }
            
            let vvvv = (cellDateInformationArray.first?.weekDayInfo)!
            print("test1",cellDateInformationArray.count)
            
            var beforeDate = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: (cellDateInformationArray.first?.dateInfo)!, format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
            
            for _ in 1 ..< vvvv {
                
                beforeDate = Calendar.current.date(byAdding: .day, value: -1, to: beforeDate! as Date)! as NSDate
                let valDay = Calendar.current.dateComponents([.day], from: beforeDate! as Date)
                print("00000")
                let calldateDummy :CellDateInformation = CellDateInformation()
                calldateDummy.dayInfo = valDay.day!
                cellDateInformationArray.insert(calldateDummy, at: 0)
                print("test2",cellDateInformationArray.count)
            }
            
            sectionInfo.append(sectionDate)
            monthInfo.updateValue(cellDateInformationArray, forKey: sectionDate)
            //monthInfo[sectionDate] = cellDateInformationArray
            
            //date1 = Calendar.current.date(byAdding: .month, value: 1, to: date1)!
            
            
            
            
            //lastDateComponenet = dateFrom
            //lastDate = dateFrom
            
            
        }
        
        self.dateMonth.text = DateFormatManager.sharedInstance.getMonthAndYear(dateString: sectionInfo[0].dateInfo)
        
        print("count",monthInfo.count)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return sectionInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // offset by the number of months
        
        var obj = sectionInfo[section] as! SectionDateInformation
        
        let val = monthInfo[obj]
        
        print("bbbbb=",(val?.count)!)
        
        //monthInfo[]
        return (val?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CalendarCollectionViewCell
        
        var obj = sectionInfo[indexPath.section] as! SectionDateInformation
        
        let val = monthInfo[obj]
        
        let objVal =  val![indexPath.row]
        
        if objVal.dateInfo == currentDate{
            
           let val  = currentDate.components(separatedBy: "/")
            
            if objVal.dayInfo == Int(val.first!){
                cell.dayText.backgroundColor = UIColor.red
            }else{
                cell.dayText.backgroundColor = UIColor.blue
                
            }
            
        }else{
            cell.dayText.backgroundColor = UIColor.blue
            
        }
        
        if objVal.dateInfo == "" {
            cell.isUserInteractionEnabled = false
            cell.dayText.text = String(objVal.dayInfo)
            cell.dayText.alpha = 0.3
            //cell.isHidden = true
            
        }else {
            cell.isHidden = false
            cell.dayText.text = String(objVal.dayInfo)
            cell.isUserInteractionEnabled = true
             cell.dayText.alpha = 1.0
            
        }
        
        
        
        return cell
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        
        var value = Float((self.calendarCollView.contentOffset.x) / (self.calendarCollView.frame.size.width))
        
        value = floor(value)
        
        print("sssss=",value)
        
        let sectionValue = sectionInfo[Int(value)]
        
        //sectionValue.monthInfo
        
        self.dateMonth.text = DateFormatManager.sharedInstance.getMonthAndYear(dateString: sectionValue.dateInfo)
        
//        let dateFormatterGet = DateFormatter()
//        dateFormatterGet.dateFormat = "dd/MM/yyyy"
//
//        let dateFormatterPrint = DateFormatter()
//        //dateFormatterPrint.dateFormat = "MMM dd,yyyy"
//        dateFormatterPrint.dateFormat = "MMM, yyyy"
//
//        if let date = dateFormatterGet.date(from: sectionValue.dateInfo) {
//            print(dateFormatterPrint.string(from: date))
//
//
//        } else {
//            print("There was an error decoding the string")
//        }
        
    }
    
    @IBAction func clickCurrentAction(sender: UIButton){
        
        var indexValue = 0
        
        
        for (index,value) in sectionInfo.enumerated() {
            
            
            let val = monthInfo[value]
            
            for valueMonth in val! {
                
                if valueMonth.dateInfo == currentDate {
                    
                    indexValue = index
                    
                }
                
            }
            
        }
        
        let collOffset = Float(indexValue) * Float(self.calendarCollView.frame.size.width)
        
        self.dateMonth.text = DateFormatManager.sharedInstance.getMonthAndYear(dateString: sectionInfo[indexValue].dateInfo)
        
        self.calendarCollView.scrollToItem(at: IndexPath.init(item: 0, section: indexValue), at: .left, animated: true)
        
    }

    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
//
//        
//
//        return CGSize.init(width: self.calendarCollView.frame.size.width/10, height: 50)
//
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//
//        return UIEdgeInsetsMake(2,2,2,2);
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat{
//        return 10.0
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
//        return 10.0
//    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//
//        switch kind {
//
//        case UICollectionElementKindSectionHeader:
//
////            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath)
////
////            headerView.backgroundColor = UIColor.blue
////            return headerView
//
//            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! HeaderView
//
//            headerView.frame = CGRect(x: headerView.frame.origin.x, y: headerView.frame.origin.y, width: self.calendarCollView.frame.width, height: 100)
//
//            return headerView
//
//
//        default:
//
//            assert(false, "Unexpected element kind")
//        }
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

