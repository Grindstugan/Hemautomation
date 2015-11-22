--  Skrivit av Ispep
--  2015-11-22 
--  Automatiserat.se 
--
--  F�ljande program sl�cker en enhet och loggar till loggserver
--  om ljuset understiger eller �verstiger ett visst v�rde. 

local Powerdevice = 1 -- ID p� lampan som ska t�ndas/sl�ckas. 
local device = 2      -- Enheten som m�ter ljus.
local lowLight = 10   -- Minsta gr�ns, under sl�cks lampan.
local highLight = 20   -- H�gsta gr�ns, �ver s� sl�cks lampan. 
local ICurrent = tonumber ((luup.variable_get("urn:micasaverde-com:serviceId:LightSensor1","CurrentLevel",device))) -- H�mtar ljusniv�n och sparar detta som ett v�rde.
local Ipadress = '192.168.1.1:80' -- Ip adressen till loggserver.  saknar du loggserver s� kan du v�lja att s�tta "--" framf�r luup.inet.wget

if (ICurrent >= highLight) then
	luup.call_action("urn:upnp-org:serviceId:SwitchPower1","SetTarget",{ newTargetValue="0" },Powerdevice )
	  luup.inet.wget('http://'..Ipadress..'/?Vera/Enhet1/OFF/Ljuset/'..ICurrent..'')
else 
     luup.call_action("urn:upnp-org:serviceId:SwitchPower1","SetTarget",{ newTargetValue="1" },Powerdevice )
	 luup.inet.wget('http://'..Ipadress..'/?Vera/Enhet1/ON/Ljuset/'..ICurrent..'')

end