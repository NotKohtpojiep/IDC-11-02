using System;
using System.Data;
using System.Data.SqlClient;
using System.Windows;
using System.Windows.Forms.Primitives.Resources;
using AutoCreateBackupPlan.Standart.DatabaseMail;
using log4net;
using MigrationFromWinForms.Standart.DatabaseMail;
using MigrationFromWinForms.Standart.DatabaseTasks;
using MigrationFromWinForms.Standart.DatabaseTasks.BackupSystemTasks;
using MigrationFromWinForms.Standart.DatabaseTasks.BackUpTasks;
using MigrationFromWinForms.Standart.DatabaseTasks.SystemTask;

namespace MigrationFromWinForms.Standart
{
    /// <summary>
    /// Логика взаимодействия для StandartWindow.xaml
    /// </summary>
    public partial class StandartWindow : Window
    {
        private SqlConnection sqlConnection1 { get; set; }
        public StandartWindow()
        {
            InitializeComponent();

        }
        private static readonly ILog log = LogManager.GetLogger(typeof(StandartWindow));


        private void frmMain_Load(object sender, EventArgs e)
        {
            SetAddressWindow frm = new SetAddressWindow();
            frm.ShowDialog();

            if (frm.ConnectReady)
            {
                try
                {

                    sqlConnection1 = new SqlConnection(
                        string.Format(@"Data Source={0};User ID={1};Password={2};",
                                      ClassConstHelper.serverSQL,
                                      frm.UserLogin,
                                      frm.UserPass));

                    sqlConnection1.Open();
                }
                catch (Exception ex)
                {

                    MessageBox.Show(ex.Message);
                    frmMain_Load(this, e);
                }
            }
            else
            {
                Close();
            }
        }

        private void btCreateNotify_Click(object sender, EventArgs e)
        {

            if (sqlConnection1.State == ConnectionState.Open)
            {
                frmEmail frm = new frmEmail();
                frm.ShowDialog();

                if (frm.EmailAdministrator)
                {
                    TaskCheckDB task = new TaskCheckDB(Properties.Resources.Msg_Query_Part1_TaskCheckDB,
                        Properties.Resources.Msg_Query_Part2_TaskCheckDB,
                                                       ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Part3_TaskCheckDB,
                                                       ClassConstHelper.DB);
                    task.Create(sqlConnection1, "TaskCheckDB");



                    TaskFileStatistic taskFile = new TaskFileStatistic(Properties.Resources.Msg_Query_Part1_Staticstic,
                        Properties.Resources.Msg_Query_Part2_Staticstic,
                                                                       ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Part3_Staticstic,
                                                                       ClassConstHelper.DB);
                    taskFile.Create(sqlConnection1, "TaskFileStatistic");

                    rtbLog.AppendText(Properties.Resources.Msg_ReadyAddionalTask);
                }
                else
                {
                    log.Debug(Properties.Resources.Msg_NotExistEmailAdmin);
                }
            }

        }

