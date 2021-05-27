using System;
using System.Windows;
using System.Windows.Controls;
using Microsoft.Win32;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для BackupPage.xaml
    /// </summary>
    public partial class BackupPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public BackupPage()
        {
            InitializeComponent();
        }

        private void FullBackup_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.Filter = "Backup files (*.bak)|*.bak|All files (*.*)|*.*";
                if (saveFileDialog.ShowDialog() == true)
                {
                    if (string.IsNullOrEmpty(ConnStringClass.connStr) == false)
                        actions.FullBackup(saveFileDialog.FileName);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Что-то пошло не так.\n" + ex.Message);
            }

        }

        private void DiffBackup_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                SaveFileDialog saveFileDialog = new SaveFileDialog();
                saveFileDialog.Filter = "Backup files (*.bak)|*.bak|All files (*.*)|*.*";
                if (saveFileDialog.ShowDialog() == true)
                {
                    if (string.IsNullOrEmpty(ConnStringClass.connStr) == false)
                        actions.DifferentialBackup(saveFileDialog.FileName);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Что-то пошло не так.\n" + ex.Message);
            }

        }

        private void TranBackup_Click(object sender, RoutedEventArgs e)
        {
            string setRecovery = "USE [master] ;\n" +
                                 "ALTER DATABASE[ascii] SET RECOVERY FULL; ";
            string TransactionBackupTask = "";
            SaveFileDialog sf = new SaveFileDialog();
            sf.Filter = "Backup files (*.bak)|*.bak|All files (*.*)|*.*";
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
                MessageBox.Show("Что-то пошло не так.\n" + ex.Message);
            }
            
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.GoBack();
        }
    }
}
