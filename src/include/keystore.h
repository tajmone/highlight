/***************************************************************************
                          keystore.h  -  description
                             -------------------
    begin                : Sat Aug 05 2020
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


#ifndef KEYSTORE_H
#define KEYSTORE_H

#include <string>

#include <Diluculum/LuaState.hpp>
#include <Diluculum/LuaFunction.hpp>
#include <Diluculum/LuaVariable.hpp>

using namespace std;

namespace highlight
{

class KeyStore
{
public:
    /** Constructor */
    KeyStore();
    ~KeyStore();

    /** maps keys to values to be accessed in Lua Code*/
    static map <string, string> keyStoreMap;
    
    static int luaStore (lua_State *L);
};

}

#endif
