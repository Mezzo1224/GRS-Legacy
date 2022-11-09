
----------GUI To DGS Converted----------
if not getElementData(root,"__DGSDef") then
	setElementData(root,"__DGSDef",true)
	addEvent("onDgsEditAccepted-C",true)
	addEvent("onDgsTextChange-C",true)
	addEvent("onDgsComboBoxSelect-C",true)
	addEvent("onDgsTabSelect-C",true)
	function fncTrans(...)
		triggerEvent(eventName.."-C",source,source,...)
	end
	addEventHandler("onDgsEditAccepted",root,fncTrans)
	addEventHandler("onDgsTextChange",root,fncTrans)
	addEventHandler("onDgsComboBoxSelect",root,fncTrans)
	addEventHandler("onDgsTabSelect",root,fncTrans)
	loadstring(exports.dgs:dgsImportFunction())()
end
----------GUI To DGS Converted----------

skinname = { [7]="Mann (Ghetto)",
[9]="Aeltere Frau (Chic)",
[10]="Aeltere Frau (Laendlich)",
[11]="Frau (Casino)",
[12]="Frau (Chic)",
[13]="Frau (Ghetto)",
[14]="Mann (Hawaihemd)",
[15]="Pakistaner",
[17]="Geschaeftsmann",
[18]="Mann (Strand)",
[19]="Mann (Proll)",
[20]="Mann (Freizeit)",
[21]="Mann (Ghetto)",
[22]="Mann (Oranger Hoody)",
[23]="Juengerer Mann",
[24]="Bodyguard",
[25]="Bodyguard",
[26]="Camper",
[28]="Dealer (Tank Top)",
[29]="Dealer (Hoody)",
[30]="Mexikaner (Sonnenbrille)",
[31]="Cowgirl (Alt)",
[32]="Alter Mann (Augenklappe)",
[33]="Gentleman",
[34]="Cowboy",
[35]="Angler",
[36]="Trucker (Mexikaner)",
[37]="Trucker",
[38]="Alte Golferin",
[39]="Alte Frau",
[40]="Frau (Chic)",
[43]="Mexikaner (Macho)",
[44]="Mexikaner",
[45]="Mann (Strand)",
[46]="Geschaeftsmann",
[47]="Latino",
[48]="Latino",
[53]="Alte Frau",
[54]="Indianerin",
[55]="Frau (Sonnenbrille)",
[56]="Junge Frau",
[57]="Alter Asiate",
[58]="Mann (Hemd)",
[59]="Mann (Hemd)",
[59]="Mann",
[63]="Nutte",
[64]="Nutte",
[66]="Foodballfan",
[67]="Mechaniker",
[69]="Frau",
[72]="Trucker",
[73]="Trucker",
[75]="Nutte",
[76]="Sekretaerin",
[82]="Elvis (Schwarz)",
[83]="Elvis (Weiss)",
[84]="Elvis (Blau)",
[85]="Nutte",
[88]="Alte Frau",
[89]="Alte Frau",
[90]="Frau (Nuttig)",
[91]="Frau (Kleid)",
[92]="Skaterin",
[94]="Golfer",
[95]="Alter Mann",
[96]="Sportler",
[97]="Mann (Strand)",
[101]="Mann",
[128]="Indianer",
[129]="Indianerin (Alt)",
[130]="Alte Frau",
[131]="Frau (Land)",
[133]="Trucker",
[136]="Jamaikaner",
[138]="Frau (Strand)",
[139]="Frau (Strand)",
[140]="Frau (Strand)",
[141]="Sekretaerin",
[142]="Jamaikaner",
[143]="Mann (Hellblau)",
[147]="Mann (Anzug)",
[148]="Frau (Anzug)",
[150]="Sekretaerin",
[151]="Frau (Dick)",
[152]="Nutte",
[154]="Mann (Strand)",
[156]="Old Reece",
[157]="Frau (Land)",
--[158]="Mann (Land)",
[159]="Alter Mann (Land)",
[160]="Alter Mann (Assi)",
[161]="Cowboy",
[162]="Cowboy (Eklig)",
[170]="Mann",
[171]="Croupie",
[172]="Weibl. Croupie",
[176]="Mann (Blau)",
[177]="Latino (Blau)",
[180]="Mann",
[182]="Mann (Assi)",
[183]="Mann (Drunkel)",
[184]="Latino",
[185]="Mann (Sonnenbrille)",
[187]="Newsreporter",
[190]="Latina",
[192]="Mechanikerin",
[193]="Frau",
[194]="Croupie (Weiblich)",
[195]="Frau (Ghetto)",
[196]="Alte Frau",
[197]="Alte Frau (Land)",
[198]="Cowgirl",
[199]="Frau (Dick)",
[200]="Landei",
[201]="Truckerin",
[202]="Trucker",
[206]="Glatzkopf",
[207]="Nutte",
[210]="Mann (Hemd)",
[211]="Frau",
[213]="Elvisverschnitt",
[216]="Frau (Kleid)",
[217]="Mann",
[218]="Alte Frau",
[219]="Sekretaerin",
[220]="Araber (Bunt)",
[221]="Araber (Weiss)",
[222]="Araber (Trist)",
[223]="Latino (Proll)",
[224]="Asiatin (Kimono)",
[225]="Asiatin",
[226]="Frau (Nuttig)",
[227]="Alter Asiate",
[228]="Asiate (Reich)",
[229]="Asiate",
[231]="Alte Frau",
[232]="Alte Frau",
[233]="Latina",
[234]="Mann (Sonnenbrille)",
[235]="Alter Mann",
[236]="Mann (Alt)",
[237]="Nutte",
[240]="Gescheaftsmann",
[241]="Afro",
[242]="Assi (Dick)",
[243]="Nutte",
[244]="Nutte",
[245]="Nutte",
[249]="Zuhaelter",
[250]="Mann",
[251]="Alte Frau (Strand)",
[256]="Nutte",
[257]="Nutte",
[258]="Mann (Kariert)",
[259]="Mann (Kariert)" }

