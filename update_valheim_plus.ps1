# Download latest dotnet/codeformatter release from github
write-host "`n"
write-host "`n"
write-host "`n"
write-host "`n"
Write-Host "              ____   ____      .__  .__           .__          __________.__                                  
              \   \ /   /____  |  | |  |__   ____ |__| _____   \______   \  |  __ __  ______                  
               \   Y   /\__  \ |  | |  |  \_/ __ \|  |/     \   |     ___/  | |  |  \/  ___/                  
                \     /  / __ \|  |_|   Y  \  ___/|  |  Y Y  \  |    |   |  |_|  |  /\___ \                   
                 \___/  (____  /____/___|  /\___  >__|__|_|  /  |____|   |____/____//____  >                  
                             \/          \/     \/         \/                            \/                   
_________ .__  .__               __     ____ ___            .___       __             __                .__   
\_   ___ \|  | |__| ____   _____/  |_  |    |   \______   __| _/____ _/  |_  ____   _/  |_  ____   ____ |  |  
/    \  \/|  | |  |/ __ \ /    \   __\ |    |   /\____ \ / __ |\__  \\   __\/ __ \  \   __\/  _ \ /  _ \|  |  
\     \___|  |_|  \  ___/|   |  \  |   |    |  / |  |_> > /_/ | / __ \|  | \  ___/   |  | (  <_> |  <_> )  |__
 \______  /____/__|\___  >___|  /__|   |______/  |   __/\____ |(____  /__|  \___  >  |__|  \____/ \____/|____/
        \/             \/     \/                 |__|        \/     \/          \/                            
"

# Change line 4 to the steam path of Valheim. Likely you will not need to change this value if Valheim is saved

Function Get-Folder($initialDirectory="C:\Program Files (x86)\Steam\steamapps\common\Valheim\")

{
    [System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")|Out-Null

    $foldername = New-Object System.Windows.Forms.FolderBrowserDialog
    $foldername.Description = "Select the destination you would like to update Valheim Plus"
    $foldername.rootfolder = "MyComputer"
    $foldername.SelectedPath = $initialDirectory

    if($foldername.ShowDialog() -eq "OK")
    {
        $folder += $foldername.SelectedPath
    }
    return $folder
}

$destination = Get-Folder

#$destination = "C:\Program Files (x86)\Steam\steamapps\common\Valheim\"
$repo = "valheimPlus/ValheimPlus"
$file = "WindowsClient.zip"


$releases = "https://api.github.com/repos/$repo/releases"

Write-Host Determining latest Valheim Plus release
$tag = (Invoke-WebRequest -UseBasicParsing $releases | ConvertFrom-Json)[0].tag_name

Write-Host Latest Tag is $tag

$download = "https://github.com/$repo/releases/download/$tag/$file"
$name = $file.Split(".")[0]
$zip = "$name-$tag.zip"
$zipDir = "$name-$tag"

Write-Host Dowloading Valheim Plus @tag Windows Client
Invoke-WebRequest -UseBasicParsing $download -Out $zip

Write-Host Extracting Valhiem Plus $tag files
Expand-Archive $zip -Force

Write-Host Removing old Valheim Plus files

$coreFiles = @(
    'doorstop_config.ini'
    'winhttp.dll'
)

$bepinexPluginsFiles = @(
    '\BepInEx\plugins\ValheimPlus.dll'
)

$bepinexConfigsFiles = @(
    '\BepInEx\config\BepInEx.cfg'
    '\BepInEx\config\valheim_plus.cfg'
)

$doorstopLibsFiles = @(
    '\doorstop_libs\libdoorstop_x64.dylib'
    '\doorstop_libs\libdoorstop_x64.so'
    '\doorstop_libs\libdoorstop_x86.dylib'
    '\doorstop_libs\libdoorstop_x86.so'
)

$bepinexCoreFiles = @(
    '\BepInEx\core\0Harmony.dll'                                                                                                          
    '\BepInEx\core\0Harmony.xml'                                                                                                          
    '\BepInEx\core\0Harmony20.dll'                                                                                                        
    '\BepInEx\core\BepInEx.dll'                                                                                                           
    '\BepInEx\core\BepInEx.Harmony.dll'                                                                                                   
    '\BepInEx\core\BepInEx.Harmony.xml'                                                                                                   
    '\BepInEx\core\BepInEx.Preloader.dll'                                                                                                 
    '\BepInEx\core\BepInEx.Preloader.xml'                                                                                                 
    '\BepInEx\core\BepInEx.xml'                                                                                                           
    '\BepInEx\core\HarmonyXInterop.dll'                                                                                                   
    '\BepInEx\core\Mono.Cecil.dll'                                                                                                        
    '\BepInEx\core\Mono.Cecil.Mdb.dll'                                                                                                    
    '\BepInEx\core\Mono.Cecil.Pdb.dll'                                                                                                    
    '\BepInEx\core\Mono.Cecil.Rocks.dll'                                                                                                  
    '\BepInEx\core\MonoMod.RuntimeDetour.dll'                                                                                             
    '\BepInEx\core\MonoMod.RuntimeDetour.xml'                                                                                             
    '\BepInEx\core\MonoMod.Utils.dll'                                                                                                    
    '\BepInEx\core\MonoMod.Utils.xml' 
)

$unstrippedCorelibFiles = @(
    '\unstripped_corlib\Mono.Posix.dll'                                                                                                        
    '\unstripped_corlib\Mono.Security.dll'                                                                                                     
    '\unstripped_corlib\mscorlib.dll'                                                                                                          
    '\unstripped_corlib\System.Configuration.dll'                                                                                              
    '\unstripped_corlib\System.Core.dll'                                                                                                       
    '\unstripped_corlib\System.dll'                                                                                                            
    '\unstripped_corlib\System.Numerics.dll'                                                                                                   
    '\unstripped_corlib\System.Security.dll'                                                                                                   
    '\unstripped_corlib\System.Xml.dll'                                                                                                        
    '\unstripped_corlib\UnityEngine.AccessibilityModule.dll'                                                                                   
    '\unstripped_corlib\UnityEngine.AIModule.dll'                                                                                              
    '\unstripped_corlib\UnityEngine.AndroidJNIModule.dll'                                                                                      
    '\unstripped_corlib\UnityEngine.AnimationModule.dll'                                                                                       
    '\unstripped_corlib\UnityEngine.ARModule.dll'                                                                                              
    '\unstripped_corlib\UnityEngine.AssetBundleModule.dll'                                                                                     
    '\unstripped_corlib\UnityEngine.AudioModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.ClothModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.ClusterInputModule.dll'                                                                                    
    '\unstripped_corlib\UnityEngine.ClusterRendererModule.dll'                                                                                 
    '\unstripped_corlib\UnityEngine.CoreModule.dll'                                                                                            
    '\unstripped_corlib\UnityEngine.CrashReportingModule.dll'                                                                                  
    '\unstripped_corlib\UnityEngine.DirectorModule.dll'                                                                                        
    '\unstripped_corlib\UnityEngine.dll'                                                                                                       
    '\unstripped_corlib\UnityEngine.DSPGraphModule.dll'                                                                                        
    '\unstripped_corlib\UnityEngine.GameCenterModule.dll'                                                                                      
    '\unstripped_corlib\UnityEngine.GridModule.dll'                                                                                            
    '\unstripped_corlib\UnityEngine.HotReloadModule.dll'                                                                                       
    '\unstripped_corlib\UnityEngine.ImageConversionModule.dll'                                                                                 
    '\unstripped_corlib\UnityEngine.IMGUIModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.InputLegacyModule.dll'                                                                                     
    '\unstripped_corlib\UnityEngine.InputModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.JSONSerializeModule.dll'                                                                                   
    '\unstripped_corlib\UnityEngine.LocalizationModule.dll'                                                                                    
    '\unstripped_corlib\UnityEngine.ParticleSystemModule.dll'                                                                                  
    '\unstripped_corlib\UnityEngine.PerformanceReportingModule.dll'                                                                            
    '\unstripped_corlib\UnityEngine.Physics2DModule.dll'                                                                                       
    '\unstripped_corlib\UnityEngine.PhysicsModule.dll'                                                                                         
    '\unstripped_corlib\UnityEngine.ProfilerModule.dll'                                                                                        
    '\unstripped_corlib\UnityEngine.ScreenCaptureModule.dll'                                                                                   
    '\unstripped_corlib\UnityEngine.SharedInternalsModule.dll'                                                                                 
    '\unstripped_corlib\UnityEngine.SpriteMaskModule.dll'                                                                                      
    '\unstripped_corlib\UnityEngine.SpriteShapeModule.dll'                                                                                     
    '\unstripped_corlib\UnityEngine.StreamingModule.dll'                                                                                       
    '\unstripped_corlib\UnityEngine.SubstanceModule.dll'                                                                                       
    '\unstripped_corlib\UnityEngine.SubsystemsModule.dll'                                                                                      
    '\unstripped_corlib\UnityEngine.TerrainModule.dll'                                                                                         
    '\unstripped_corlib\UnityEngine.TerrainPhysicsModule.dll'                                                                                  
    '\unstripped_corlib\UnityEngine.TextCoreModule.dll'                                                                                        
    '\unstripped_corlib\UnityEngine.TextRenderingModule.dll'                                                                                   
    '\unstripped_corlib\UnityEngine.TilemapModule.dll'                                                                                         
    '\unstripped_corlib\UnityEngine.TLSModule.dll'                                                                                             
    '\unstripped_corlib\UnityEngine.UI.dll'                                                                                                    
    '\unstripped_corlib\UnityEngine.UIElementsModule.dll'                                                                                      
    '\unstripped_corlib\UnityEngine.UIModule.dll'                                                                                              
    '\unstripped_corlib\UnityEngine.UmbraModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.UNETModule.dll'                                                                                            
    '\unstripped_corlib\UnityEngine.UnityAnalyticsModule.dll'                                                                                  
    '\unstripped_corlib\UnityEngine.UnityConnectModule.dll'                                                                                    
    '\unstripped_corlib\UnityEngine.UnityTestProtocolModule.dll'                                                                               
    '\unstripped_corlib\UnityEngine.UnityWebRequestAssetBundleModule.dll'                                                                      
    '\unstripped_corlib\UnityEngine.UnityWebRequestAudioModule.dll'                                                                            
    '\unstripped_corlib\UnityEngine.UnityWebRequestModule.dll'                                                                                 
    '\unstripped_corlib\UnityEngine.UnityWebRequestTextureModule.dll'                                                                          
    '\unstripped_corlib\UnityEngine.UnityWebRequestWWWModule.dll'                                                                              
    '\unstripped_corlib\UnityEngine.VehiclesModule.dll'                                                                                        
    '\unstripped_corlib\UnityEngine.VFXModule.dll'                                                                                             
    '\unstripped_corlib\UnityEngine.VideoModule.dll'                                                                                           
    '\unstripped_corlib\UnityEngine.VRModule.dll'                                                                                              
    '\unstripped_corlib\UnityEngine.WindModule.dll'                                                                                            
    '\unstripped_corlib\UnityEngine.XRModule.dll'
)


function Remove-Object-ValhiemFiles {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string[]]$FileNames
    )

    PROCESS {
        foreach ($file in $FileNames) {
            $oldFileName = Join-Path $destination $file
            if (Test-Path -Path $oldFileName -PathType Leaf) {
                try {
                    Write-Verbose -Message "file $oldFileName was removed"
                    Remove-Item "$oldFileName" -Force
                    Write-Output "file $oldFileName was removed"
                }
                catch { 
                    throw $_.ExceptionMessage
                }
            }
            else {
              Write-Host "Cannot Delete file $oldFileName because it does not exist!"
            }
        }
    }
}

function Add-Object-ValhiemFiles {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipelineByPropertyName)]
        [string[]]$FileNames
    )

    PROCESS {
        foreach ($file in $FileNames) {
            $zipFileName = Join-Path $zipDir $file
            $destFileName = Join-Path $destination $file
            if (Test-Path -Path $zipFileName -PathType Leaf) {
                if (-not(Test-Path -Path $destFileName -PathType Leaf)) {
                    if (Test-Path -Path (Split-Path -Parent $destFileName) -PathType Container) {
                        try {
                            Write-Verbose -Message "file $zipFileName was moved to destination $destFileName"
                            Move-Item "$zipFileName" -Destination $destFileName -force
                            Write-Output "file $zipFileName was moved to destination $destFileName"
                        }
                        catch {
                            throw $_.ExceptionMessage
                        }
                    }
                    else {
                        
                        $i = 5
                        DO {
                            Write-Host ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                            $i = $i - 1
                        } while ( $i -gt 0)

                        try {
                            Write-Host Creating Missing Parent Directories for (Split-Path -Parent $destFileName)
                            mkdir (Split-Path -Parent $destFileName)
                            Write-Verbose -Message "file $zipFileName was moved to destination $destFileName"
                            Move-Item "$zipFileName" -Destination $destFileName -force
                            Write-Output "file $zipFileName was moved to destination $destFileName"
                            Write-Host Valheim Plus $tag files were SUCCESSFULLY copied to $destination
                        }
                        catch {
                            throw $_.ExceptionMessage
                        }
                    
                    }
                }
                else {
                    Write-Host "Cannot move file $zipFileName because it is already in the destination $destFileName"
                }
            }
            else {
                Write-Host "Cannot move file $zipFileName because it is not in the zip folder $zipDir"
            }
        }
    }
}


