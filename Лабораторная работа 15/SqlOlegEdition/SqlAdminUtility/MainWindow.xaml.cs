using System;
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
            Navigation.main.Navigate(new manageConnectionsPage());
        }

        private void ManageConnections_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new pages.manageConnectionsPage());
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
     
        private void history_Click(object sender, RoutedEventArgs e)
        {
            History history = new History(actions.LastTimeBackupWasDone());
            history.Show();
        }

        private void mailSettings_Click(object sender, RoutedEventArgs e)
        {
            string configure = "IF (SELECT is_broker_enabled FROM sys.databases WHERE [name] = 'msdb') = 0 " +
            "ALTER DATABASE msdb SET ENABLE_BROKER WITH ROLLBACK AFTER 10 SECONDS ";
            actions.exec_Querey(configure);
            actions.exec_Querey("sp_configure 'Database Mail XPs', 1 ");
            actions.exec_Querey("RECONFIGURE");
            actions.exec_Querey("EXECUTE msdb.dbo.sysmail_help_status_sp");
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

        private void TransactionalBackup_Click(object sender, RoutedEventArgs e)
        {
            string setRecovery = "USE [master] ;\n"+
                                 "ALTER DATABASE[ascii] SET RECOVERY FULL; ";
            string TransactionBackupTask = "";
            SaveFileDialog sf = new SaveFileDialog();
            try
            {
                if (sf.ShowDialog() == true)
                {
                    if (string.IsNullOrEmpty(ConnStringClass.connStr) == false)
                        actions.FullBackup(sf.FileName);
                    TransactionBackupTask = "BACKUP LOG " + ConnStringClass.database.Replace("database = ", "").Replace(";", "") + "\n" +
                                            "TO Disk ='" + sf.FileName + "';\n";
                }
                actions.exec_Querey(setRecovery);
                actions.exec_Querey(TransactionBackupTask);
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message.ToString());
            }
        }
    }
}
