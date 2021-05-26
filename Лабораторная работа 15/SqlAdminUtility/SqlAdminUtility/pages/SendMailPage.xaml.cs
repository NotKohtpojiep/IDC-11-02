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

            MailProfile mailProfile = MailProfiles_CB.SelectedItem as MailProfile;
            SendMail(mailProfile, recipients, subject, body);
        }
    }
}
