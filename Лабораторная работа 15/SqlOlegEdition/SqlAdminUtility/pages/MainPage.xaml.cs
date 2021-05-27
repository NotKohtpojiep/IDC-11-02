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
    /// Логика взаимодействия для MainPage.xaml
    /// </summary>
    public partial class MainPage : Page
    {
        public MainPage()
        {
            InitializeComponent();
        }

        private void MailPage_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new MailPage());
        }

        private void BackupPage_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new BackupPage());
        }

        private void CreateTask_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new CreateTaskPage());
        }

        private void DeleteTask_Click(object sender, RoutedEventArgs e)
        {
            Navigation.main.Navigate(new DeleteTaskPage());
        }
    }
}
