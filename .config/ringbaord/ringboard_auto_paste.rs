use std::io::{self, Write};
use std::process::{exit, Command};
use std::thread::sleep;
use std::time::Duration;

// Specify the command for ringboard-egui execution
const RINGBOARD_COMMAND: &str = "ringboard-egui";
// Directory of ringboard source (for `cargo run`)
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
            eprintln!("Error checking process status: {}", e);
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
            eprintln!("Error obtaining ringboard-egui PID: {}", e);
            None
        }
    }
}

fn simulate_ctrl_v() -> bool {
    // Check if `xdotool` is installed
    if !Command::new("which")
        .arg("xdotool")
        .status()
        .map(|s| s.success())
        .unwrap_or(false)
    {
        eprintln!("Error: `xdotool` is not installed.");
        eprintln!("On Linux, install it using:");
        eprintln!("  sudo apt update && sudo apt install xdotool  (Debian/Ubuntu)");
        eprintln!("  sudo dnf install xdotool  (Fedora)");
        eprintln!("  sudo pacman -S xdotool  (Arch Linux)");
        return false;
    }
    match Command::new("xdotool").args(&["key", "control+v"]).status() {
        Ok(status) if status.success() => {
            println!("Simulated Ctrl+V successfully.");
            true
        }
        Ok(status) => {
            eprintln!("Error executing `xdotool`. Status: {:?}", status);
            false
        }
        Err(e) => {
            eprintln!("Error during Ctrl+V simulation: {}", e);
            false
        }
    }
}

fn main() {
    println!("Launching {}...", RINGBOARD_COMMAND);
    let status = Command::new("cargo")
        .args(&["run", "--release"])
        .current_dir(RINGBOARD_DIR)
        .status();

    match status {
        Ok(s) => {
            println!(
                "{} has exited. exit code={}",
                RINGBOARD_COMMAND,
                s.code().unwrap_or(-1)
            );
            sleep(Duration::from_millis(100));
            if s.success() {
                simulate_ctrl_v();
                exit(0);
            } else {
                eprintln!("Non-zero exit code; skipping paste.");
                exit(s.code().unwrap_or(1));
            }
        }
        Err(e) => {
            eprintln!("Error running {}: {}", RINGBOARD_COMMAND, e);
            exit(1);
        }
    }
}
