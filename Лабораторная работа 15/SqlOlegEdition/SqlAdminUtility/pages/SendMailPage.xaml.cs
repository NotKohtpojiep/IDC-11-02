using System;
using System.Windows;
using System.Windows.Controls;
using SqlAdminUtility.classes;

namespace SqlAdminUtility.pages
{
    /// <summary>
    /// Логика взаимодействия для SendMailPage.xaml
    /// </summary>
    public partial class SendMailPage : Page
    {
        SqlServerActions actions = new SqlServerActions();
        public SendMailPage()
        {
            InitializeComponent();
            MailProfiles_CB.ItemsSource = actions.GetMailProfiles();
        }

        private void SendMail(MailProfile mailProfile, string recipients, string subject, string body = null, string query = null)
        {
            string sendDbMail =
                $"EXEC msdb.dbo.sp_send_dbmail @profile_name = '{mailProfile.Name}',@recipients = '{recipients}',@subject = N'{subject}'";
            if (body != null)
                sendDbMail += $", @body = N'{body}'";
            if (query != null)
                sendDbMail += $", @query = '{query}'";

            actions.exec_Querey(sendDbMail);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            string recipients = Recipients_TB.Text;
            string subject = Subject_TB.Text;
            string body = Body_TB.Text;
            if (string.IsNullOrWhiteSpace(recipients) || string.IsNullOrWhiteSpace(subject))
            {
                MessageBox.Show("Ну ты внатуре прикалываешься??");
                return;
            }

            if (string.IsNullOrWhiteSpace(body))
                body = null;

            try
            {
                MailProfile mailProfile = MailProfiles_CB.SelectedItem as MailProfile;
                SendMail(mailProfile, recipients, subject, body);
            }
            catch (Exception exception)
            {
                MessageBox.Show("Что-то пошло не так");
                return;
            }
            
            MessageBox.Show("Сообщение отправлено в очередь.");
            Navigation.main.Navigate(new MailPage());
        }
    }
}
