﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Windows.Forms;
using Dominio;
using System.Drawing;
using TNGS.NetControls;

namespace ABMs
{
    class Roles : ABMEspecifico
    {
        TextEdit teNombre = new TextEdit();
        CheckBox cbBorrado = new CheckBox();

        public override DataTable ejecutarBusqueda()
        {
            return Rol.upFullByCondition();
        }

        public override void grabarAlta()
        {
            // Creamos el rol y lo mandamos a grabar.
            Rol unRol = new Rol(teNombre.Text, cbBorrado.Checked);
            unRol.save();
        }

        public override Panel getPanel(Size tamañoPanel)
        {
            PanelBuilder builder = new PanelBuilder(tamañoPanel, PanelBuilder.Alineacion.Horizontal);
            builder.AddControlWithLabel("Nombre", teNombre)
                   .AddControlWithLabel("Borrado", cbBorrado)
                   .centrarControlesEnElPanel();

            return builder.getPanel;
        }
    }
}
