using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Windows;

namespace SqlAdminUtility.classes
{
    class SqlServerActions
    {
        public List<string> GetInstances()
        {
            List<string> conns = new List<string>();
            RegistryView registryView = Environment.Is64BitOperatingSystem ? RegistryView.Registry64 : RegistryView.Registry32;
            using (RegistryKey hklm = RegistryKey.OpenBaseKey(RegistryHive.LocalMachine, registryView))
            {
                RegistryKey instanceKey = hklm.OpenSubKey(Properties.Settings.Default.instancespath, false);
                if (instanceKey != null)
                {
                    foreach (var instanceName in instanceKey.GetValueNames())
                    {
                        conns.Add(Environment.MachineName + @"\" + instanceName);
                    }
                }
            }
            return conns;
        }
        public List<string> GetDatabaseList(string ConnectionString)
        {
            List<string> list = new List<string>();
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();
                using (SqlCommand cmd = new SqlCommand("SELECT name from sys.databases", con))
                {
                    using (IDataReader dr = cmd.ExecuteReader())
                    {
                        while (dr.Read())
                        {
                            list.Add(dr[0].ToString());
                        }
                    }
                }
                con.Close();
            }
            return list;
        }
        public void FullBackup(string path)
        {
            if (path.Contains("'") == false)
            {
                SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
                sqlConnection.Open();
                string que = "Backup database " + sqlConnection.Database + " to disk='" + path + "'";
                SqlCommand command = new SqlCommand(que, sqlConnection);
                command.ExecuteNonQuery();
                sqlConnection.Close();
            }
            else
            {
                MessageBox.Show("Path should not contains ' symbols", "");
            }
        }
        public void DifferentialBackup(string path)
        {
            if (path.Contains("'") == false)
            {
                SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
                sqlConnection.Open();
                string que = "Backup database " + sqlConnection.Database + " to disk='" + path + "'" + "WITH DIFFERENTIAL;";
                SqlCommand command = new SqlCommand(que, sqlConnection);
                command.ExecuteNonQuery();
                sqlConnection.Close();
            }
            else
            {
                MessageBox.Show("Path should not contains ' symbols", "");
            }
        }
        public List<HistoryClass> LastTimeBackupWasDone()
        {
            SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);

            sqlConnection.Open();
            string que = "SELECT " +
            "CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, " +
            "msdb.dbo.backupset.database_name, " +
            "msdb.dbo.backupset.backup_start_date, " +
            "msdb.dbo.backupset.backup_finish_date, " +
            "CASE msdb..backupset.type " +
            "WHEN 'D' THEN 'Database' " +
            "WHEN 'L' THEN 'Log' " +
            "When 'I' THEN 'Differential database'" +
            "END AS backup_type, " +
            "msdb.dbo.backupset.backup_size, " +
            "msdb.dbo.backupmediafamily.physical_device_name, " +
            "msdb.dbo.backupset.name AS backupset_name " +
            "FROM msdb.dbo.backupmediafamily " +
            "INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id " +
            "ORDER BY " +
            "msdb.dbo.backupset.backup_finish_date desc";
            List<HistoryClass> history = new List<HistoryClass>();
            SqlCommand command = new SqlCommand(que, sqlConnection);
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        HistoryClass item = new HistoryClass(reader.GetString(0), reader.GetString(1),
                            reader.GetDateTime(2), reader.GetDateTime(3), reader.GetString(4),
                            reader.GetDecimal(5), reader.GetString(6), reader.GetSqlString(7));
                        history.Add(item);
                    }
                }
            }
            return history;
        }

        public MailAccount[] GetMailAccounts()
        {
            SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
            string que = "SELECT * FROM msdb.dbo.sysmail_account";
            sqlConnection.Open();
            List<MailAccount> mailAccounts = new List<MailAccount>();
            SqlCommand command = new SqlCommand(que, sqlConnection);
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        MailAccount mailAccount =
                            new MailAccount(reader.GetInt32(0),
                                reader.GetString(1),
                                reader.GetString(2),
                                reader.GetString(3),
                                reader.GetString(4),
                                reader.GetSqlString(5).IsNull ? null : reader.GetString(5));
                        mailAccounts.Add(mailAccount);
                    }
                }
            }
            return mailAccounts.ToArray();
        }

        public MailAccount[] GetMailServers()
        {
            SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
            string que = "SELECT * FROM msdb.dbo.sysmail_server";
            sqlConnection.Open();
            List<MailAccount> mailAccounts = new List<MailAccount>();
            SqlCommand command = new SqlCommand(que, sqlConnection);
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        MailAccount mailAccount =
                            new MailAccount(reader.GetInt32(0),
                                reader.GetString(1),
                                reader.GetString(2),
                                reader.GetString(3),
                                reader.GetString(4),
                                reader.GetString(5));
                        mailAccounts.Add(mailAccount);
                    }
                }
            }
            return mailAccounts.ToArray();
        }

        public MailProfile[] GetMailProfiles()
        {
            SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
            string que = "SELECT * FROM msdb.dbo.sysmail_profile";
            sqlConnection.Open();
            List<MailProfile> mailProfiles = new List<MailProfile>();
            SqlCommand command = new SqlCommand(que, sqlConnection);
            {
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        MailProfile mailProfile =
                            new MailProfile(reader.GetInt32(0),
                                reader.GetString(1),
                                reader.GetSqlString(2).IsNull ? null : reader.GetString(2));
                        mailProfiles.Add(mailProfile);
                    }
                }
            }
            return mailProfiles.ToArray();
        }

        public void exec_Querey(string que)
        {
            SqlConnection sqlConnection = new SqlConnection(ConnStringClass.connStr);
            sqlConnection.Open();
            SqlCommand command = new SqlCommand(que, sqlConnection);
            {
                command.ExecuteReader();
            }
            sqlConnection.Close();
        }
    }
}
