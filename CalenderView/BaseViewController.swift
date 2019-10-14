//
//  BaseViewController.swift
//  CalendarView
//
//  Created by K Saravana Kumar on 02/07/19.
//  Copyright © 2019 K Saravana Kumar. All rights reserved.
//

import UIKit
import CoreData

class BaseViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate {
    
    private let cellIdentifier = "calendarBaseCollectionViewCell"
    private let cellReuseIdentifier = "calendarBaseReuseCollectionViewCell"
    
    @IBOutlet weak var calendarCollView: UICollectionView!
    
    var monthInfo: [SectionDateInformation:[CellDateInformation]] =  [SectionDateInformation:[CellDateInformation]]()
    
    var sectionInfo = [SectionDateInformation]()
    
    var currentDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        /////Users/ksaravanakumarmacair/Library/Developer/CoreSimulator/Devices/E53F9DF4-9136-4572-A800-142D20796871/data/Containers/Data/Application/2A3A5497-25D6-4B45-8C8C-4C5A9732934C/Library/Application%20Support/CalendarView.sqlite)
        //Users/ksaravanakumarmacair/Library/Developer/CoreSimulator/Devices/E53F9DF4-9136-4572-A800-142D20796871/data/Containers/Data/Application/5045412B-5FEA-4990-8C03-A4A567488DDD/Library/Application%20Support/CalendarView.sqlite)
        ///Users/ksaravanakumarmacair/Library/Developer/CoreSimulator/Devices/E53F9DF4-9136-4572-A800-142D20796871/data/Containers/Data/Application/60DE5DBC-3AEA-49C7-874E-1B75CE1FCCCB/Library/Application%20Support/CalendarView.sqlite
//        collectionView.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier:collectionViewHeaderFooterReuseIdentifier)
        
        //calendarCollView.register(UINib.init(nibName: "BaseCollReuseView", bundle: nil), forCellWithReuseIdentifier: cellReuseIdentifier)
        
        let value = self.managedContextObject()
        
        
        
        
        
        //newUser.setValue("", forKey: "")
        
        
        calendarCollView.register(UINib.init(nibName: "BaseCollReuseView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: cellReuseIdentifier)

        //calendarCollView.register(BaseCollReuseView.self, forCellWithReuseIdentifier: cellReuseIdentifier)
        
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
        
        let firstDate = DateFormatManager.sharedInstance.getDateFromStringWithFormat(dateString: "01/01/2019", format: DateFormatManager.sharedInstance.kDateMonthYearFormat)
        
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
            
            var dateInformationEntity = [AnyObject]()
            
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
                
                let dateEntity = NSEntityDescription.insertNewObject(forEntityName: "DateInformation", into: value)
                //let entity = NSEntityDescription.entity(forEntityName: , in: value)
                //let newUser = NSManagedObject(entity: entity!, insertInto: value)
                dateEntity.setValue(calldate.dateInfo, forKey: "dateInfo")
                dateEntity.setValue(calldate.monthInfo, forKey: "monthInfo")
                dateEntity.setValue(calldate.dayInfo, forKey: "dayInfo")
                dateEntity.setValue(calldate.weekDayInfo, forKey: "weekDayInfo")
                dateInformationEntity.append(dateEntity)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.saveContext()
                
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
            let entity = NSEntityDescription.insertNewObject(forEntityName: "SectionDateInformation", into: value)
            //let entity = NSEntityDescription.entity(forEntityName: , in: value)
            //let newUser = NSManagedObject(entity: entity!, insertInto: value)
            entity.setValue(sectionDate.dateInfo, forKey: "dateInfo")
            entity.setValue(sectionDate.monthInfo, forKey: "monthInfo")
            entity.setValue(sectionDate.yearInfo, forKey: "yearInfo")
            let addObject = entity.mutableSetValue(forKey: "dateinformation")
            for value in dateInformationEntity {
                addObject.add(value)
                do {
                    try entity.managedObjectContext?.save()
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
            }
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.saveContext()
            
            monthInfo.updateValue(cellDateInformationArray, forKey: sectionDate)

        // Do any additional setup after loading the view.
    }
        
        self.fetchRequest(object: value)
        
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
                //cell.dayText.layer.cornerRadius = cell.dayText.frame.size.width/2
                //cell.dayText.layer.masksToBounds = true
                
            }else{
                cell.dayText.backgroundColor = UIColor.white
                
            }
            
        }else{
            cell.dayText.backgroundColor = UIColor.white
            
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize.init(width: (calendarCollView.frame.size.width/2)/7, height: (calendarCollView.frame.size.width/2)/7)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView{
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            let headerView = calendarCollView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! BaseCollReuseView
            
            headerView.frame = CGRect.init(x: headerView.frame.origin.x, y: headerView.frame.origin.y, width: (calendarCollView.frame.size.width/2) - 35, height: 58.0)
            
            let value = sectionInfo[indexPath.section]
            
            
            headerView.sectionDateHeader.text = DateFormatManager.sharedInstance.getMonthAndYear(dateString: value.dateInfo)
            
            //headerView.backgroundColor = UIColor.blue
            return headerView
            
        
            
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize{
        return CGSize.init(width: calendarCollView.frame.size.width/2 - 35, height: 58.0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets{
//        return UIEdgeInsets.init(top: 0, left: 35.0, bottom: 0, right: 35.00)
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func managedContextObject() -> NSManagedObjectContext  {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        return context
    }
    
    func fetchRequest(object: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "SectionDateInformation")
        
        do {
            let fetchResults = try object.fetch(fetchRequest)
            let val = fetchResults.first
            let nnnn = (val as AnyObject).value(forKey: "dateinformation") as! NSMutableSet
            let sss = nnnn.allObjects
            let vvv = sss.first as! DateInformation
            print(vvv.value(forKey: "weekDayInfo"))
//            for item in fetchResults {
//                print((item as AnyObject).value(forKey: "monthInfo")!)
//                let val = (item as AnyObject).value(forKey: "dateinformation")!
//                print(val)
//            }
        } catch let error as NSError {
            print(error.description)
        }
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
