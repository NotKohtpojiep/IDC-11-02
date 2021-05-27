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
    /// Логика взаимодействия для DeleteTaskPage.xaml
    /// </summary>
    public partial class DeleteTaskPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public DeleteTaskPage()
        {
            InitializeComponent();
            Tasks_CB.ItemsSource = actions.GetAgentJobs();
            Tasks_CB.SelectedIndex = 0;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                string query = $"USE msdb EXEC dbo.sp_delete_job @job_name = '{((JobManager)Tasks_CB.SelectedValue).Name}'";
                actions.exec_Querey(query);
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                return;
            }

            Tasks_CB.ItemsSource = actions.GetAgentJobs();
            Tasks_CB.SelectedIndex = 0;
            MessageBox.Show("Удаление успешно!");
        }

        private void BackButton_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.GoBack();
        }
    }
}
