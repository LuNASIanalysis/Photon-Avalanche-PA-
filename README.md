# Photon Avalanche (PA)
This is the software for the automatized analysis and presentation of thedata from the power dependence and rise/decay luminescence dynamics measurements.

Photon avalanche (PA) is the special type of the upconversion observed in crystals, glasses or fibres doped with lanthanide ions. In PA the system is pumped with the laser line well fitted into the excited state absorption (ESA) of the optically active ions, which is non-resonant with any ground state absorption thereof simultaneously. This phenomenon is extremely sensitive to the power density of the exitation light - when this power exceeds some threshold value, one can observe large increase of the luminescence intenisity (2-3 orders of magnitude) in response to minute changes of the excitation power. Therefore, this effect is highly nonlinear, the slope of the power dependence characteristic can be as high as 20-40. Moreover, another characteristic feature of PA is slowing down of the rise time of the luminescence intensity for excitation powers close to the threshold value. To find out more about this phenomenon please follow our papers: https://www.nature.com/articles/s41586-020-03092-9 , https://pubs.rsc.org/en/content/articlelanding/2019/nh/c9nh00089e , https://www.sciencedirect.com/science/article/pii/S2590147821000310 , and much more on our web page: https://lunasi.intibs.pl/.

![obraz](https://user-images.githubusercontent.com/100279880/173800759-86620d5f-f667-43b7-9237-0f1a9a564f19.png)


Here you can find Matlab software developed by us to perform automatized analysis of our experimental data. The experimental data contains the two types of results:
- the power dependence between the excitation power (or power density) and resulting luminescence intensity of the avalanching system
- the measurements of the dynamics of the rise and decay of luminescence intensity taken for the set of various excitation powers

Based on the experimental data files (please find that the file names format, containing experimental parameters, and the structure of the data in files have to be the same as in provided exemplary data files for the algorithm to work properly) this software automatically anlyses the data, finds the most important parameters of the PA phenomenon and plots them on the charts.

The expemplary set of test data is avaliable in the Test_experimental_data branch of this repository https://github.com/LuNASIanalysis/Photon-Avalanche-PA-/tree/Test-experimental-data

INSTRUCTION OF USE:

- run the main_PowerDep.m file

- select the folder containing the set of experimental data (from single experiment). It should contains 1 file with the power dependnce data and not limitted number of the coresponding files with the luminescence dynamics measurements (collected with TCSPC method). Importantly, the format of the names of the files should be not changed, as the algotithm automatically uses the experiment parameters included in the name of the files. Change in the format would result in algorithm errors.

- algorithm is performing neccesary calculations, you are informed about the progres of the work
as a result you obtain 2 figures - one presenting most of the results (power dependence curve, the fitting, residuals, slope, Dav parameter, tx% rise time - all of them plotted as a function of the excitation power density; luminescence dynamics curves for various power densities; report with the main parameters values) and the second comparing the raw data with the smoothed fitted curve, as well as presenting the location of determined PA threshold value.

- the work is done
