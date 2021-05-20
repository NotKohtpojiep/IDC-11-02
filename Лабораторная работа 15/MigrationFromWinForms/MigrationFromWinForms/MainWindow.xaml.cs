using System.Windows;
using AutoCreateBackupPlan.Express;
using MigrationFromWinForms.Standart;

namespace MigrationFromWinForms
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void btExpress_Click(object sender, RoutedEventArgs e)
        {
            frmExpress window = new frmExpress();
            window.ShowDialog();
        }

        private void btStandart_Click(object sender, RoutedEventArgs e)
        {
            StandartWindow window = new StandartWindow();
            window.ShowDialog();
        }
    }
}
