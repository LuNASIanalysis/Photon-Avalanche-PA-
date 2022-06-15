# Photon-Avalanche (PA)
This is the software for the automatized analysis and presentation of thedata from the power dependence and rise/decay luminescence dynamics measurements.

Photon avalanche (PA) is the special type of the upconversion observed in crystals, glasses or fibres doped with lanthanide ions. In PA the system is pumped with the laser line well fitted into the excited state absorption (ESA) of the optically active ions, which is non-resonant with any ground state absorption thereof simultaneously. This phenomenon is extremely sensitive to the power density of the exitation light - when this power exceeds some threshold value, one can observe large increase of the luminescence intenisity (2-3 orders of magnitude) in response to minute changes of the excitation power. Therefore, this effect is highly nonlinear, the slope of the power dependence characteristic can be as high as 20-40. Moreover, another characteristic feature of PA is slowing down of the rise time of the luminescence intensity for excitation powers close to the threshold value. To find out more about this phenomenon please follow our papers: https://www.nature.com/articles/s41586-020-03092-9 , https://pubs.rsc.org/en/content/articlelanding/2019/nh/c9nh00089e , https://www.sciencedirect.com/science/article/pii/S2590147821000310 , ...
Here you can find Matlab software developed by us to perform automatized analysis of our experimental data. The experimental data contains the two types of results:
- the power dependence between the excitation power (or power density) and resulting luminescence intensity of the avalanching system
- the measurements of the dynamics of the rise and decay of luminescence intensity taken for the set of various excitation powers

Based on the experimental data files (please find that the file names format, containing experimental parameters, and the structure of the data in files have to be the same as in provided exemplary data files for the algorithm to work properly) this software automatically anlyses the data, finds the most important parameters of the PA phenomenon and plots them on the charts.


