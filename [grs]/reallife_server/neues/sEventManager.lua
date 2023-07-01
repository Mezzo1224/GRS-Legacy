function isDateInRange(startDay, startMonth, endDay, endMonth, targetDay, targetMonth)
    if targetMonth < startMonth or targetMonth > endMonth then
      return false
    elseif targetMonth == startMonth and targetDay < startDay then
      return false
    elseif targetMonth == endMonth and targetDay > endDay then
      return false
    end
    
    return true
  end


function enableEventsAutomatically ()
    local time = getRealTime()
    local month = time.month+1
    local monthday = time.monthday
    for k, v in pairs(SharedConfig["main"].events) do
        if isDateInRange(v.startDate[1], v.startDate[2], v.endDate[1], v.endDate[2], monthday, month) then
            v.isRunning = true
            print("Das "..v.eventName.." ("..k..") wurde aktiviert.", v.isRunning)
            print("Es läuft vom "..v.startDate[1].."."..v.startDate[2].." bis zum  "..v.endDate[1].."."..v.endDate[2])
        end
    end
 end