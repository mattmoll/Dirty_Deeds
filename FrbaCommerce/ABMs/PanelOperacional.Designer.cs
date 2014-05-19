﻿namespace ABMs
{
    partial class PanelOperacional
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(PanelOperacional));
            this.btnRoles = new System.Windows.Forms.Button();
            this.btnClientes = new System.Windows.Forms.Button();
            this.btnEmpresas = new System.Windows.Forms.Button();
            this.btnRubros = new System.Windows.Forms.Button();
            this.btnVisibilidades = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // btnRoles
            // 
            this.btnRoles.BackColor = System.Drawing.Color.Transparent;
            this.btnRoles.Image = ((System.Drawing.Image)(resources.GetObject("btnRoles.Image")));
            this.btnRoles.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnRoles.Location = new System.Drawing.Point(103, 65);
            this.btnRoles.Name = "btnRoles";
            this.btnRoles.Size = new System.Drawing.Size(117, 34);
            this.btnRoles.TabIndex = 1;
            this.btnRoles.Text = "Roles";
            this.btnRoles.UseVisualStyleBackColor = false;
            this.btnRoles.Click += new System.EventHandler(this.btnRoles_Click);
            // 
            // btnClientes
            // 
            this.btnClientes.BackColor = System.Drawing.Color.Transparent;
            this.btnClientes.Image = ((System.Drawing.Image)(resources.GetObject("btnClientes.Image")));
            this.btnClientes.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnClientes.Location = new System.Drawing.Point(103, 180);
            this.btnClientes.Name = "btnClientes";
            this.btnClientes.Size = new System.Drawing.Size(117, 34);
            this.btnClientes.TabIndex = 2;
            this.btnClientes.Text = "Clientes";
            this.btnClientes.UseVisualStyleBackColor = false;
            this.btnClientes.Click += new System.EventHandler(this.btnClientes_Click);
            // 
            // btnEmpresas
            // 
            this.btnEmpresas.BackColor = System.Drawing.Color.Transparent;
            this.btnEmpresas.Image = ((System.Drawing.Image)(resources.GetObject("btnEmpresas.Image")));
            this.btnEmpresas.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnEmpresas.Location = new System.Drawing.Point(343, 180);
            this.btnEmpresas.Name = "btnEmpresas";
            this.btnEmpresas.Size = new System.Drawing.Size(117, 34);
            this.btnEmpresas.TabIndex = 3;
            this.btnEmpresas.Text = "Empresas";
            this.btnEmpresas.UseVisualStyleBackColor = false;
            this.btnEmpresas.Click += new System.EventHandler(this.btnEmpresas_Click);
            // 
            // btnRubros
            // 
            this.btnRubros.BackColor = System.Drawing.Color.Transparent;
            this.btnRubros.Image = ((System.Drawing.Image)(resources.GetObject("btnRubros.Image")));
            this.btnRubros.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnRubros.Location = new System.Drawing.Point(224, 272);
            this.btnRubros.Name = "btnRubros";
            this.btnRubros.Size = new System.Drawing.Size(117, 34);
            this.btnRubros.TabIndex = 4;
            this.btnRubros.Text = "Rubros";
            this.btnRubros.UseVisualStyleBackColor = false;
            this.btnRubros.Click += new System.EventHandler(this.btnRubros_Click);
            // 
            // btnVisibilidades
            // 
            this.btnVisibilidades.BackColor = System.Drawing.Color.Transparent;
            this.btnVisibilidades.Image = ((System.Drawing.Image)(resources.GetObject("btnVisibilidades.Image")));
            this.btnVisibilidades.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft;
            this.btnVisibilidades.Location = new System.Drawing.Point(343, 65);
            this.btnVisibilidades.Name = "btnVisibilidades";
            this.btnVisibilidades.Size = new System.Drawing.Size(117, 34);
            this.btnVisibilidades.TabIndex = 5;
            this.btnVisibilidades.Text = "Visibilidades";
            this.btnVisibilidades.UseVisualStyleBackColor = false;
            this.btnVisibilidades.Click += new System.EventHandler(this.btnVisibilidades_Click);
            // 
            // PanelOperacional
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Azure;
            this.ClientSize = new System.Drawing.Size(569, 369);
            this.Controls.Add(this.btnVisibilidades);
            this.Controls.Add(this.btnRubros);
            this.Controls.Add(this.btnEmpresas);
            this.Controls.Add(this.btnClientes);
            this.Controls.Add(this.btnRoles);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "PanelOperacional";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Panel Operacional";
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnRoles;
        private System.Windows.Forms.Button btnClientes;
        private System.Windows.Forms.Button btnEmpresas;
        private System.Windows.Forms.Button btnRubros;
        private System.Windows.Forms.Button btnVisibilidades;
    }
}