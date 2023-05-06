#!/bin/bash

readonly PASSWORD_FILE="password.txt.gpg"
readonly TEMP_PASSWORD_FILE="temp_password.txt"
readonly KEY_NAME="mykey@sample.com"

function request_user_input() {
    read -p "サービス名を入力してください：" service_name
    read -p "ユーザー名を入力してください：" user_name
    read -p "パスワードを入力してください：" password
}

function add_password() {
    if [ -e $PASSWORD_FILE ]; then
        gpg --decrypt $PASSWORD_FILE > $TEMP_PASSWORD_FILE
    fi

    request_user_input
    echo "$service_name:$user_name:$password" >> $TEMP_PASSWORD_FILE

    gpg --encrypt --recipient $KEY_NAME --output $PASSWORD_FILE $TEMP_PASSWORD_FILE
    rm $TEMP_PASSWORD_FILE
}

function get_password() {
    gpg -o $TEMP_PASSWORD_FILE -d $PASSWORD_FILE

    read -p "サービス名を入力してください：" service_name
    result=$(grep "^$service_name:" $TEMP_PASSWORD_FILE)

    if [ -n "$result" ]; then

      IFS=":"
      arr=($result)

      echo "サービス名：${arr[0]}"
      echo "ユーザー名：${arr[1]}"
      echo "パスワード：${arr[2]}"

    else
      echo "そのサービスは登録されていません。"
    fi

    rm $TEMP_PASSWORD_FILE
}

function show_menu() {
    echo "入力に誤りがあります。 Add Password/Get Password/Exit から入力してください。"
}

echo "パスワードマネージャーへようこそ！"

until [ "${input,,}" = "exit" ]; do
    read -p "次の選択肢から入力してください(Add Password/Get Password/Exit)：" input

    case "${input,,}" in
      "add password")
        add_password
        ;;
      "get password")
        get_password
        ;;
      "exit")
        echo "Thank you"
        break
        ;;
    *)
        show_menu
        ;;
    esac
done
