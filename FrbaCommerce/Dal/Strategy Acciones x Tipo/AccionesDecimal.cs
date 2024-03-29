﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Dal
{
    internal class AccionesDecimal : AccionesTipo
    {
        override internal string formatToSql(object unValor)
        {
            return ((decimal)unValor).ToString().Replace(',', '.');
        }

        override internal string makeCondition(string nombreCampo, object valorCampo)
        {
            return String.Format("{0} = {1}", nombreCampo, formatToSql(valorCampo));
        }

        override internal bool esVacio(object valorProperty)
        {
            return Math.Truncate(((decimal)valorProperty)) == 0;
        }
    }
}
