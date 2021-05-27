using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для manageConnectionsPage.xaml
    /// </summary>
    public partial class manageConnectionsPage : Page
    {
        classes.SqlServerActions actions = new classes.SqlServerActions();
        string connStr = "";
        bool isLocal = false;
        bool Trusted = false;
        string login = "";
        string password = "";
        string DataSource;
        string database = "";
        string timeout = "";

        public manageConnectionsPage()
        {
            InitializeComponent();
        }

        private void connect_Click(object sender, RoutedEventArgs e)
        {
            connStr =
                ConnStringClass.CreateConnString(false, false,
                    instancesList.Text, databasesList.Text, loginBox.Text,
                    passwordBox.Text, null);
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                con.Close();
            }
            Navigation.main.Navigate(new MainPage());
        }
    }
}
