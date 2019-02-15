function [a, Alpha, Beta, CBV, Delta, F, Mtt, S0, S1, S2, T0, T02] = flipxBayes(vcnum)

  vcnum = num2str(vcnum);
  
  a     = read4d(perfusionPath(0, fullfile(vcnum, 'bayes', 'F.0001.mean.Ascii')),'ascii','single',256,256,1,1,0,0,0)
  Alpha = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'Alpha.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  Beta  = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'Beta.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  CBV   = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'CBV.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  Delta = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'Delta.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  F     = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'F.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  Mtt   = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'Mtt.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  S0    = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'S0.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  S1    = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'S1.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  S2    = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'S2.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  T0    = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'T0.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  T02   = read4d(perfusionPath(0, fullfile(vcnum, 'bayes2', 'T02.0001.mean.4dfp.img')),'ieee-be','single',256,256,1,1,0,0,0)
  
  Alpha = flipx4d(Alpha);
  Beta = flipx4d(Beta); 
  CBV = flipx4d(CBV); 
  Delta = flipx4d(Delta); 
  F = flipx4d(F); 
  Mtt = flipx4d(Mtt); 
  S0 = flipx4d(S0); 
  S1 = flipx4d(S1); 
  S2 = flipx4d(S2); 
  T0 = flipx4d(T0); 
  T02 = flipx4d(T02);
  
  write4d(Alpha,'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'Alpha.0002.mean.4dfp.img')));
  write4d(Beta, 'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'Beta.0002.mean.4dfp.img')));  
  write4d(CBV,  'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'CBV.0002.mean.4dfp.img')));  
  write4d(Delta,'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'Delta.0002.mean.4dfp.img')));  
  write4d(F,    'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'F.0002.mean.4dfp.img')));  
  write4d(Mtt,  'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'Mtt.0002.mean.4dfp.img')));  
  write4d(S0,   'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'S0.0002.mean.4dfp.img')));  
  write4d(S1,   'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'S1.0002.mean.4dfp.img')));  
  write4d(S2,   'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'S2.0002.mean.4dfp.img')));  
  write4d(T0,   'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'T0.0002.mean.4dfp.img')));  
  write4d(T02,  'single','ieee-be',perfusionPath(0, fullfile(vcnum, 'bayes2', 'T02.0002.mean.4dfp.img')));  
