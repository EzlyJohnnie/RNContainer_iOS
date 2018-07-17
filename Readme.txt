Run below commands to setup the project.
$ cd 'to/project/root/'
$ yarn add react-native
$ yarn add react@version_printed_above
(choose the latest version. If error, try update node.js)
$ cd ios
$ pod update
(If error, try update Ruby and gem)



update node.js if need
$ sudo npm cache clean -f 
$ sudo npm install -g n 
$ sudo n stable



update Ruby if need
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
(skip this if you have Homebrew installed)

$ brew install ruby



update gem
$ sudo gem install cocoapods
