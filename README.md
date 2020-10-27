# Introduction

Some simple script to prepare and steer file lists from CTA prodx production and compare it with locally (DESY)
available files

# Usage

## Prepare list of available data sets

uses DIRAC command

e.g.

```
cta-prod-show-dataset | grep Prod5_Paranal_AdvancedBaseline_NSB5x  | grep DL0 >| Prod5_Paranal_AdvancedBaseline_NSB5x.list
```

This should result in a list of availabe data sets, e.g.,

```
Prod5_Paranal_AdvancedBaseline_NSB5x_electron_North_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_electron_South_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_gamma-diffuse_North_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_gamma-diffuse_South_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_gamma_North_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_gamma_South_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_proton_North_20deg_DL0
Prod5_Paranal_AdvancedBaseline_NSB5x_proton_South_20deg_DL0
```

## Prepare list of data files

Prepare lists of data files into the directory of the corresponding dataset.

e.g. into Prod5_LaPalma_AdvancedBaseline_NSB1x:

```
./getFiles_and_checkifLocal.sh lists Prod5_LaPalma_AdvancedBaseline_NSB1x
```

This queries the CTA production DB and puts file lists into Prod5_LaPalma_AdvancedBaseline_NSB1x/<particle type>

**Note the difference in naming: gamma-diffuse is renamed for Eventdisplay into gamma_cone**

## Check which files are on DESY dCache, lustre, GRID

The following commands queries both dCache and lustre for files.
This command takes usually a long time as it has to query thousands of files.

```
./getFiles_and_checkifLocal.sh check Prod5_LaPalma_AdvancedBaseline_NSB1x
```

This will prepare the following files for each particle type, and azimuth direction:

```
Prod5_LaPalma_AdvancedBaseline_NSB1x_electron_North_20deg_DL0.dCache.list
Prod5_LaPalma_AdvancedBaseline_NSB1x_electron_North_20deg_DL0.GRID.list
Prod5_LaPalma_AdvancedBaseline_NSB1x_electron_North_20deg_DL0.list
Prod5_LaPalma_AdvancedBaseline_NSB1x_electron_North_20deg_DL0.local.list
```

## Downloading files

uses DIRAC command

```
./getRawFilesFromGRID-DIRAC.sh Prod5_LaPalma_AdvancedBaseline_NSB1x/Prod5_LaPalma_AdvancedBaseline_NSB1x_gamma-diffuse_North_20deg_DL0.GRID.list Prod5_LaPalma_AdvancedBaseline_NSB1x/gamma_cone 100
```

Start downloading in parallel for all particle types (needs adjustment for data set and data level):

```
./download_paranal.sh
```

(this obviously takes quite a while)


## Copy file lists into productions directories

Rename list to be readable by Eventdisplay scripts

e.g.,
```
./copy_file_lists.sh Prod5_LaPalma_AdvancedBaseline_NSB1x $CTA_USER_DATA_DIR/analysis/AnalysisData/FileList_prod5/prod5-LaPalma-20deg/
```
Should copy all *local* lists from ./Prod5_LaPalma_AdvancedBaseline_NSB1x/ and rename them to:
```
electron_180deg.list
electron.list
gamma_cone_0deg.list
gamma_cone_180deg.list
gamma_cone.list
gamma_onSource_0deg.list
gamma_onSource_180deg.list
gamma_onSource.list
proton_0deg.list
proton_180deg.list
proton.list
```

# DL1 files 

## Download DL1 tar packages from GRID

- file lists must be prepared for data sets for DL1 (e.g., Prod5_LaPalma_AdvancedBaseline_NSB1x_DL1)
- download_parallel.sh must be modified to DL1

## Copy DL1 root files to analysis directory

### Downloaded tar files

Use script *copy_file_lists.sh*, which requires adjustments at the top:

- target directory for analysis
- list of array types
- local DL1 data directory

```
./copy_DL1files.sh copy
```

Note: will take a while (many files)

### Files from dCache

Use script *copy_DL1files_from_dCache.sh*, which requires adjustments at the top (see previous entry for *copy_file_lists.sh*).

```
./copy_DL1files_from_dCache.sh
```


