

## Prepare list of available data sets

DIRAC command

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
This command takes usually a long time as it has to query thousands of files


```
./getFiles_and_checkifLocal.sh check Prod5_LaPalma_AdvancedBaseline_NSB1x
```


