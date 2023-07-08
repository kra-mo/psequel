/* window.vala
 *
 * Copyright 2023 Unknown
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */

using GLib;

namespace Sequelize {

    [GtkTemplate (ui = "/me/ppvan/sequelize/gtk/window.ui")]
    public class Window : Adw.ApplicationWindow {

        [GtkChild]
        private unowned Gtk.Box main;


        public Window (Application app) {
            Object (application: app);

            var indexview = new View.Index (app);
            // var label = new Gtk.Label ("Hello");
            main.append (indexview);
        }
    }
}