skinsex = {[7]="male",
[9]="female",
[10]="female",
[11]="female",
[12]="female",
[13]="female",
[14]="male",
[15]="male",
[17]="male",
[18]="male",
[19]="male",
[20]="male",
[21]="male",
[22]="male",
[23]="male",
[24]="male",
[25]="male",
[26]="male",
[28]="male",
[29]="male",
[30]="male",
[31]="female",
[32]="male",
[33]="male",
[34]="male",
[35]="male",
[36]="male",
[37]="male",
[38]="female",
[39]="female",
[40]="female",
[43]="male",
[44]="male",
[45]="male",
[46]="male",
[47]="male",
[48]="male",
[53]="female",
[54]="female",
[55]="female",
[56]="female",
[57]="male",
[58]="male",
[59]="male",
[60]="male",
[63]="female",
[64]="female",
[66]="male",
[67]="male",
[69]="female",
[72]="male",
[73]="male",
[75]="female",
[76]="female",
[82]="male",
[83]="male",
[84]="male",
[85]="female",
[88]="female",
[89]="female",
[90]="female",
[91]="female",
[92]="female",
[94]="male",
[95]="male",
[96]="male",
[97]="male",
[101]="male",
[128]="male",
[129]="female",
[130]="female",
[131]="female",
[133]="male",
[136]="male",
[138]="female",
[139]="female",
[140]="female",
[141]="female",
[142]="male",
[143]="male",
[147]="male",
[148]="female",
[150]="female",
[151]="female",
[152]="female",
[154]="male",
[156]="male",
[157]="female",
--[158]="male",
[159]="male",
[160]="male",
[161]="male",
[162]="male",
[166]="male",
[170]="male",
[171]="male",
[172]="female",
[176]="male",
[177]="male",
[180]="male",
[182]="male",
[183]="male",
[184]="male",
[185]="male",
[187]="male",
[190]="female",
[192]="female",
[193]="female",
[194]="female",
[195]="female",
[196]="female",
[197]="female",
[198]="female",
[199]="female",
[200]="male",
[201]="female",
[202]="male",
[206]="female",
[207]="female",
[210]="male",
[211]="female",
[213]="male",
[216]="female",
[217]="male",
[218]="female",
[219]="female",
[220]="male",
[221]="male",
[222]="male",
[223]="male",
[224]="female",
[225]="female",
[226]="female",
[227]="male",
[228]="male",
[229]="male",
[231]="female",
[232]="female",
[233]="female",
[234]="male",
[235]="male",
[236]="male",
[237]="female",
[240]="male",
[241]="male",
[242]="male",
[243]="female",
[244]="female",
[245]="female",
[247]="male",
[248]="male",
[249]="male",
[250]="male",
[251]="female",
[254]="male",
[256]="female",
[257]="female",
[258]="male",
[259]="male" }

