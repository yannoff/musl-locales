# Translations.cmake, CMake macros written for Marlin, feel free to re-use them

macro (add_musl_translations_directory NLS_PACKAGE LOCPATH)
    add_custom_target (musl-i18n ALL COMMENT ?Building i18n messages for C library.?)
    find_program (MSGFMT_EXECUTABLE msgfmt)
    # be sure that all languages are present
    # Using all usual languages code from https://www.gnu.org/software/gettext/manual/html_node/Language-Codes.html#Language-Codes
    # Rare language codes should be added on-demand.
    if (DEFINED LOCALES)
        set(LANGUAGES_NEEDED ${LOCALES})
    else ()
        file(STRINGS LOCALES LANGUAGES_NEEDED)
    endif ()
    foreach (LANGUAGE_NEEDED ${LANGUAGES_NEEDED})
        create_po_file (${LANGUAGE_NEEDED})
        # generate .mo from .po
        set (PO_INPUT ${CMAKE_CURRENT_SOURCE_DIR}/${LANGUAGE_NEEDED}.po)
        message ("PO Input: ${PO_INPUT}")
        get_filename_component (PO_INPUT_BASE ${PO_INPUT} NAME_WE)
        message ("PO Input Base: ${PO_INPUT_BASE}")
        set (MO_OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/${PO_INPUT_BASE}.UTF-8)
        message ("MO Output: ${MO_OUTPUT}")
        set (PO_COPY ${CMAKE_CURRENT_BINARY_DIR}/${PO_INPUT_BASE}.po)
        file (COPY ${PO_INPUT} DESTINATION ${CMAKE_CURRENT_BINARY_DIR})
        add_custom_command (TARGET musl-i18n COMMAND ${MSGFMT_EXECUTABLE} -o ${MO_OUTPUT} ${PO_INPUT})

        install (FILES ${MO_OUTPUT} DESTINATION
            ${CMAKE_INSTALL_DATAROOTDIR}/${LOCPATH})
    endforeach (LANGUAGE_NEEDED ${LANGUAGES_NEEDED})
endmacro (add_musl_translations_directory)
