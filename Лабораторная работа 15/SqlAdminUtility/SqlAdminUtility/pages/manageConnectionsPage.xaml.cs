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
            instancesList.ItemsSource = actions.GetInstances();
            if (trustedConnection.IsChecked == true)
            {
                Trusted = true;
            }
            if (localCheckBox.IsChecked == true)
            {
                isLocal = true;
            }
        }

        private void connect_Click(object sender, RoutedEventArgs e)
        {
            connStr = classes.ConnStringClass.CreateConnString(isLocal, Trusted, DataSource, database, login, password, timeout);
            ConnectionStringBox.Text = connStr;
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();
                con.Close();
            }
        }

        private void instancesList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (instancesList.SelectedItem != null)
            {
                if (instancesList.SelectedItem.ToString() == Environment.MachineName + "\\MSSQLSERVER")
                    DataSource = "Data Source=" + instancesList.SelectedItem.ToString().Replace("\\MSSQLSERVER", "") + "; ";
                else
                    DataSource = "Data Source=" + instancesList.SelectedItem.ToString() + ";";
            }
            else
            {
                DataSource = "Data Source=(local);";
            }
            connStr = classes.ConnStringClass.CreateConnString(isLocal, Trusted, DataSource, database, login, password, timeout);
            databasesList.ItemsSource = actions.GetDatabaseList(connStr);
        }

        private void trustedConnection_Click(object sender, RoutedEventArgs e)
        {
            if (trustedConnection.IsChecked == true)
            {
                passwordBox.Visibility = Visibility.Hidden;
                loginBox.Visibility = Visibility.Hidden;
                passwordBox.Text = "";
                loginBox.Text = "";
                Trusted = true;
            }
            else
            {
                passwordBox.Visibility = Visibility.Visible;
                loginBox.Visibility = Visibility.Visible;
                passwordBox.Text = "";
                loginBox.Text = "";
                Trusted = false;
            }
        }

        private void databasesList_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (databasesList.SelectedItem != null)
            {
                database = databasesList.SelectedItem.ToString() + ";";
            }
        }

        private void localCheckBox_Click(object sender, RoutedEventArgs e)
        {
            if (localCheckBox.IsChecked == true)
            {
                isLocal = true;
                timeout = "";
                DataSource = "Data Source=(local);";
            }
            else
            {
                if (instancesList.SelectedItem != null)
                {
                    timeout = "Timeout = 30;";
                    DataSource = "Data Source=" + instancesList.SelectedItem.ToString() + "; ";
                }
                else
                {
                    isLocal = true;
                    timeout = "";
                    DataSource = "Data Source=(local);";
                }
            }
        }
    }
}
