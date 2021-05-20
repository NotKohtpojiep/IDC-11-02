using System;
using System.Collections.Generic;
using System.IO;
using System.Windows;
using System.Windows.Forms;
using MigrationFromWinForms.Common;
using MessageBox = System.Windows.MessageBox;

namespace MigrationFromWinForms.Standart.DatabaseTasks
{
    /// <summary>
    /// Логика взаимодействия для BackupSetupWindow.xaml
    /// </summary>
    public partial class BackupSetupWindow : Window
    {
        FolderBrowserDialog dialog { get; set; }

        public bool ConfigureTask { get; set; }
        private bool validMaster;
        private bool validTran;
        private bool validDiff;
        private bool validFull;
        private bool validMSDB;
        private UserData ud;

        public BackupSetupWindow()
        {
            InitializeComponent();

            dialog = new FolderBrowserDialog();

            dialog.Description = "Укажите путь до папки хранения копий";
            dialog.ShowNewFolderButton = true;
            dialog.RootFolder = Environment.SpecialFolder.MyComputer;

            ud = UserData.Load(ClassConstHelper.fileConfigsStandart);
            if (ud.Paths != null)
            {
                tbMaster.Text = ud.Paths["masterPath"];
                tbMSDB.Text = ud.Paths["msdbPath"];
                tbDiff.Text = ud.Paths["diffPath"];
                tbTran.Text = ud.Paths["trarPath"];
                tbFull.Text = ud.Paths["fullPath"];

                validDiff = validFull = validMSDB = validMaster = validTran = true;
            }
        }

        private void btClose_Click(object sender, EventArgs e)
        {
            ConfigureTask = false;
            Close();
        }

        private void btPathFull_Click(object sender, EventArgs e)
        {
            tbFull.Text = GetPath();
        }

        private string GetPath()
        {
            try
            {
                if (dialog.ShowDialog() == System.Windows.Forms.DialogResult.OK)
                {
                    return dialog.SelectedPath;
                }
            }
            catch (Exception exc)
            {
                MessageBox.Show(exc.Message);
            }

            return string.Empty;
        }

        private void btPathDiff_Click(object sender, EventArgs e)
        {
            tbDiff.Text = GetPath();
        }

        private void btPathTran_Click(object sender, EventArgs e)
        {
            tbTran.Text = GetPath();
        }

        private void btPathMaster_Click(object sender, EventArgs e)
        {
            tbMaster.Text = GetPath();
        }

        private void btPathMSDB_Click(object sender, EventArgs e)
        {
            tbMSDB.Text = GetPath();
        }

        private void btAdd_Click(object sender, EventArgs e)
        {
            if (validDiff && validFull && validMSDB && validMaster && validTran)
            {

                if (SetupPath(tbFull.Text, ref BackupFolders.pathFull)) return;

                if (SetupPath(tbDiff.Text, ref BackupFolders.pathDifferent)) return;


                if (SetupPath(tbTran.Text, ref BackupFolders.pathTransaction)) return;

                if (SetupPath(tbMaster.Text, ref BackupFolders.pathMasterDB)) return;

                if (SetupPath(tbMSDB.Text, ref BackupFolders.pathMSDB)) return;

                Dictionary<string, string> paths = new Dictionary<string, string>();
                paths.Add("masterPath", tbMaster.Text);
                paths.Add("msdbPath", tbMSDB.Text);
                paths.Add("diffPath", tbDiff.Text);
                paths.Add("trarPath", tbTran.Text);
                paths.Add("fullPath", tbFull.Text);

                ud.SetPaths(paths);
                ud.Save(ClassConstHelper.fileConfigsStandart);

                ConfigureTask = true;
                Close();
            }
            else
            {
                MessageBox.Show("Заполните все поля");
            }
        }

        private bool SetupPath(string userPath, ref string programPath)
        {
            if (!CheckPath(userPath))
            {
                MessageBox.Show("Проблема при проверке наличия папок. Операция прервана");
                return true;
            }
            else
            {
                if (userPath.IndexOf(@"\", userPath.Length - 1) > 0)
                    programPath = userPath;
                else
                {
                    programPath = userPath + @"\";
                }
            }
            return false;
        }

        private bool CheckPath(string pathFolder)
        {
            bool returnVal = true;

            try
            {
                if (pathFolder.Length > 210)
                {
                    MessageBox.Show("Слишком большая длинна пути до папки сохранения. Измените путь: \r\n" + pathFolder);
                    return false;
                }


                if (!Directory.Exists(pathFolder))
                {
                    MessageBoxResult dialogResult = MessageBox.Show(
                            "Каталог " + pathFolder + " не существует. Вы хотите его создать?",
                            "Отсутствует каталог", MessageBoxButton.YesNo);
                    if (dialogResult == MessageBoxResult.OK)
                    {
                        Directory.CreateDirectory(pathFolder);
                        MessageBox.Show("Создал");
                    }
                    else if (dialogResult == MessageBoxResult.OK)
                    {
                        MessageBox.Show("Операция отменена");
                        returnVal = false;
                    }

                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка " + ex.Message);
                returnVal = false;
            }

            return returnVal;
        }
    }
}