        private void btInstall_Click(object sender, EventArgs e)
        {
            if (sqlConnection1.State == ConnectionState.Open)
            {

                frmBackupSetup frmBacksetup = new frmBackupSetup();
                frmBacksetup.ShowDialog();
                if (frmBacksetup.ConfigureTask)
                {

                    SQLHelper.ExecuteMyQuery(sqlConnection1, string.Format(Properties.Resources.QueryStandart_ChangeRecoveryModel, ClassConstHelper.DB));

                    using (SqlDataReader reader = SQLHelper.GetDataReader(sqlConnection1,
                                                                       string.Format(Properties.Resources.QueryStandart_CheckExistBackup, ClassConstHelper.DB)))
                    {
                        if (!reader.HasRows)
                            MessageBox.Show(Properties.Resources.Msg_NeedManualBackup);
                    }


                    TaskBackUpTransaction task = new TaskBackUpTransaction(Properties.Resources.Msg_Query_Part1_Transaction,
                        Properties.Resources.Msg_Query_Part2_Transaction,
                     ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Copy,
                     ClassConstHelper.DB, BackupFolders.pathTransaction);
                    task.Create(sqlConnection1, "TaskBackUpTransaction");

                    TaskBackupDifferent taskDiff = new TaskBackupDifferent(Properties.Resources.Msg_Query_Part1_Diff,
                        Properties.Resources.Msg_Query_Part2_Diff,
                         ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Copy,
                         ClassConstHelper.DB, BackupFolders.pathDifferent);
                    taskDiff.Create(sqlConnection1, "TaskBackupDifferent");

                    TaskBackupFull taskFull = new TaskBackupFull(Properties.Resources.Msg_Query_Part1_Full,
                        Properties.Resources.Msg_Query_Part2_Full,
                          ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Copy,
                         ClassConstHelper.DB, BackupFolders.pathFull);
                    taskFull.Create(sqlConnection1, "TaskBackupFull");

                    rtbLog.AppendText(Properties.Resources.Msg_JobBackupReady);



                    TaskBackupMaster taskMaster = new TaskBackupMaster(Properties.Resources.Msg_Query_Part1_Master,
                        Properties.Resources.Msg_Query_Part2_Master,
                           ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Copy,
                           "master", BackupFolders.pathMasterDB);
                    taskMaster.Create(sqlConnection1, "TaskBackupMaster");

                    TaskBackupMsdb taskMSDB = new TaskBackupMsdb(Properties.Resources.Msg_Query_Part1_MSDB,
                        Properties.Resources.Msg_Query_Part2_MSDB,
                       ClassConstHelper.serverSQL,
                        Properties.Resources.Msg_Query_Copy,
                       "msdb", BackupFolders.pathMSDB);
                    taskMSDB.Create(sqlConnection1, "TaskBackupMsdb");

                    rtbLog.AppendText(Properties.Resources.Msg_BackupSystemDBReady);
                }


            }


        }

        private void btDelete_Click(object sender, EventArgs e)
        {
            if (sqlConnection1.State == ConnectionState.Open)
            {
                rtbLog.Text = string.Empty;
                string sqlDelete = Properties.Resources.QueryStandart_DeleteJobs;
                SQLHelper.ExecuteMyQuery(sqlConnection1, sqlDelete);
                rtbLog.AppendText(Properties.Resources.Msg_DeletedJobs);

                string deleteDatabaseEmailConfigs = string.Format(Properties.Resources.QueryStandart_DeleteProfilesDBMail,
                                          Properties.Resources.Msg_Query_Account,
                                          Properties.Resources.Msg_Query_OperatorName,
                                          Properties.Resources.Msg_Query_Profile);

                SQLHelper.ExecuteMyQuery(sqlConnection1, deleteDatabaseEmailConfigs);
                rtbLog.AppendText(Properties.Resources.Msg_Delete_ConfigDBMail);

            }
        }

        private void btClose_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btSetupDatabaseMail_Click(object sender, EventArgs e)
        {
            if (sqlConnection1.State == ConnectionState.Open)
            {

                frmProfile frm = new frmProfile();
                frm.ShowDialog();

                if (frm.CreateMail)
                {
                    DataBaseOperations.SetDatabaseMailConfig(sqlConnection1);


                    DataBaseOperations.CreateDatabaseMailAddon(sqlConnection1, frm.email_address, frm.mailserver_name,
                                                               frm.username, frm.password, frm.email_operator);

                    rtbLog.AppendText(Properties.Resources.Msg_ConfigDBMail);

                    btCreateNotify.IsEnabled = true;
                    //btSendEmail.Enabled = true; //TODO: сделать модуль, который проверит все основные моменты

                    MessageBox.Show(Properties.Resources.Msg_NeedRebootAgent);
                }
                else
                {
                    log.Debug(Properties.Resources.Msg_NotConfiguretedDBMail);
                }
            }
        }
    }
}
