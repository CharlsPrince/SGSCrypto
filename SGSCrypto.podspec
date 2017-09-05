Pod::Spec.new do |s|
  s.name             = 'SGSCrypto'
  s.version          = '0.1.4'
  s.summary          = '安全模块组件，包含常用的哈希算法、安全哈希算法、AES加解密、DES加解密、RSA加解密'

  s.homepage         = 'https://github.com/CharlsPrince/SGSCrypto'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CharlsPrince' => '961629701@qq.com' }
  s.source           = { :git => 'https://github.com/CharlsPrince/SGSCrypto.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.requires_arc  = true
  s.source_files = 'SGSCrypto/Classes/SGSCrypto.h'
  s.public_header_files = 'SGSCrypto/Classes/SGSCrypto.h'

  s.libraries  = 'z'
  s.frameworks = 'Foundation'

  s.subspec 'Hash' do |ss|
    ss.source_files = 'SGSCrypto/Classes/NS{Data,String}+SGSHash.{h,m}'
    ss.public_header_files = 'SGSCrypto/Classes/NS{Data,String}+SGSHash.h'
    ss.libraries  = 'z'
    ss.frameworks = 'Foundation'
  end

  s.subspec 'HMAC' do |ss|
    ss.source_files = 'SGSCrypto/Classes/NS{Data,String}+SGSHMAC.{h,m}'
    ss.public_header_files = 'SGSCrypto/Classes/NS{Data,String}+SGSHMAC.h'
    ss.frameworks = 'Foundation'
  end

  s.subspec 'AESAndDES' do |ss|
    ss.source_files = 'SGSCrypto/Classes/NS{Data,String}+SGSCipher.{h,m}'
    ss.public_header_files = 'SGSCrypto/Classes/NS{Data,String}+SGSCipher.h'
    ss.frameworks = 'Foundation'
  end

  s.subspec 'RSA' do |ss|
    ss.source_files = 'SGSCrypto/Classes/SGSRSACryptor.{h,m}'
    ss.public_header_files = 'SGSCrypto/Classes/SGSRSACryptor.h'
    ss.frameworks = 'Foundation'
  end

end
