# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cleverelements/version'

Gem::Specification.new do |spec|
  spec.name          = "cleverelements"
  spec.version       = CleverElements::VERSION
  spec.authors       = ["Despark"]
  spec.email         = ["contact@despark.com"]

  spec.summary       = "A ruby gem to help you implement [Clever Elements'](http://www.cleverelements.com/, 'Clever Elements') API in your projects. Detailed API documentations can be found here: [http://support.cleverelements.com/kb/api/](http://support.cleverelements.com/kb/api/, 'View API docs')."
  spec.description   = "The API works with the network protocol SOAP (Simple Object Access Protocol). SOAP libraries can be found in many modern programming languages such as PHP, Python, Java and C++. SOAP therefore provides a good basis for simple cross-language communication. The basis for SOAP is the WSDL file, in which all functions and parameters of the API are described. The WSDL file is provided in XML format and can be read by many editors (e.g. Aptana). [More Info about our API](http://support.cleverelements.com/kb/api/)"
  spec.homepage      = "http://www.cleverelements.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "savon", "~> 2.10", ">= 2.10.0"
end