Remove-Object-ValhiemFiles -FileNames $coreFiles
Remove-Object-ValhiemFiles -FileNames $bepinexPluginsFiles
Remove-Object-ValhiemFiles -FileNames $bepinexConfigsFiles
Remove-Object-ValhiemFiles -FileNames $doorstopLibsFiles
Remove-Object-ValhiemFiles -FileNames $bepinexCoreFiles
Remove-Object-ValhiemFiles -FileNames $unstrippedCorelibFiles

# Moving from temp dir to target dir
Write-Host Copying Valheim Plus $tag files to $destination 

Add-Object-ValhiemFiles -FileNames $coreFiles
Add-Object-ValhiemFiles -FileNames $bepinexPluginsFiles
Add-Object-ValhiemFiles -FileNames $bepinexConfigsFiles
Add-Object-ValhiemFiles -FileNames $doorstopLibsFiles
Add-Object-ValhiemFiles -FileNames $bepinexCoreFiles
Add-Object-ValhiemFiles -FileNames $unstrippedCorelibFiles

$patchers = Join-Path $destination '\BepInEx\patchers'

if (-not(Test-Path -Path $patchers -PathType Container)) {
    try {
        Write-Host "Creating directory $patchers because it does not exist in the destination $destination"
        mkdir $patchers
    }
    catch {
        throw $_.ExceptionMessage
    }
}


