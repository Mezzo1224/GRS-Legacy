-- // Fahrzeuge
cooperationVehicleList = {}
cooperationVehicle = {}
cooperationVehicleFromID = {}
-- // Firma allgemein
cooperation = {}
cooperationRanks = {}
-- // Einstellungen
cooperationLevelCosts = {
    [1] = 100000,
    [2] = 500000,
    [3] = 1000000,
}
cooperationTuningLevelCosts = {
    [1] = 100000,
    [2] = 250000,
    [3] = 500000,
}
maxCoopTuningLevel = #cooperationTuningLevelCosts
maxCoopLevel = #cooperationTuningLevelCosts
cooperationCreateCosts = 150000 / 100
companyInterestPerc = 1
coopPaydayTimer = (1000 * 60) * 60
coopType = {
    [1] = "Gang",
    [2] = "Firma"
}
coopAllowedDepotIllegal = {
    [1] = true,
    [2] = false
}