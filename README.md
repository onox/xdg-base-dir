[![Build status](https://github.com/onox/xdg-base-dir/actions/workflows/build.yaml/badge.svg)](https://github.com/onox/xdg-base-dir/actions/workflows/build.yaml)
[![License](https://img.shields.io/github/license/onox/xdg-base-dir.svg?color=blue)](https://github.com/onox/xdg-base-dir/blob/master/LICENSE)
[![Alire crate](https://img.shields.io/endpoint?url=https://alire.ada.dev/badges/xdg_base_dir.json)](https://alire.ada.dev/crates/xdg_base_dir.html)
[![GitHub release](https://img.shields.io/github/release/onox/xdg-base-dir.svg)](https://github.com/onox/xdg-base-dir/releases/latest)
[![Gitter chat](https://badges.gitter.im/gitterHQ/gitter.svg)](https://gitter.im/ada-lang/Lobby)

# xdg-base-dir

Ada 2012 library implementing [XDG Base Directory Specification][url-xdg-base-dir].

## Usage

```ada
with Ada.Text_IO;

with XDG_Base_Dir;

procedure Example is
   use XDG_Base_Dir;
begin
   Ada.Text_IO.Put_Line ("Config:     " & XDG_Base_Dir.Config);
   Ada.Text_IO.Put_Line ("Cache:      " & XDG_Base_Dir.Cache);
   Ada.Text_IO.Put_Line ("Data:       " & XDG_Base_Dir.Data);
   Ada.Text_IO.Put_Line ("State:      " & XDG_Base_Dir.State);
   Ada.Text_IO.Put_Line ("Runtime:    " & XDG_Base_Dir.Runtime);
   Ada.Text_IO.Put_Line ("Executable: " & XDG_Base_Dir.Executable);

   Ada.Text_IO.Put_Line ("Data dirs:");
   for Path of XDG_Base_Dir.Data_Dirs loop
      Ada.Text_IO.Put_Line ("- " & (+Path));
   end loop;

   Ada.Text_IO.Put_Line ("Config dirs:");
   for Path of XDG_Base_Dir.Config_Dirs loop
      Ada.Text_IO.Put_Line ("- " & (+Path));
   end loop;
end Example;
```

## Dependencies

In order to build the library, you need to have:

 * An Ada 2012 compiler

 * [Alire][url-alire] package manager

## Contributing

Please read the [contributing guidelines][url-contributing] before opening
issues or pull requests.

## License

These bindings are licensed under the [Apache License 2.0][url-apache].
The first line of each Ada file should contain an SPDX license identifier tag that
refers to this license:

    SPDX-License-Identifier: Apache-2.0

  [url-alire]: https://alire.ada.dev/
  [url-apache]: https://opensource.org/licenses/Apache-2.0
  [url-contributing]: /CONTRIBUTING.md
  [url-xdg-base-dir]: https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
