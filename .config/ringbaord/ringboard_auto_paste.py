import subprocess
import sys
import time


# ringboard-egui の実行パスを指定してください
# 環境によっては 'ringboard-egui' だけで実行できる場合もあります
RINGBOARD_COMMAND = "ringboard-egui"


def is_process_running(pid):
    """指定されたPIDのプロセスが実行中かを確認する"""
    try:
        # PID 0 は常に存在するため除外
        if pid <= 0:
            return False
        # ps コマンドでプロセス情報を取得し、指定したPIDが含まれているか確認
        # -p <PID> で特定のPIDを、-o pid= でPIDのみを出力
        result = subprocess.run(
            ["ps", "-p", str(pid), "-o", "pid="], capture_output=True, text=True
        )
        # 出力されたPIDリストに指定したPIDが含まれていれば実行中
        return str(pid) in result.stdout.strip().split()
    except Exception as e:
        print(f"プロセス実行確認中にエラーが発生しました: {e}", file=sys.stderr)
        return False


def get_ringboard_pid():
    """ringboard-egui のプロセスIDを取得する"""
    try:
        # pgrep コマンドで ringboard-egui のPIDを取得
        # -f オプションでコマンドライン全体を検索対象にする
        result = subprocess.run(
            ["pgrep", "-f", RINGBOARD_COMMAND], capture_output=True, text=True
        )
        pids = result.stdout.strip().splitlines()
        if pids:
            # 複数のPIDが見つかる可能性もあるが、ここでは最初のPIDを使用
            return int(pids[0])
        return None
    except Exception as e:
        print(f"ringboard-egui のPID取得中にエラーが発生しました: {e}", file=sys.stderr)
        return None


def simulate_ctrl_v():
    """xdotool を使って Ctrl+V をシミュレートする"""
    try:
        # xdotool がインストールされているか確認
        if (
            not subprocess.run(["which", "xdotool"], capture_output=True).returncode
            == 0
        ):
            print("エラー: xdotool がインストールされていません。", file=sys.stderr)
            print("Linuxの場合、以下のコマンドでインストールできます:", file=sys.stderr)
            print(
                "  sudo apt update && sudo apt install xdotool  (Debian/Ubuntu系)",
                file=sys.stderr,
            )
            print("  sudo dnf install xdotool  (Fedora系)", file=sys.stderr)
            print("  sudo pacman -S xdotool  (Arch Linux系)", file=sys.stderr)
            return False

        # 現在アクティブなウィンドウに対して Ctrl+V を送信
        subprocess.run(["xdotool", "key", "control+v"])
        print("Ctrl+V をシミュレートしました。")
        return True
    except Exception as e:
        print(f"Ctrl+V シミュレーション中にエラーが発生しました: {e}", file=sys.stderr)
        return False


if __name__ == "__main__":
    # ringboard-egui を起動し、終了後に一度だけペーストを実行
    print(f"{RINGBOARD_COMMAND} を起動します...")
    # result = subprocess.run([RINGBOARD_COMMAND])
    result = subprocess.run(
        ["cd /home/senken/senkenn/clipboard-history/egui && cargo run --release"],
        shell=True,
    )
    print(f"{RINGBOARD_COMMAND} が終了しました。exit code={result.returncode}")
    time.sleep(0.1)
    if result.returncode == 0:
        simulate_ctrl_v()
    else:
        print(
            "exit code が 0 ではないため、ペーストはスキップします。", file=sys.stderr
        )
    sys.exit(result.returncode)
