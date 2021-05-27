using System;
using System.Collections.Generic;
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
    /// Логика взаимодействия для MailPage.xaml
    /// </summary>
    public partial class MailPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public MailPage()
        {
            InitializeComponent();
        }

        private void CreateSMTPAccount_Click(object sender, RoutedEventArgs e)
        {
            string configure = "IF (SELECT is_broker_enabled FROM sys.databases WHERE [name] = 'msdb') = 0 " +
                               "ALTER DATABASE msdb SET ENABLE_BROKER WITH ROLLBACK AFTER 10 SECONDS";
            actions.exec_Querey(configure);
            actions.exec_Querey("sp_configure 'Database Mail XPs', 1 ");
            actions.exec_Querey("RECONFIGURE");
            actions.exec_Querey("EXECUTE msdb.dbo.sysmail_help_status_sp");

            Navigation.main.Navigate(new smtpAccountPage());
        }

        private void SendMail_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new SendMailPage());
        }

        private void CreateProfileAccount_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new CreateProfileAccountPage());
        }
    }
}
