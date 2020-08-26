$shell = New-Object -ComObject WScript.Shell
$start_time = Get-Date -UFormat %s <# Get the date in MS #>
$current_time = $start_time

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                 = New-Object system.Windows.Forms.Form
$Form.ClientSize      = '350,100'
$Form.text            = "Stay Available"
$Form.TopMost         = $false
$Form.MaximizeBox     = $false
$Form.SizeGripStyle   = "Hide"
$Form.FormBorderStyle = "FixedDialog"

$Button              = New-Object system.Windows.Forms.Button
$Button.text         = "Start"
$Button.width        = 150
$Button.height       = 50
$Button.location     = New-Object System.Drawing.Point(100,25)
$Button.Font         = 'Microsoft Sans Serif,10'
$Button.TabIndex     = 2

   $Button.Add_Click({
        if ($timer.Enabled -eq $true)
            {
            $timer.Stop()
            Kill -processname notepad
            $Button.Text  = "Start"
            }
        else
            {
            Start-Process 'C:\windows\system32\notepad.exe'
            $shell.AppActivate('Untitled')
            $timer.Start()
            $Button.Text = "Stop"
            $start_time = Get-Date -UFormat %s
            }    
   })

$timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 299000
$timer.add_tick({
                 $shell.sendkeys(".")
                 $current_time = Get-Date -UFormat %s
                })



$Form.Controls.Add($Button)

$Form.ShowDialog() | Out-Null
$Form.Dispose()