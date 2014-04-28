#!/bin/sh
scriptversion=2014-04-28;
# this script is used to run pngcrush 
# 1. you can specify where the png locates and where reverted png locates
# 2. default "reverted" dir is created under the png source dir
# 3. {PWD} is used as the source dir if none parameter is provided
program=`xcrun -sdk iphoneos -find pngcrush`

parCount=$#
case $parCount in
	 2)			source=$1 dirname=$2;;
	 1)			source=$1 dirname="reverted";;
	 *)			source=$PWD dirname="reverted";;	
		
esac

echo "*.png in "
echo $source
if [[ $dirname == "reverted" ]]; then
	dirname=$source/$dirname
fi

echo "will be reverted to "
echo $dirname

echo "start:"
$program -dir $dirname -revert-iphone-optimizations -q $source/*.png

echo "done!"