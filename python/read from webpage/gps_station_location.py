# This code is to give the location (lat lon) of GPS receiver station from a webpage

import requests

webaddress = 'http://geodesy.unr.edu/NGLStationPages/stations/WARA.sta'

page = requests.get(webaddress)
print('connection successful' if page.status_code == 200 else 'connection failed')

a = str(page.text)
print(type(a))

lat_index = a.find('Latitude')       # Index for latitude
lon_index = a.find('Longitude')      # index for longitude


lat_string = a[lat_index+9:lat_index+30]
lon_string = a[lon_index+10:lon_index+40]

print(lat_string)

end_string = '</h4>'

lat_string = lat_string[:lat_string.find(end_string)]
print(lat_string)

lon_string = lon_string[:lon_string.find(end_string)]
print(lon_string)

print(float(lat_string))

'''
try :
    station = raw_input('give the sation name : ')
except :
    station = input('give the station name with exception : ')

print(station)
#'''
