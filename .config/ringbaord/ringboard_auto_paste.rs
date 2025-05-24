use std::io::{self, Write};
use std::process::{exit, Command};
use std::thread::sleep;
use std::time::Duration;

// ringboard-egui の実行コマンドを指定してください
const RINGBOARD_COMMAND: &str = "ringboard-egui";
// ringboard のソースディレクトリ（cargo run 用）
const RINGBOARD_DIR: &str = "/home/senken/senkenn/clipboard-history/egui";

fn is_process_running(pid: i32) -> bool {
    if pid <= 0 {
        return false;
    }
    match Command::new("ps")
        .args(&["-p", &pid.to_string(), "-o", "pid="])
        .output()
    {
        Ok(output) => {
            let stdout = String::from_utf8_lossy(&output.stdout);
            stdout.split_whitespace().any(|p| p == pid.to_string())
        }
        Err(e) => {
            eprintln!("プロセス実行確認中にエラーが発生しました: {}", e);
            false
        }
    }
}

fn get_ringboard_pid() -> Option<i32> {
    match Command::new("pgrep")
        .args(&["-f", RINGBOARD_COMMAND])
        .output()
    {
        Ok(output) => {
            let stdout = String::from_utf8_lossy(&output.stdout);
            stdout.lines().next().and_then(|l| l.trim().parse().ok())
        }
        Err(e) => {
            eprintln!("ringboard-egui のPID取得中にエラーが発生しました: {}", e);
            None
        }
    }
}

fn simulate_ctrl_v() -> bool {
    // xdotool がインストールされているか確認
    if !Command::new("which")
        .arg("xdotool")
        .status()
        .map(|s| s.success())
        .unwrap_or(false)
    {
        eprintln!("エラー: xdotool がインストールされていません。");
        eprintln!("Linuxの場合、以下のコマンドでインストールできます:");
        eprintln!("  sudo apt update && sudo apt install xdotool  (Debian/Ubuntu系)");
        eprintln!("  sudo dnf install xdotool  (Fedora系)");
        eprintln!("  sudo pacman -S xdotool  (Arch Linux系)");
        return false;
    }
    match Command::new("xdotool").args(&["key", "control+v"]).status() {
        Ok(status) if status.success() => {
            println!("Ctrl+V をシミュレートしました。");
            true
        }
        Ok(status) => {
            eprintln!(
                "xdotool の実行中にエラーが発生しました。ステータス: {:?}",
                status
            );
            false
        }
        Err(e) => {
            eprintln!("Ctrl+V シミュレーション中にエラーが発生しました: {}", e);
            false
        }
    }
}

fn main() {
    println!("{} を起動します...", RINGBOARD_COMMAND);
    let status = Command::new("cargo")
        .args(&["run", "--release"])
        .current_dir(RINGBOARD_DIR)
        .status();

    match status {
        Ok(s) => {
            println!(
                "{} が終了しました。exit code={}",
                RINGBOARD_COMMAND,
                s.code().unwrap_or(-1)
            );
            sleep(Duration::from_millis(100));
            if s.success() {
                simulate_ctrl_v();
                exit(0);
            } else {
                eprintln!("exit code が 0 ではないため、ペーストはスキップします。");
                exit(s.code().unwrap_or(1));
            }
        }
        Err(e) => {
            eprintln!(
                "{} の実行中にエラーが発生しました: {}",
                RINGBOARD_COMMAND, e
            );
            exit(1);
        }
    }
}
