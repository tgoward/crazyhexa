# CrazyHexa

Ici vous trouverez toutes les informations nécessaires à la modification d'un Crazyflie 2.0 en hexarotor.

## Prérequis

### Installation de ROS et pilotage du drone avec un système de capture de mouvement


Il faut d'abord autoriser l'ordinateur d'installer les packages de ROS

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

si erreur " sh: 1: lbs_release: not found " 

ouvrir un nouveau terminal et taper

```
sudo apt-get install lsb-core
```

Configuration de la clé du serveur pour vérifier les fichiers téléchargés

```
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -
```

Téléchargement de ROS

```
sudo apt-get update
sudo apt-get install ros-kinectic-desktop-full
```

Cela dure quelques minutes (voir une heure pour un Raspberry 3)

Initialisation des dependances de ROS

```
sudo rosdep init
rosdep update
```

Paramètrage du bash

```
echo "source /opt/ros/kinetic/setup.bash" >> ~/.bashrc
source ~/.bashrc
```

Installation de rosinstall

```
sudo apt-get install python-rosinstall
```

ROS est installé! Il faut maintenant créer un espace de travail.

```
mkdir -p ~/catkin_ws/src
cd ~/catkin_ws/src
catkin_init_workspace
```

Cloner les fichiers sources disponible sur les GitHub suivants :

```
cd ~/catkin_ws/src/
git clone https://github.com/whoenig/crazyflie_ros.git
git clone https://github.com/ros-drivers/vrpn_client_ros.git
```

Initialisation des packages crazyflie_ros

```
cd ./crazyflie_ros/
git submodule init
git submodule update
```

Installation des dépendances des nouveaux packages

```
rosdep install --from-path src --ignore-src
```

Compiler les packages

```
cd ~/catkin_ws/
catkin_make
source devel/setup.bash
```

Le catkin_make rends les packages dans le dossier src exécutables. Il faut donc le faire à chaque modification des fichiers .launch ou .py et les recharger en mémoire

Pour que le programme puisse utiliser le crazyradio sans permission root (superuser) il faut les modifier

```
sudo groupadd plugdev
sudo usermod -a -G plugdev username
```

Remplacer username par votre nom d'utilisateur

```
cd /etc/udev/rules.d
sudo gedit 99-crazyradio.rules
```

Dans l'éditeur de texte, copier et sauvegarder

```
SUBSYSTEM=="usb", ATTRS{idVendor}=="1915", ATTRS{idProduct}=="7777", MODE="0664", GROUP="plugdev"
```

Pour utiliser le Crazyflie directement par USB :

```
sudo gedit 99-crazyflie.rules
```

Dans l'éditeur de texte, copier et sauvegarder

```
SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="5740", MODE="0664", GROUP="plugdev"
```

Redemarrer pour que l'ordinateur prenne en compte ces modifications.

Attention !! Le python intégré doit être la version 2.7. Sinon il faut installer Conda : https://conda.io/docs/user-guide/install/linux.html
Une fois installé, Taper

```
Conda ceate -n myenv python=2.7
source activate myenv
```

Il faut recompiler dans ce nouvel environnement le catkin_ws
A chaque fois que l'on ouver in nouveau terminal il faut activer cet environnement

```
source activate myenv
```

Il faut modifier quelques fichiers launch avec les paramètres de l'installation.
En voici les principales

Dans vrpn_client_ros/launch/sample.launch

Remplacer

```
server:$(arg server)
```

par

```
server:adresse IP du serveur de capture de mouvement
```

Dans crazyflie_ros/crazyflie_demo/lefichierlaunchutilisé.launch

Remplacer

```
<arg name="uri" default="radio://0/90/2M"/>
<arg name="frame" default="vicon/crazyflie/crazyflie"/>
```

Par

```
<arg name="uri" default="radio:les_paramètres_radio_du_crazyflie"/>
<arg name="frame" default="/le_nom_du_crazyflie_dans_le_dispositif_de_capture"/>
```

Et remplacer

```
<include file="$(find vicon_bridge)/launch/vicon.launch"/>
```
par
<include file="$(find vrpn_client_ros)/launch/sample.launch"/>

Le paramètrage est terminé.
Il faut rafraichir le répertoire

```
cd ~/catkin_ws/
source devel/setup.bash
```

Pour récupérer les données du système de capture, copier le script python ROS/ros_data_extraction.py dans le dossier crazyflie_ros/crazyflie_demo/scripts/

#### Utilisation du système

Brancher une manette de Xbox 360 ou équivalent

Le hover_vicon.launch permet de piloter le drone à une position (x,y,z) donnée par l'utilisateur

```
roslaunch crazyflie_demo hover_vicon.launch x:=0 y:=0 z:=2
```

lance l'algorithme, appuyer sur X pour commencer, une fois stabilisé, appuyer sur A pour le faire atterrir puis Ctrl+C pour finir.

Le waypoint_vicon.launch permet de faire un parcours prédéfini dans le fichier scripts/demo1.py

```
roslauch crazyflie_demo waypoint_vicon.launch
```

lance l'algorithme, appuyer sur X pour commencer, une fois le parcours effectué, appuyer sur A pour le faire atterrir puis Ctrl+C pour finir.

