/***************************************************************************
                          datadir.h  -  description
                             -------------------
    begin                : Sam March 1 2003
    copyright            : (C) 2003-2019 by Andre Simon
    email                : a.simon@mailbox.org
 ***************************************************************************/


/*
This file is part of Highlight.

Highlight is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Highlight is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Highlight.  If not, see <http://www.gnu.org/licenses/>.
*/


#ifndef DATADIR_H
#define DATADIR_H

#include <map>
#include <boost/xpressive/xpressive_dynamic.hpp>
#include <Diluculum/LuaState.hpp>

#include "stringtools.h"

using namespace std;

typedef map<string, string> StringMap;


/** \brief Manages access to installation directories.

    Apart from the standard installation directory, one can define additional
    search paths. If the additonal paths do not exist, the default paths are
    returned.
 **/

class DataDir
{
    vector <string> possibleDirs;
    
private:

    const string searchFile(const string path);
    
    string getFileBaseName(const string& fileName);

    string analyzeFile ( const string& file );
    
    void readLuaList(const string& paramName, const string& langName,Diluculum::LuaValue &luaVal, StringMap* extMap);
    
public:

    StringMap assocByExtension, assocByFilename, assocByShebang;

    static string LSB_DATA_DIR;
    static string LSB_CFG_DIR;
    static string LSB_DOC_DIR;

    /** search for a valid installation directory
        \param  userDefinedDir Directory defined by user
        \return True if directory was found */
    void initSearchDirectories ( const string &userDefinedDir );

    // Deprecated
    void searchDataDir( const string &userDefinedDir );

    const void printConfigPaths();

    /**  \param file file
         \return Location of given syntax definition */
    const string getLangPath ( const string & file) ;

    /** \return System themes location */
    const string getThemePath ( ) ;

    /** \return System syntax location */
    const string getLangPath ( ) ;

    /** \return System syntax location */
    const string getSystemDataPath ( ) ;

    /** \return Location of plugins */
    const string getPluginPath ();

    /** \param file file
     *  \param base16 set to true if the theme is located in the base16 sub dir
        \return Location of given theme */
    const string getThemePath ( const string & file, bool base16=false ) ;

    /** \param file file
        \return Location of given configuration file */
    const string getFiletypesConfPath (const string &path="filetypes.conf");
    
    /** \param file file
        \return Location of given plugin file */
    const string getPluginPath (const string &);

    /** \return Location of GUI menu translation files */
    const string getI18nDir();

    /** \return Location of GUI file extension filter files */
    const string getExtDir();

    /** \return Location of documentation (README) files (GUI) */
    const string getDocDir();
    
    // These functions were moved from main.cpp in 3.51:
    
    /**
     * \param fileName input file name 
     * \return file extension or the base filename if no file extension exists
    */
    string getFileSuffix ( const string &fileName );

    /**
     * \param suffix file name suffix
     * \param inputFile name of the input file
     * \param useUserSuffix true if user has defined a syntax suffix
     * \param forceShebangCheckStdin true if stdin should be peeked to look for shebang patterns 
     * \return file type deferred from extension or file shebang comment
    */
    string guessFileType ( const string &suffix, const string &inputFile, 
                           bool useUserSuffix=false, bool forceShebangCheckStdin=false );
    
    /**
     * \param name absolute path of filetypes.conf
     * \return true if successfull
    */
    bool loadFileTypeConfig ( const string& name);
};

#endif