skinpreis ={[0]="500",
[7]="80",
[9]="1600", 
[10]="50", 
[11]="400",
[12]="1600",
[13]="90",
[14]="115",
[15]="120",
[17]="2100", 
[18]="45",
[19]="65",
[20]="110",
[21]="145",
[22]="121",
[23]="340",
[24]="320",
[25]="320",
[26]="220",
[28]="85",
[29]="83", 
[30]="230";
[31]="139",
[32]="132",
[33]="310",
[34]="270",
[35]="180",
[36]="190",
[37]="185",
[38]="180",
[39]="150",
[40]="1700",
[41]="320",
[43]="221",
[44]="175",
[45]="90",
[46]="410",
[47]="165",
[48]="130",
[51]="134",
[52]="147", 
[53]="160",
[54]="145",
[55]="1200",
[56]="280",
[57]="1600",
[58]="280",
[59]="590",
[60]="167",
[63]="178",
[64]="160",
[66]="300",
[67]="134",
[69]="280",
[72]="165",
[73]="233",
[75]="120",
[76]="900",
[77]="20",
[78]="15",
[79]="20",
[80]="78",
[81]="79",
[82]="1100",
[83]="800",
[84]="1200",
[85]="160",
[87]="154",
[88]="145",
[89]="175",
[90]="78",
[91]="1500",
[92]="79",
[93]="240",
[94]="120",
[95]="140",
[96]="89",
[97]="81",
[98]="400",
[99]="105",
[101]="156",
[128]="112",
[129]="198",
[130]="145",
[131]="250",
[132]="190",
[133]="90",
[134]="76",
[135]="20",
[136]="50",
[137]="30",
[138]="210",
[139]="180",
[140]="90",
[141]="560",
[142]="291",
[143]="270",
[147]="2400",
[148]="2300",
[150]="450",
[151]="139",
[152]="110",
[154]="89",
[156]="180",
[157]="120",
--[158]="50",
[159]="94",
[160]="35",
[161]="95",
[162]="20",
[168]="100",
[186]="132",
[170]="165",
[171]="650",
[172]="640",
[176]="150",
[177]="170",
[178]="89",
[179]="220",
[180]="190",
[182]="215",
[183]="145",
[184]="198",
[185]="410",
[187]="400",
[188]="187",
[189]="540",
[190]="250",
[191]="220",
[192]="233",
[193]="244",
[194]="710",
[195]="200",
[196]="130",
[197]="111",
[198]="123",
[199]="122",
[200]="50",
[201]="120",
[202]="176",
[206]="130",
[207]="110",
[209]="30",
[210]="256",
[211]="280",
[212]="4",
[213]="21",
[214]="350",
[215]="220",
[216]="1300",
[217]="150",
[218]="165",
[219]="1200",
[220]="800",
[221]="205",
[222]="209",
[223]="1400",
[224]="520",
[225]="150",
[226]="254",
[227]="1430",
[228]="1600",
[229]="420",
[231]="134",
[232]="160",
[233]="700",
[234]="410",
[235]="120",
[236]="132",
[237]="98",
[238]="99",
[240]="430",
[241]="165",
[242]="200",
[243]="92",
[244]="134",
[245]="94",
[246]="120",
[249]="530",
[250]="196",
[251]="75",
[252]="89",
[252]="67",
[253]="182",
[255]="230",
[256]="91",
[257]="90",
[258]="245",
[259]="220",
[261]="130",
[262]="365"}