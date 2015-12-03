local SpatialMaxFeatureMap, parent = torch.class('nn.SpatialMaxFeatureMap', 'nn.Module')

function SpatialMaxFeatureMap:__init(divisor)
   parent.__init(self)
   self.divisor = divisor or 2
   assert(self.divisor>1)
   self.train = true
end

function SpatialMaxFeatureMap:buildInternalModules(input)
   local isize=input:size()
   local csize=isize:size()
   local b,c,h,w
   if csize==4 then --batch inputs
      b,c,h,w=isize[1], isize[2], isize[3], isize[4]
   else
      b,c,h,w=false, isize[1], isize[2], isize[3]
   end
   assert(csize>=3 and c%self.divisor==0)
   if not (b==self.batch and c==self.channel and w==self.width and h==self.height) then
      self.modules=nn.Sequential()
      if b then
         self.modules:add(nn.View(b, self.divisor, c/self.divisor*h*w))
         self.modules:add(nn.Max(2))
         self.modules:add(nn.View(b, c/self.divisor, h, w))
      else
         self.modules:add(nn.View(self.divisor, c/self.divisor*h*w))
         self.modules:add(nn.Max(1))
         self.modules:add(nn.View(c/self.divisor, h, w))
      end
      if input:type()=='torch.CudaTensor' then self.modules:cuda() end
      self.channel=c 
      self.width=w
      self.height=h
      self.batch=b
   end
end

function SpatialMaxFeatureMap:updateOutput(input)
   self:buildInternalModules(input)
   self.modules:updateOutput(input)
   self.output=self.modules.output
   return self.output
end

function SpatialMaxFeatureMap:updateGradInput(input, gradOutput)
   self:buildInternalModules(input)
   self.modules:updateGradInput(input, gradOutput)
   self.gradInput=self.modules.gradInput
   return self.gradInput
end

function SpatialMaxFeatureMap:__tostring__()
  return string.format('%s (%d)', torch.type(self), self.divisor)
end
