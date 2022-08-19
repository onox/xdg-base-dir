--  SPDX-License-Identifier: Apache-2.0
--
--  Copyright (c) 2022 onox <denkpadje@gmail.com>
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.

with Ada.Strings.Unbounded;

package XDG_Base_Dir is
   pragma Preelaborate;

   function Config return String;
   function Cache  return String;
   function Data   return String;
   function State  return String;

   function Runtime return String;
   --  Must be on a local file system and owned by the user with access mode 0700
   --
   --  Returned string is empty if no directory was specified and the
   --  application should fall back to some default

   function Executable return String;

   package SU renames Ada.Strings.Unbounded;

   function "+" (Value : SU.Unbounded_String) return String renames SU.To_String;

   type String_List is array (Positive range <>) of SU.Unbounded_String;

   function Data_Dirs   return String_List;
   function Config_Dirs return String_List;

private

   function From_Variable (Variable, Default : String) return String;
   function From_Variable (Variable, Default : String) return String_List;

   function Home return String is (From_Variable ("HOME", "~"));

   function Config return String is (From_Variable ("XDG_CONFIG_HOME", Home & "/.config"));
   function Cache  return String is (From_Variable ("XDG_CACHE_HOME", Home & "/.cache"));
   function Data   return String is (From_Variable ("XDG_DATA_HOME", Home & "/.local/share"));
   function State  return String is (From_Variable ("XDG_STATE_HOME", Home & "/.local/state"));

   function Runtime return String is (From_Variable ("XDG_RUNTIME_DIR", ""));

   function Executable return String is (Home & "/.local/bin");

   function Data_Dirs return String_List is
     (From_Variable ("XDG_DATA_DIRS", "/usr/local/share/:/usr/share/"));

   function Config_Dirs return String_List is
     (From_Variable ("XDG_CONFIG_DIRS", "/etc/xdg"));

end XDG_Base_Dir;