Pour enregistrer les données du système de capture, il faut lancer le script ros_data_extraction.py dans un autre terminal une fois le .launch lancé

```
rosrun crazyflie_demo ros_data_extraction.py aborescence/où/le/fichier/est/saugardé.txt
```

### Installation du cfclient 

Il faut tout d'abord télécharger et installer les librairies du crazyflie cflib.
```
git clone https://github.com/bitcraze/crazyflie-lib-python
pip install ~/crazyflie-lib-python/
```
Nota: Il faut que pip soit installé, si ce n'est pas le cas taper
```
sudo apt install python-pip
```
Il faut aussi installer Python 3 et les librairies QT 5 pour que le client fonctionne correctement.
```
sudo apt-get install python3 python3-pip python3-pyqt5 python3-pyqt5.qtsvg
```
Le téléchargement est l'installation du client peut maintenant être réalisée.
```
git clone https://github.com/bitcraze/crazyflie-clients-python.git
cd ~/crazyflie-clients-python/
pip3 install -e ./
```
Pour ouvrir le client, il suffit de taper
```
cfclient
```
dans un terminal.

### Téléchargement et initialisation du firmware origianl du drone
Il faut d'abord télécharcher et installer les toolchains pour les processeurs ARM
```
sudo add-apt-repository ppa:team-gcc-arm-embedded/ppa
sudo apt-get update
sudo apt-get install libnewlib-arm-none-eabi
```
Maintenant le clonage du firmware peut être réalisé
```
git clone --recursive https://github.com/bitcraze/crazyflie-firmware.git
```
L'option --recursive est utilisée car le repertoire utilise des sousmodules git.

Pour compiler le firmware pour ensuite le flasher sur le drone il suffit de taper
```
make
```
dans le répertoire du firmware.
Ensuite taper
```
make cload
```
pour flasher le firmware sur le drone.
Pour que le drone puisse être flashé il faut le mettre en mode bootload. Il faut d'abord l'éteindre puis appuyer et maintenir le bouton ON-OFF jusqu'à ce que la LED bleue clignote. Le drone redémarre automatiquement en mode classique une fois le flash fini.


## Hexarotor Classique

### Prérequis

Installation du cfclient et de ROS ci-dessus.
Le drone modifié avec les pièces imprimées disponible dans le dossier crazyhexa/crazyflie_plan/STL.


### Installation

Supprimer le dossier crazyflie-firmware/src et le remplacer par crazyhexa/crazyflie_plan/firmware_hexa_coaxial/src .
Recompiler le firmware
```
cd ~/crazyflie-firmware
make clean
make
make cload
```
Le nouveau firmware est installé.


### Vol avec le client cfclient
Brancher une manette
Lancer le client en tapant,
```
cfclient
```
dans un terminal.
Allumer le drone et appuyer sur le bouton scan. Le client va trouver automatiquement le drone. Lancer la connection en appuyant sur Connect.
Une fois la connection établie, utiliser la manette préalablement branchée pour piloter le drone.


### Vol avec système de capture de mouvement
Pour que le drone soit stable, il faut modifier les gains de la commande.

Ouvrir le fichier ~/catkin_ws/src/crazyflie_ros/crazyflie_controller/config/crazyflie2.yaml
et remplacer le contenu par celui du fichier ~/crazyhexa/ROS/crazyhexaflat.txt

Brancher la manette, allumer le drone et le déposer dans le systeme de capture.
Lancer le programme en suivant les instructions décrite ci-dessus dans la partie "Utilisation du système"

## Hexarotor Incliné

### Prérequis

Instalation du cfclient et de ROS.
Pièces du dossier crazyhexa/hexarotor_incline/STL imprimée et montées sur le drone.

### Installation

* N.B.: le drone est stable avec le client cfclient mais pas avec ROS et le système de capture (il faut travailler le tuning des gains de commande)

Pour utilisé l'hexarotor incliné, il faut modifier le firmware du drone en prenant le dossier ~/crazyhexa/hexarotor_incline/crazyflie-firmware-WIP/src/ dans le même dossier que précedement

Le pilotage avec le client cfclient et ROS s'effectue de la même façon que pour le classique

## Analyse des résultats
Le script d'enregistrement des données met dans un fichier .txt les éléments suivants:
Le temps t, position du drone en X,position du drone en Y,position du drone en Z, objectif en X, objectif en Y,objectif en Z, inclinaison autour de X, inclinaison autour de Y, inclinaison autour de Z.
Dans le dossier /home/thomas/crazyhexa/matlab/analyse_et_synthese_trajectoire/ il y a le ficher extractionetcomparaison.m qui lit le fichier .txt afin de l'exploiter et re créé la trajectoire du drone.
Pour lire le fichier dans votre code, 
```
fileID = fopen('aborescence/où/le/fichier/est/saugardé.txt','r');
%---------------------t x  y  z  Wx Wy Wz r  p  yaw
C = textscan(fileID,'%f %f %f %f %f %f %f %f %f %f\n');
```


## Ressources

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds


## Auteur

* **Thomas Goward**

## Remerciements

* Bitcraze.io pour le firmware initial
* Evandro Bernardes pour l'initiation à ROS
* Franck RUFFIER et Jean-Baptiste MOURET pour m'avoir donner l'opportunité de travailler sur ce projet
