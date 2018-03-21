## What is in this repository ##

**HMUtilities** source code in *Swift*, that can be made into a *framework* by `swift build` (*macOS* and *Linux* only), or through *Xcode*. Using the latter allows additionally to build for *iOS*, *tvOS* or *watchOS*.  

In addition, if using this as a *dependency* with Swift Package Manager, the suitable architecture is handled by Xcode.

## Framework Usage ##

For *iOS*, it's recommended to build the *universal* framework - thus enabling running on a simulator as well.  
There's an `AppStoreCompatible.sh` script for thinning the framework before submission to iTC.  

For *macOS* and *Linux*, executing `swift build` and using the product is recommended (use the `--show-bin-path` option to get the output path).  

For *other Apple* platforms, the *universal* framework can be made with `lipo` from *Xcode*'s simulator and device products. When creating a *universal* one, the *module maps* need to be copied as well.  
