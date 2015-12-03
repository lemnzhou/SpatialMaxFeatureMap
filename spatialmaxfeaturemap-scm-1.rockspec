package = "spatialmaxfeaturemap"
version = "scm-1"

source = {
  url = "git://github.com/richardhahahaha/SpatialMaxFeatureMap",
  tag = "master"
}

description = {
  summary = "Spatial MaxFeatureMap module for Torch7 neural network modules",
  detailed = [[
                Spatial MaxFeatureMap module for Torch7 neural network modules
  ]],
  homepage = "https://github.com/richardhahahaha/SpatialMaxFeatureMap",
  license = "MIT"
}

dependencies = {
  "torch >= 7.0",
  "nn >= 1.0"
}

build = {
  type = "builtin",
  modules = {
    spatialmaxfeaturemap = "SpatialMaxFeatureMap.lua"
  },
  install = {
    lua = {
      spatialmaxfeaturemap = "SpatialMaxFeatureMap.lua"
    }
  }
}
