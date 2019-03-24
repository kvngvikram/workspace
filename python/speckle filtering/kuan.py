# Kuan filter 
# ref : https://www.pcigeomatics.com/geomatica-help/concepts/orthoengine_c/Chapter_824.html

kernel_size =  5        # n in the n*n kernel
no_of_looks = 1 

kernel_size = kernel_size + ( 1 - kernel_size % 2 )     # kernel size should be odd 

print('\n\tkernel size is ',kernel_size)
offset = int(( kernel_size - 1)/ 2) 

import numpy as np
import cv2 
import matplotlib.pyplot as plt

ni = cv2.imread('noise_image.png',0)
ni = np.asarray(ni,dtype=float)

oi = cv2.imread('original.png',0)
oi = np.asarray(oi,dtype=float)

ni = np.pad(ni,((offset,offset),(offset,offset)),'constant',constant_values=0.0)
oi = np.pad(oi,((offset,offset),(offset,offset)),'constant',constant_values=0.0)

avg = ni * 0 
var = ni * 0

dummyshape = [ 7 , 8 ]
for i in np.asarray( range( ni.shape[0] - 2 * offset ) ) + offset :
    for j in np.asarray( range( ni.shape[1] - 2 * offset ) ) + offset :
        
        # calculating the local average of kernal
        avg[i][j] = ni[ i-offset : i+offset+1 , j-offset : j+offset+1 ].mean()
        var[i][j] = ni[ i-offset : i+offset+1 , j-offset : j+offset+1 ].var()

Cu = (1.0/no_of_looks)**0.5
S = var**0.5
Im = avg 
Ic = ni

Ci = S/Im
Ci = np.nan_to_num(Ci)

#W = ( 1 - Cu**2 / Ci**2 )/( 1 + Cu**2 )
#W = ( 1 - Cu / Ci )/( 1 + Cu )
W = ( 1 - Cu**0.5 / Ci**0.5 )/( 1 + Cu**0.5 )
W = np.nan_to_num(W)

R = Ic*W + Im*(1-W)

dsi = R 


plt.figure(1)
plt.imshow(ni,cmap='gray')
plt.title('Noisy image')
plt.figure(2)
plt.imshow(dsi,cmap='gray')
plt.title('Filtered image | kernel size: '+str(kernel_size))

plt.figure(3)
pixel_values = np.linspace(0,255,256)

plt.subplot(321)
oi_hist , temp = np.histogram(oi,bins=256,range=(0,255))
oi_hist = oi_hist.astype(float)
plt.plot(pixel_values,oi_hist)
plt.title('Original image wihtout noise')

plt.subplot(323)
ni_hist , temp = np.histogram(ni,bins=256,range=(0,255))
ni_hist = ni_hist.astype(float)
plt.plot(pixel_values,ni_hist)
plt.title('Noisy image')

plt.subplot(325)
dsi_hist , temp = np.histogram(dsi,bins=256,range=(0,255))
dsi_hist = dsi_hist.astype(float)
plt.plot(pixel_values,dsi_hist)
plt.title('filtered image histogram')

max_noise = 7

plt.subplot(222)
plt.axis([0,255,0,max_noise])
plt.plot(pixel_values,(ni_hist/oi_hist))
plt.title('noise')

plt.subplot(224)
plt.axis([0,255,0,max_noise])
plt.plot(pixel_values,(dsi_hist/oi_hist))
plt.title('noise after filteration')

plt.show()