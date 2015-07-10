# pebuilder
Various scripts to build a custom Windows PE

## Requirements
Windows Assessment and Deployment Kit (ADK) for Windows 8.1. You can get it [here](https://www.microsoft.com/en-us/download/details.aspx?id=39982). It should work with previous versions (known as AIK) but I haven't tested.

## Usage
* Clone the repo and edit the enviroment variables in the file **pebuilder.cmd** to fit your needs.
* The file **winpeshl.ini** (under files\Windows\System32) gets executed on WinPE start. The example provided starts the network, sets locale and keyboard, makes some tweaks in registry, and finally starts bbLean, a Blackbox clone which comes handy to replace Explorer. Make sure to edit it if your setup if different than mine (for example, if you use other locale, or if you don't use bbLean) or WinPE will probably crash on boot.
* Run **pebuilder.cmd** from the special shell provided with the ADK.
