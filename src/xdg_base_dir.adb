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

with Ada.Environment_Variables;
with Ada.Strings.Fixed;

package body XDG_Base_Dir is

   function Is_Absolute (Path : String) return Boolean is
     (Path'Length > 0 and then Path (Path'First) = '/');

   function Split (Value, Separator : String) return String_List is
      package SF renames Ada.Strings.Fixed;

      Index : Positive := Value'First;
      Count : constant Positive := SF.Count (Value, Separator) + 1;

      Result : String_List (1 .. Count);
      Result_Index : Positive := Result'First;
   begin
      for I in Result'First .. Result'Last - 1 loop
         declare
            Next_Index : constant Positive := SF.Index (Value, Separator, Index);
            Path : constant String := Value (Index .. Next_Index - 1);
         begin
            if Is_Absolute (Path) then
               Result (Result_Index) := SU.To_Unbounded_String (Path);
               Result_Index := Result_Index + 1;
            end if;
            Index := Next_Index + Separator'Length;
         end;
      end loop;

      declare
         Path : constant String := Value (Index .. Value'Last);
      begin
         if Is_Absolute (Path) then
            Result (Result_Index) := SU.To_Unbounded_String (Path);
            Result_Index := Result_Index + 1;
         end if;
      end;

      return Result (Result'First .. Result_Index - 1);
   end Split;

   function From_Variable (Variable, Default : String) return String_List is
      Result : constant String_List :=
        Split (Ada.Environment_Variables.Value (Variable, Default), ":");
   begin
      return (if Result'Length > 0 then Result else Split (Default, ":"));
   end From_Variable;

   function From_Variable (Variable, Default : String) return String is
      Result : constant String := Ada.Environment_Variables.Value (Variable, Default);
   begin
      return (if Is_Absolute (Result) then Result else Default);
   end From_Variable;

end XDG_Base_Dir;
