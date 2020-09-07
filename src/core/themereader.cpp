/***************************************************************************
                          themereader.cpp  -  description
                             -------------------
    begin                : Son Nov 10 2002
    copyright            : (C) 2002-2020 by Andre Simon
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

#include "themereader.h"
#include "keystore.h"
#include <Diluculum/LuaState.hpp>
#include <sstream>
#include <iostream>
#include <cmath>

namespace highlight
{

ThemeReader::ThemeReader() : fileOK ( false ), restoreStyles(false), dirtyAttributes(false)
{}

ThemeReader::~ThemeReader()
{
    for (unsigned int i=0; i<pluginChunks.size(); i++) {
        delete pluginChunks[i];
    }
}

void ThemeReader::initStyle(ElementStyle& style, const Diluculum::LuaVariable& var)
{
    string styleColor="#000000";
    bool styleBold=false, styleItalic=false, styleUnderline=false;

    if (var["Colour"].value()!=Diluculum::Nil)
        styleColor= var["Colour"].value().asString();
    if (var["Bold"].value()!=Diluculum::Nil)
        styleBold= var["Bold"].value().asBoolean();
    if (var["Italic"].value()!=Diluculum::Nil)
        styleItalic= var["Italic"].value().asBoolean();
    if (var["Underline"].value()!=Diluculum::Nil)
        styleUnderline= var["Underline"].value().asBoolean();

    style.setColour(Colour(styleColor));
    style.setBold(styleBold);
    style.setItalic(styleItalic);
    style.setUnderline(styleUnderline);
}

bool ThemeReader::load ( const string &styleDefinitionPath , OutputType type)
{
    try {
        fileOK=true;

        Diluculum::LuaState ls;

        ls["HL_FORMAT_HTML"]=HTML;
        ls["HL_FORMAT_XHTML"]=XHTML;
        ls["HL_FORMAT_TEX"]=TEX;
        ls["HL_FORMAT_LATEX"]=LATEX;
        ls["HL_FORMAT_RTF"]=RTF;
        ls["HL_FORMAT_ANSI"]=ESC_ANSI;
        ls["HL_FORMAT_XTERM256"]=ESC_XTERM256;
        ls["HL_FORMAT_TRUECOLOR"]=ESC_TRUECOLOR;
        ls["HL_FORMAT_SVG"]=SVG;
        ls["HL_FORMAT_BBCODE"]=BBCODE;
        ls["HL_FORMAT_PANGO"]=PANGO;
        ls["HL_FORMAT_ODT"]=ODTFLAT;
        ls["HL_OUTPUT"] = type;
        ls.doString("Injections={}");
        
        lua_register (ls.getState(), "StoreValue", KeyStore::luaStore);

        ls.doFile (styleDefinitionPath);

        desc = ls["Description"].value().asString();

        if (ls["Categories"].value() !=Diluculum::Nil){

            Diluculum::LuaValueMap categoryMap;
            categoryMap = ls["Categories"].value().asTable();
                
            for(Diluculum::LuaValueMap::const_iterator it = categoryMap.begin(); it != categoryMap.end(); ++it)
            {
                categories.append(it->second.asString());
                if (std::next(it) != categoryMap.end()) {
                    categories.append(",");
                }
            }
        }
        
        if (pluginChunks.size()) {
            Diluculum::LuaValueList params;
            params.push_back(desc);
            for (unsigned int i=0; i<pluginChunks.size(); i++) {
                ls.call(*pluginChunks[i], params, "theme user function");
            }
        }

        initStyle(canvas, ls["Canvas"]);
        initStyle(defaultElem, ls["Default"]);
        initStyle(comment, ls["BlockComment"]);
        initStyle(slcomment, ls["LineComment"]);
        initStyle(directive, ls["PreProcessor"]);
        initStyle(str, ls["String"]);
        initStyle(escapeChar, ls["Escape"]);
        initStyle(interpolation, ls["Interpolation"]);
        initStyle(number, ls["Number"]);
        initStyle(dstr, ls["StringPreProc"]);
        initStyle(line, ls["LineNum"]);
        initStyle(operators, ls["Operator"]);

        int idx=1;
        ElementStyle kwStyle;
        char kwName[5];
        while (ls["Keywords"][idx].value() !=Diluculum::Nil) {
            initStyle(kwStyle, ls["Keywords"][idx]);
            snprintf(kwName, sizeof(kwName), "kw%c", ('a'+idx-1));
            keywordStyles.insert ( make_pair ( string(kwName), kwStyle ));
            idx++;
        }
        
        originalStyles=keywordStyles;
        
        idx=1;
        while (ls["Injections"][idx].value() !=Diluculum::Nil) {
            themeInjections +=ls["Injections"][idx].value().asString();
            idx++;
        }

    } catch (Diluculum::LuaFileError &err) {
        errorMsg = string(err.what());
        return fileOK=false;
    } catch (Diluculum::TypeMismatchError &err) {
        errorMsg = string(err.what());
        return fileOK=false;
    } catch (Diluculum::LuaSyntaxError &err) {
        errorMsg = "syntax error: "+string(err.what());
        return fileOK=false;
    }

    return fileOK;
}

string ThemeReader::getErrorMessage() const
{
    return errorMsg;
}

Colour ThemeReader::getBgColour() const
{
    return canvas.getColour();
}

ElementStyle ThemeReader::getDefaultStyle() const
{
    return defaultElem;
}

ElementStyle ThemeReader::getCommentStyle() const
{
    return comment;
}

ElementStyle ThemeReader::getSingleLineCommentStyle() const
{
    return slcomment;
}

ElementStyle ThemeReader::getStringStyle() const
{
    return str;
}

ElementStyle ThemeReader::getPreProcStringStyle() const
{
    return dstr;
}

ElementStyle ThemeReader::getEscapeCharStyle() const
{
    return escapeChar;
}

ElementStyle ThemeReader::getInterpolationStyle() const
{
    return interpolation;
}

ElementStyle ThemeReader::getNumberStyle() const
{
    return number;
}

ElementStyle ThemeReader::getPreProcessorStyle() const
{
    return directive;
}

ElementStyle ThemeReader::getLineStyle() const
{
    return line;
}

ElementStyle ThemeReader::getOperatorStyle() const
{
    return operators;
}

bool ThemeReader::found () const
{
    return fileOK;
}

ElementStyle ThemeReader::getKeywordStyle ( const string &className )
{
    if ( !keywordStyles.count ( className ) ) return defaultElem;
    return keywordStyles[className];
}

vector <string> ThemeReader::getClassNames() const
{
    vector <string> kwClassNames;
    for ( KSIterator iter = keywordStyles.begin(); iter != keywordStyles.end(); iter++ ) {
        kwClassNames.push_back ( ( *iter ).first );
    }
    return kwClassNames;
}

KeywordStyles ThemeReader::getKeywordStyles() const
{
    return keywordStyles;
}

string ThemeReader::getInjections() const
{
    return themeInjections;
}

void ThemeReader::overrideAttributes(vector<int>& attributes) {
    
    if (dirtyAttributes)
        keywordStyles=originalStyles;
    
    for ( std::vector<int>::iterator it = attributes.begin() ; it != attributes.end(); ++it)
    {
        int kwGroup=*it & 0xf;
        char kwName[5];
        snprintf(kwName, sizeof(kwName), "kw%c", ('a'+kwGroup-1));
        
        if (keywordStyles.count ( kwName)) {
   
            ElementStyle elem = keywordStyles[kwName]; 
            if (*it & 128) elem.setBold(true);
            if (*it & 256) elem.setItalic(true);
            if (*it & 512) elem.setUnderline(true);
            if (*it & 1024) elem.setBold(false);
            if (*it & 2048) elem.setItalic(false);
            if (*it & 4096) elem.setUnderline(false);
            keywordStyles[kwName] = elem;
            dirtyAttributes = true;
        }
    }
}

float ThemeReader::getsRGB(int rgbValue) {
	float s = (float)rgbValue / 255;
	s = (s <= 0.03928) ? s / 12.92 : std::pow(((s + 0.055) / 1.055), 2.4);
	return s;
}

float ThemeReader::getBrightness(const Colour& colour) {
    return  0.2126*getsRGB(colour.getRed()) + 
            0.7152*getsRGB(colour.getGreen()) + 
            0.0722*getsRGB(colour.getBlue());
}
float ThemeReader::getContrast() {
    float canvasBrightness = getBrightness(canvas.getColour());
    float defaultBrightness = getBrightness(defaultElem.getColour());
    return  (std::max(canvasBrightness, defaultBrightness) + 0.05) / 
            (std::min(canvasBrightness, defaultBrightness) + 0.05);
}

}
