#!/usr/bin/env python
# -*- coding: utf-8 -*-

def isdigit(s):
    if s.isdigit():
        return True
    import re
    if re.match( '\d+[a-zA-Z]+', s ):
        return True
    if re.match( '[a-zA-Z]+\d+', s ):
        return True
    return False

def main():
    import glob
    import os
    import shutil
    files = glob.glob( "*.pdf" )
    for file_name in files:
        parts = file_name.split('.')
        index = -2
        if len(parts)<=2:
            print( "Skip %s" % file_name )
            continue
        print( "Processing %s" % file_name )
        while not isdigit( parts[ index ] ):
            index = index + 1
            if index>=len(parts):
                break
        dir_name = " ".join( parts[ :index ] )
        if not os.path.exists( dir_name ):
            os.mkdir( dir_name )
        try:
            print( "Move '%s' to '%s'." % 
                    ( file_name, os.path.join( dir_name, file_name ) ) )
            shutil.move( file_name, 
                    os.path.join( dir_name, file_name ) )
        except shutil.Error, e:
            print( e )
        except Exception, e:
            print( "index=%d" % index )
            print( e )

if __name__ == "__main__":
    main()

