﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dal;
using System.Data;

namespace Dominio
{
    public class Direccion
    {
        //Miembros
        private DataAccessObject<Direccion> daoDireccion;

        // Properties con la convencion del DataAccessObject
        public int autoId { get; set; }
        public string campoDomicilio { get; set; }
        public int campoNumeroCalle { get; set; }
        public int campoPiso { get; set; }
        public string campoDepto { get; set; }
        public int campoIdLocalidad { get; set; }


        #region Constructores
        public Direccion() { daoDireccion = new DataAccessObject<Direccion>(); }

        public Direccion(string domicilio, int numeroCalle, 
                         int piso, string depto, int idLocalidad): this()
        {
            campoDomicilio = domicilio;
            campoNumeroCalle = numeroCalle;
            campoPiso = piso;
            campoDepto = depto;
            campoIdLocalidad = idLocalidad;
        }

        #endregion


        //Metodos publicos
        public static Direccion get(int idClavePrimaria)
        {
            return DataAccessObject<Direccion>.get(idClavePrimaria);
        }

        public void save()
        {
            daoDireccion.insert(this);
        }

        public void update()
        {
            daoDireccion.update(this);
        }

        public DataTable upFullByPrototype()
        {
            return daoDireccion.upFullOnTableByPrototype(this);
        }

        public static void delete(int idClavePrimaria)
        {
            DataAccessObject<Direccion>.delete(idClavePrimaria);
        }
    }
}