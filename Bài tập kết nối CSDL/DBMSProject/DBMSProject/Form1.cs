using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;


namespace DBMSProject
{
    public partial class Form1 : Form
    {
        String strConn = @"Data Source=LAPTOPOFCHIMSE\MSSQLSERVER01;Initial Catalog=QuanLyDichVuQuanNet;Integrated Security=True";
        SqlConnection  sqlConn = null;

        public Form1()
        {
            InitializeComponent();
        }

        private void ConnectBtn_Click(object sender, EventArgs e)
        {
            try
            {
                if(sqlConn == null) 
                {
                    sqlConn = new SqlConnection(strConn);
                }              

                if(sqlConn.State == ConnectionState.Closed ) 
                {
                    sqlConn.Open();
                    MessageBox.Show("Connect successfully");
                }
            } 
            catch (Exception ex) 
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void DisconnectBtn_Click(object sender, EventArgs e)
        {
            if(sqlConn != null && sqlConn.State == ConnectionState.Open)
            {
                sqlConn.Close();
                MessageBox.Show("Disconnect successfully");
            }
            else
            {
                MessageBox.Show("connection has not been created");
            }
        }
    }
}
