using Microsoft.Win32;
using System.Windows;
using SqlAdminUtility.classes;
using SqlAdminUtility.pages;
using SqlAdminUtility.windows;


namespace SqlAdminUtility
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        SqlServerActions actions = new SqlServerActions();
        public MainWindow()
        {
            InitializeComponent();
            Navigation.main = this.mainFrame;
        }

        private void ManageConnections_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new pages.manageConnectionsPage());

        }

        private void CreateBackup_Click(object sender, RoutedEventArgs e)
        {

        }

        private void FullBackup_Click(object sender, RoutedEventArgs e)
        {
            SaveFileDialog saveFileDialog = new SaveFileDialog();
            saveFileDialog.Filter = "Backup files (*.bak)|*.bak|All files (*.*)|*.*";
            if (saveFileDialog.ShowDialog() == true)
            {
                if (string.IsNullOrEmpty(ConnStringClass.connStr) == false)
                    actions.FullBackup(saveFileDialog.FileName);
            }
        }

        private void Users_Click(object sender, RoutedEventArgs e)
        {

        }

        private void AddDatabaseUser_Click(object sender, RoutedEventArgs e)
        {

        }

        private void AddServerUser_Click(object sender, RoutedEventArgs e)
        {

        }

        private void history_Click(object sender, RoutedEventArgs e)
        {
            History history = new History(actions.LastTimeBackupWasDone());
            history.Show();

        }

        private void mailSettings_Click(object sender, RoutedEventArgs e)
        {
            string configure = "IF (SELECT is_broker_enabled FROM sys.databases WHERE [name] = 'msdb') = 0" +
            "ALTER DATABASE msdb SET ENABLE_BROKER WITH ROLLBACK AFTER 10 SECONDS" +
            "GO" +
            "sp_configure 'Database Mail XPs', 1" +
            "GO" +
            "RECONFIGURE" +
            "GO" +
            "EXECUTE msdb.dbo.sysmail_help_status_sp" +
            "GO";
            actions.exec_Querey(configure);
        }

        private void createSMTPaccount_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new smtpAccountPage());
        }
        private void AddMailProfile_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new CreateProfileAccountPage());
        }

        private void SendMail_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new SendMailPage());
        }
    }
}
