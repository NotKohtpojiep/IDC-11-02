using System;
using System.Windows;
using System.Windows.Controls;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для CreateTaskPage.xaml
    /// </summary>
    public partial class CreateTaskPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public CreateTaskPage()
        {
            InitializeComponent();
        }

        private void CreateTask(JobManager jobManager, string command, JobSchedule jobSchedule)
        {
            string addJobQuery =
                "USE msdb " +
                "EXEC dbo.sp_add_job " +
                $"@job_name = N'{jobManager.Name}'," +
                $"@description = '{jobManager.Description}' ";

            if (jobManager.EmailNotify)
                addJobQuery +=
                    ", @notify_level_email = 1, " +
                    "@notify_email_operator_name = N'Admin Mailer' ";
            actions.exec_Querey(addJobQuery);

            string addJobstepQuery =
                "USE msdb " +
                "EXEC sp_add_jobstep  " +
                $"@job_name = N'{jobManager.Name}',  " +
                "@step_name = N'Do something',  " +
                "@subsystem = N'TSQL',  " +
                $"@command = '{command}',   " +
                "@retry_attempts = 5,  " +
                "@retry_interval = 5 ";
            actions.exec_Querey(addJobstepQuery);

            string addScheduleQuery =
                "USE msdb " +
                "EXEC dbo.sp_add_schedule  " +
                $"@schedule_name = N'{jobSchedule.Name}',  " +
                $"@freq_type = {jobSchedule.FreqType},  " +
                $"@active_start_time = {jobSchedule.ActiveStartTime} ";
            actions.exec_Querey(addScheduleQuery);

            string attachScheduleQuery =
                "USE msdb " +
                "EXEC sp_attach_schedule  " +
                $"@job_name = N'{jobManager.Name}',  " +
                $"@schedule_name = N'{jobSchedule.Name}'  ";
            actions.exec_Querey(attachScheduleQuery);

            string addJobServerQuery =
                "USE msdb " +
                "EXEC dbo.sp_add_jobserver  " +
                $"@job_name = N'{jobManager.Name}' ";
            actions.exec_Querey(addJobServerQuery);
        }

        private void Button_Click(object sender, System.Windows.RoutedEventArgs e)
        {
            string jobName = JobName_TB.Text;
            string jobDesc = JobDesc_TB.Text;
            string jobCommand = SqlCommand_TB.Text;

            if (string.IsNullOrWhiteSpace(jobName) || string.IsNullOrWhiteSpace(jobCommand))
            {
                MessageBox.Show("Заполни данные");
                return;
            }
            JobManager jobManager = new JobManager(new Guid(), jobName, true, jobDesc, null);

            string jobScheduleName = JobScheduleName_TB.Text;
            int jobFreqType;
            string jobStartTime = StartTime_TB.Text;

            if (string.IsNullOrWhiteSpace(jobScheduleName) || string.IsNullOrWhiteSpace(jobStartTime))
            {
                MessageBox.Show("Заполни данные");
                return;
            }

            if (!int.TryParse(FreqType_TB.Text, out jobFreqType))
            {
                MessageBox.Show("Неккоректная частота");
                return;
            }

            int temp;
            if (!int.TryParse(jobStartTime, out temp) || jobStartTime.Length != 6)
            {
                MessageBox.Show("Неправильная форма для старта времени");
                return;
            }
            JobSchedule jobSchedule = new JobSchedule(jobScheduleName, jobFreqType, jobStartTime);

            try
            {
                CreateTask(jobManager, jobCommand, jobSchedule);
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
                return;
            }
            MessageBox.Show("Задача создана успешно!");
        }

        private void ButtonBase_OnClick(object sender, RoutedEventArgs e)
        {
            Navigation.main.GoBack();
        }
    }
}
