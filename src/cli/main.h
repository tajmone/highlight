
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


#ifndef HIGHLIGHT_APP
#define HIGHLIGHT_APP


#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <iomanip>
#include <cassert>

#include "cmdlineoptions.h"
#include "codegenerator.h"
#include "help.h"
#include "datadir.h"
#include "version.h"
#include "platform_fs.h"

#define IO_ERROR_REPORT_LENGTH 5


/// Main application class of the command line interface

class HLCmdLineApp
{

public:

    HLCmdLineApp() {};
    ~HLCmdLineApp() {};

    /** Start application
      \param argc Number of command line arguments
      \param argv values of command line arguments
      \return EXIT_SUCCESS or EXIT_FAILURE
    */
    int run ( const int argc, const char *argv[] );

private:

    DataDir dataDir;
    

    /** print version info*/
    void printVersionInfo();

    /** print configuration info*/
    void printConfigInfo ();

    /** print error message*/
    void printBadInstallationInfo();

    /** print input and output errors */
    void printIOErrorReport ( unsigned int numberErrorFiles, vector<string> & fileList, 
                              const string &action );

    /** list installed  files
        \return true if files were found
    */
    int printInstalledFiles(const string& where, const string& wildcard, const string& kind, 
                            const string&option, const string& categoryFilterList="");

    /** print debug information
        \param  lang language definition
        \param langDefPath path to language definition
    */
    void printDebugInfo ( const highlight::SyntaxReader *lang,
                          const string &langDefPath );

    int getNumDigits ( int i );

    void printProgressBar ( int total, int count );
    void printCurrentAction ( const string&outfilePath,
                              int total, int count, int countWidth );

    bool readInputFilePaths ( vector<string> &fileList, string wildcard,
                              bool recursiveSearch );

    void printInstalledFiles();

    vector <string> collectPluginPaths(const vector<string>& plugins);
};

#endif
