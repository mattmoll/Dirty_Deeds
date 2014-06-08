﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Dal;
using System.Data;

namespace Dominio
{
    public class Rol
    {
        //Miembros
        private DataAccessObject<Rol> daoRol;

        // Properties con la convencion del DataAccessObject
        public int autoId { get; set; }
        public string campoNombre { get; set; }
        public bool campoDeleted { get; set; }

        #region Constructores
        public Rol() { }

        public Rol(string nombre, bool p_deleted)
        {
            campoNombre = nombre;
            campoDeleted = p_deleted;
            daoRol = new DataAccessObject<Rol>();
        }

        public Rol(string nombre): this(nombre, false){ }

        #endregion


        //Metodos publicos
        public static Rol get(int idClavePrimaria)
        {
            return DataAccessObject<Rol>.get(idClavePrimaria);
        }

        public void save()
        {
            daoRol.insert(this);
        }

        public void update()
        {
            daoRol.update(this);
        }

        public DataTable upFullByPrototype()
        {
            return daoRol.upFullOnTableByPrototype(this);
        }

        public static void delete(int idClavePrimaria)
        {
            DataAccessObject<Rol>.delete(idClavePrimaria);
        }

        public void borradoLogico()
        {
            campoDeleted = true;
            update();
        }

    }
}
