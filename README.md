# Alonzo System Setup Wizard

  * This is a shell script application specifically for **Linux ubuntu OS**. 
  * It is capable of setting up robotic software such as **MOOS** & **ROS** automatically in one's device without asking any user input. (except sudo passwd)
    
<div align=center>

<img width="550" height="450" src="https://github.com/alonzo3569/system_setup/blob/master/docs/system_setup_finish.png"/><br></br>

</div>

## Features
  * __Check device status :__ 
    * Before installation, setup wizard will check if any MOOS/ROS is installed in this device.
  * __Install dependencies :__
    * Setup wizard will also download every dependencies for MOOS or ROS.
  * __Download MOOS/ROS :__   
    Below are installation options for user to select  
    * moos-ivp
    * moos-ivp-aquaticus
    * moos-ivp-UAL
    * your own moos tree
    * ROS Melodic
  * __Add path to ~/.bashrc :__
    * Automatically write moos/ros path to .bashrc
  * __Build MOOS/ROS :__
    * Remove apps that can't be built.(moos-ivp-aquaticus)
    * Build MOOS/ROS
  * __Check installation :__
    * Check env path 
    * Check file existence
    * Check build process
  * __Logfile :__
    * For debug purposes

## Install
1. `git clone http://github.com/alonzo3569/system_setup`
2. `cd system_setup`
3. Run `./interface.sh`
4. If permission denied, run `chmod u+x`

## Demo
* __After executing :__ 

<div align=center>

<img width="550" height="450" src="https://github.com/alonzo3569/system_setup/blob/master/docs/passwd.JPG"/><br></br>

</div>

* __Main selection page :__ 

<div align=center>

<img width="550" height="450" src="https://github.com/alonzo3569/system_setup/blob/master/docs/main_option.JPG"/><br></br>

</div>

* __During installation :__ 

<div align=center>

<img width="550" height="450" src="https://github.com/alonzo3569/system_setup/blob/master/docs/insatlling.JPG"/><br></br>

</div>

* __After installation :__ 

<div align=center>

<img width="550" height="450" src="https://github.com/alonzo3569/system_setup/blob/master/docs/system_setup_finish.png"/><br></br>

</div>
