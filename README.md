# Locales support for musl
Locale program for musl libc

This is ```/usr/bin/locale```, which works on musl libc (with limitations in musl itself).
To install, use ```cmake . && make && sudo make install``` on musl-capable distro.

English, Russian, Swiss german and French are included, also .pot file.

*HINT: To add/remove languages to install, you can either:*
- Edit the `po/LOCALES` & `musl-po/LOCALES` files
- Overwrite the `LOCALES` variable when invoking `cmake` as follow:

```
cmake -DLOCALES="fr_FR;de_CH" .
```

> NOTE: locales have to be separated by a `;` semi-colon.


## Build requirements:
 - musl (with developer tools)
 - gettext (with libintl and developer tools)
 - С compiler (gcc or clang recommended)
 - CMake
 - CMake backend provider (make or ninja)
 
 *For alpine, you can use this command:* ```apk add --update cmake make musl-dev gcc gettext-dev libintl```

## License

 - All translations and scripts uses [MIT](LICENSE.MIT)
 - Source files for `/usr/bin/locale` uses [LGPL](LICENSE)
