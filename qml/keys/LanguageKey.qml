/*
 * Copyright 2013 Canonical Ltd.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4

import MaliitKeyboard 2.0

ActionKey {
    iconNormal: altLangs ? "language-chooser" : ""
    iconShifted: iconNormal
    iconCapsLock: iconNormal

    label: altLangs ? "" : "☻"
    shifted: label

    extended: altLangs ? ["☻"] : []
    extendedShifted: extended
    noMagnifier: true

    readonly property bool altLangs: maliit_input_method.enabledLanguages.length > 1
    property bool held: false;

    padding: 0

    width: panel.keyWidth
    overridePressArea: true

    action: "language"

    onPressed: {
        Feedback.keyPressed();

        held = false;
    }

    onReleased: {
        panel.switchBack = false;
        if (held) {
            return;
        }

        if (maliit_input_method.previousLanguage && maliit_input_method.previousLanguage != maliit_input_method.activeLanguage) {
            maliit_input_method.activeLanguage = maliit_input_method.previousLanguage
        } else {
            keypad.state = "EMOJI"
        }
    }

    onPressAndHold: {
        Feedback.keyPressed();

        canvas.languageMenu.open()
        held = true;
    }
}
