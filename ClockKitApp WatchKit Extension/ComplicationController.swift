//  Taylor Landes
//
//  ComplicationController.swift
//  ClockKitApp WatchKit Extension
//
//  Created by CIS on 12/14/15.
//  Copyright © 2015 CIS. All rights reserved.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    let timeLineText = ["John 14:6", "Hebrews 9:28", "Jeremiah 29:11", "Philippians 4:13"]
    
    func getSupportedTimeTravelDirectionsForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.Forward])
    }
    
    func getTimelineStartDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void)
    {
        let currentDate = NSDate()
        handler(currentDate)
    }
    
    func getTimelineEndDateForComplication(complication: CLKComplication, withHandler handler: (NSDate?) -> Void)
    {
        let currentDate = NSDate()
        let endDate = currentDate.dateByAddingTimeInterval(NSTimeInterval(4 * 60 * 60))
        
        handler(endDate)
    }
    
    func getPrivacyBehaviorForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.ShowOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntryForComplication(complication: CLKComplication, withHandler handler: ((CLKComplicationTimelineEntry?) -> Void))
    {
        // Call the handler with the current timeline entry
        if complication.family == .ModularLarge
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            let timeString = dateFormatter.stringFromDate(NSDate())
            
            let entry = createTimeLineEntry(timeString, bodyText: timeLineText[0], date: NSDate())
            
            handler(entry)
        }
        else
        {
            handler(nil)
        }
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, beforeDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void))
    {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntriesForComplication(complication: CLKComplication, afterDate date: NSDate, limit: Int, withHandler handler: (([CLKComplicationTimelineEntry]?) -> Void))
    {
        // Call the handler with the timeline entries after to the given date
        var timeLineEntryArray = [CLKComplicationTimelineEntry]()
        var nextDate = NSDate(timeIntervalSinceNow: 1 * 60 * 60)
        
        for index in 1...(timeLineText.count-1)
        {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "hh:mm"
            
            
            
            
            let timeString = dateFormatter.stringFromDate(nextDate)
            
            let entry = createTimeLineEntry(timeString, bodyText: timeLineText[index], date: nextDate)
            
            timeLineEntryArray.append(entry)
            
            nextDate = nextDate.dateByAddingTimeInterval(1 * 60 * 60)
        }
        handler(timeLineEntryArray)
    }
    
    // MARK: - Update Scheduling
    
    func getNextRequestedUpdateDateWithHandler(handler: (NSDate?) -> Void) {
        // Call the handler with the date when you would next like to be given the opportunity to update your complication content
        handler(nil);
    }
    
    // MARK: - Placeholder Templates
    
    func getPlaceholderTemplateForComplication(complication: CLKComplication, withHandler handler: (CLKComplicationTemplate?) -> Void) {
        // This method will be called once per supported complication, and the results will be cached
        let template = CLKComplicationTemplateModularLargeStandardBody()
        let book = UIImage(named: "book")
        
        template.headerImageProvider = CLKImageProvider(onePieceImage: book!)
        
        template.headerTextProvider = CLKSimpleTextProvider(text: "Verse of the Hour")
        template.body1TextProvider = CLKSimpleTextProvider(text: "Bible Verse Schedule")
        
        handler(template)
    }
    
    func createTimeLineEntry(headerText: String, bodyText: String, date: NSDate) -> CLKComplicationTimelineEntry
    {
        let template = CLKComplicationTemplateModularLargeStandardBody()
        let book = UIImage(named: "book")
        
        template.headerImageProvider = CLKImageProvider(onePieceImage: book!)
        template.headerTextProvider = CLKSimpleTextProvider(text: headerText)
        template.body1TextProvider = CLKSimpleTextProvider(text: bodyText)
        
        let entry = CLKComplicationTimelineEntry(date: date, complicationTemplate: template)
        
        return(entry)
    }
    
}
