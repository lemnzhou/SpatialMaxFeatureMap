# SpatialMaxFeatureMap

Torch implementation of the spatial max feature map layer described in Xiang Wu, Ran He, Zhenan Sun **A Lightened CNN for Deep Face Representation**
http://arxiv.org/abs/1511.02683 

Install:

```shell
$ luarocks install https://github.com/richardhahahaha/SpatialMaxFeatureMap/raw/master/spatialmaxfeaturemap-scm-1.rockspec
```

Examples:

```lua

require"nn" 
require"SpatialMaxFeatureMap"

m=nn.SpatialMaxFeatureMap(2)

X=torch.randn(3,4,3,2)
print(X[3], m(X)[3])

```
The output is:
```
(1,.,.) = 
 -0.6997 -1.9338
 -1.4314 -1.4688
 -0.0060  0.1059

(2,.,.) = 
  0.1561  0.7453
  1.5406 -1.4663
  0.1656  0.4614

(3,.,.) = 
  0.8322  1.2153
  1.7452  1.4126
  1.0120  0.1972

(4,.,.) = 
  0.9815  0.2779
  1.8398 -2.0486
 -0.5690  0.9355
[torch.FloatTensor of size 4x3x2]

(1,.,.) = 
  0.8322  1.2153
  1.7452  1.4126
  1.0120  0.1972

(2,.,.) = 
  0.9815  0.7453
  1.8398 -1.4663
  0.1656  0.9355
[torch.FloatTensor of size 2x3x2]
```
