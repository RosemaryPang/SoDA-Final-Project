
# coding: utf-8

# # LISA Cluster Maps 

# In[1]:


get_ipython().magic(u'matplotlib inline')
import pysal as ps
import numpy as np
import os
import time
import datetime
import matplotlib.pyplot as plt
import cartopy.crs as ccrs
from pysal.contrib.viz import mapping as maps
from mpl_toolkits.basemap import Basemap


# In[13]:


shp_link = ps.examples.get_path('pitts_review_census1.shp')


# In[14]:


print 'Reading from ', shp_link


# In[16]:


TotPop = np.array(ps.open(shp_link.replace('.shp', '.dbf')).by_col('TotPop'))


# In[17]:


w = ps.queen_from_shapefile(shp_link)
lisa = ps.Moran_Local(TotPop, w, permutations=9999)


# In[7]:


maps.plot_lisa_cluster(shp_link, lisa, figsize=(9, 6))


# In[11]:


orig_crs = ccrs.PlateCarree()
projection = ccrs.LambertConformal()
p_thres = 0.1

shp = ps.open(shp_link)
polys = maps.map_poly_shp(shp)
polys = maps.base_lisa_cluster(polys, lisa, p_thres=p_thres)
polys.set_edgecolor('1')
polys.set_linewidth(0.2)
polys.set_transform(orig_crs)

f = plt.figure(figsize=(12, 8))

ax = plt.axes(projection=projection)
extent = [shp.bbox[0], shp.bbox[2], shp.bbox[1], shp.bbox[3]]
ax.set_extent(extent, crs=ccrs.PlateCarree())
ax.add_collection(polys)
ax.outline_patch.set_visible(False)

boxes, labels = maps.lisa_legend_components(lisa, p_thres=p_thres)
plt.legend(boxes, labels, loc='lower left', fancybox=True)

plt.title('LISA clusters | P-value = %.2f'%p_thres)

plt.show()


# In[10]:


orig_crs = ccrs.PlateCarree()
projection = ccrs.LambertConformal()
p_thresS = [0.1, 0.05, 0.01, 0.001]

f = plt.figure(figsize=(16, 10))

for i, p_thres in enumerate(p_thresS):
    shp = ps.open(shp_link)
    polys = maps.map_poly_shp(shp)
    polys = maps.base_lisa_cluster(polys, lisa, p_thres=p_thres)
    polys.set_edgecolor('1')
    polys.set_linewidth(0.2)
    polys.set_transform(orig_crs)

    ax = plt.subplot(2, 2, i+1, projection=projection)
    extent = [shp.bbox[0], shp.bbox[2], shp.bbox[1], shp.bbox[3]]
    ax.set_extent(extent, crs=ccrs.PlateCarree())
    ax.add_collection(polys)
    ax.outline_patch.set_visible(False)

    boxes, labels = maps.lisa_legend_components(lisa, p_thres=p_thres)
    plt.legend(boxes, labels, loc='lower left', frameon=False)
    ax.set_title('P-value = %.3f'%p_thres)

plt.show()


# In[18]:


orig_crs = ccrs.PlateCarree()
projection = ccrs.LambertConformal()
p_thres = 0.1

shp = ps.open(shp_link)
polys = maps.map_poly_shp(shp)
polys = maps.base_lisa_cluster(polys, lisa, p_thres=p_thres)
polys.set_edgecolor('1')
polys.set_linewidth(0.2)
polys.set_transform(orig_crs)

f = plt.figure(figsize=(12, 8))

ax = plt.axes(projection=projection)
extent = [shp.bbox[0], shp.bbox[2], shp.bbox[1], shp.bbox[3]]
ax.set_extent(extent, crs=ccrs.PlateCarree())
ax.add_collection(polys)
ax.outline_patch.set_visible(False)

boxes, labels = maps.lisa_legend_components(lisa, p_thres=p_thres)
plt.legend(boxes, labels, loc='lower left', fancybox=True)

plt.title('LISA Population Clusters | Pittsburgh, PA \nP-value = %.2f'%p_thres)


plt.savefig('/Users/localadmin/Desktop/lisaClusters_Pop_Pitts.png', transparent = False, bbox_inches = 'tight', dpi = 1000)
plt.show()


# In[20]:


shp_link = ps.examples.get_path('vegas_review_census.shp')
print 'Reading from ', shp_link
Pct_BPL = np.array(ps.open(shp_link.replace('.shp', '.dbf')).by_col('Pct_BPL'))
w = ps.queen_from_shapefile(shp_link)
lisa = ps.Moran_Local(Pct_BPL, w, permutations=9999)


orig_crs = ccrs.PlateCarree()
projection = ccrs.LambertConformal()
p_thres = 0.1

shp = ps.open(shp_link)
polys = maps.map_poly_shp(shp)
polys = maps.base_lisa_cluster(polys, lisa, p_thres=p_thres)
polys.set_edgecolor('1')
polys.set_linewidth(0.2)
polys.set_transform(orig_crs)

f = plt.figure(figsize=(12, 8))

ax = plt.axes(projection=projection)
extent = [shp.bbox[0], shp.bbox[2], shp.bbox[1], shp.bbox[3]]
ax.set_extent(extent, crs=ccrs.PlateCarree())
ax.add_collection(polys)
ax.outline_patch.set_visible(False)

boxes, labels = maps.lisa_legend_components(lisa, p_thres=p_thres)
plt.legend(boxes, labels, loc='lower left', fancybox=True)

plt.title('LISA Poverty Clusters | Las Vegas, NV \nP-value = %.2f'%p_thres)


plt.savefig('/Users/localadmin/Desktop/lisaClusters_Pov_Vegas.png', transparent = False, bbox_inches = 'tight', dpi = 1000)

plt.show()


# In[19]:


shp_link = ps.examples.get_path('madison_review_census1.shp')
print 'Reading from ', shp_link
TotPop = np.array(ps.open(shp_link.replace('.shp', '.dbf')).by_col('TotPop'))
w = ps.queen_from_shapefile(shp_link)
lisa = ps.Moran_Local(TotPop, w, permutations=9999)


orig_crs = ccrs.PlateCarree()
projection = ccrs.LambertConformal()
p_thres = 0.1

shp = ps.open(shp_link)
polys = maps.map_poly_shp(shp)
polys = maps.base_lisa_cluster(polys, lisa, p_thres=p_thres)
polys.set_edgecolor('1')
polys.set_linewidth(0.2)
polys.set_transform(orig_crs)

f = plt.figure(figsize=(12, 8))

ax = plt.axes(projection=projection)
extent = [shp.bbox[0], shp.bbox[2], shp.bbox[1], shp.bbox[3]]
ax.set_extent(extent, crs=ccrs.PlateCarree())
ax.add_collection(polys)
ax.outline_patch.set_visible(False)

boxes, labels = maps.lisa_legend_components(lisa, p_thres=p_thres)
plt.legend(boxes, labels, loc='lower left', fancybox=True)

plt.title('LISA Population Clusters | Madison, WI \nP-value = %.2f'%p_thres)

plt.savefig('/Users/localadmin/Desktop/lisaClusters_Pop_Madison.png', transparent = False, bbox_inches = 'tight', dpi = 1000)

plt.show()


# In[12]:


m = Basemap(projection='lcc', resolution='h', 
            lat_0=37.5, lon_0=-119,
            width=1E6, height=1.2E6)
m.shadedrelief()


# In[13]:


import pandas as pd


# In[14]:


m = Basemap(projection='lcc', resolution='h', 
            lat_0=37.5, lon_0=-119,
            width=1E6, height=1.2E6)
m.shadedrelief()