Write-Host Cleanup Temporary zip and extract folders
# Removing temp files
Remove-Item $zip -Force
Write-Host zip $zip was removed
Remove-Item $zipDir -Recurse -Force
Write-Host folder $zipDir was removed
write-host "`n"
Write-Host Go have yourself an adventure Viking!
write-host "`n"
Write-Host @"
                      |----.___
                                |----.___',
              ._________________|_______________.
              |####|    |####|    |####|   |####|
              |####|    |####|    |####|    |####|       .
              |####|    |####|    |####|    |####|     /|_____.
  __          |####|    |####|    |####|    |####|   |  o  ..|
(  '.         '####|    '####|    '####|    '####|   '.  .vvv'
 '@ |          |####.    |####.    |####.    |####|    ||
  | |          '####.    '####.    '####.    '####.    ||
 /  |         /####.    /####.    /####.    /####.     |'.
|    |       '####/    '####/    '####/    '####/      |  |
|     |  .  /####|____/####|____/####|____/####|      |    |
|      |//   .#'#. .*'*. .#'#. .*'*. .#'#. .*'*.     |      |
 |     //-...#'#'#-*'*'*-#'#'#-*'*'*-#'#'#-*'*'*-...'        |
  |   //     '#'#' '*'*' '#'#' '*'*' '#'#' '*'*'             |
   './/                                                     .'
   _//'._                                                _.'
  /  /   '----------------------------------------------'
"@

Start-Sleep -s 15
