---
title: Unity
excerpt: Guide for integrating Purchasely SDK inside your Unity application
deprecated: false
hidden: false
metadata:
  title: ''
  description: ''
  robots: index
next:
  description: ''
---
# Installation

<UnitySdkInstallation />

# Troubleshoot

If you have difficulties building your Unity project with Purchasely Package, please make sure to follow all those steps and that [External Dependency Manager](#external-dependencies-manager) is installed in your project

## Resolution of Android dependencies

In *Assets -> External Dependency Manager -> Android Resolver > Settings* make sure that **Resolution On Build** and/or Auto Resolution are checked as well as **patch gradleTemplate.properties**

<Image align="center" className="border" width="500px" border={true} src="https://files.readme.io/6c3e10f-SCR-20240112-mnni.png" />

<Image align="center" className="border" border={true} src="https://files.readme.io/943268d-SCR-20240112-mnvn.png" />

## Add custom gradle files

To allow dependency manager to work properly, it may be required to add custom gradle files to your project.\
You can do that in a few clicks\
*File -> Build Settings -> Android -> Player Settings -> Publishing Settings*

You need to check

* Custom Gradle Properties Template

If it is still not working, we suggest to check also the following

* Custom Main Gradle Template
* Custom Base Gradle Template

<Image align="center" className="border" border={true} src="https://files.readme.io/db54402-SCR-20240112-mpkx.png" />

## Remove included AAR or JAR

If you have a duplicate class issue, it may be due to AAR or JAR files included directly in your Project.\
Unity may add them directly, you can look in *Project window* and *Assets -> Plugin -> Android*\
If you have some aar files, mainly the ones starting with androidx, included there, you should remove them as Purchasely already integrate them and they are the ones causing this conflict error

## Clean Build

After including or updating Purchasely Unity Package, you should do a **Clean Build** in *File -> Build Settings -> Android* to make sure that the latest Purchasely android dependencies are fetched by your project
