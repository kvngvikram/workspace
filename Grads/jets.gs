'c'
'open data_2016.ctl'
'set lat -90 90'
'set lev 200'
'set t 1'
'set lon 180'
'd ave(uprs,lon=0,lon=360)'
'draw title Zonal_averaged_200hPa_zonal_wind_in_Jan2016'
'draw xlab latitude'
'draw ylab windspeed_m/s'
'gxprint jets.png'
