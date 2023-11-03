function commit() {
  prefixes=('feat' 'fix' 'docs' 'style' 'refactor' 'perf' 'test' 'bump' 'ci' 'build' 'hotfix', 'breaking')
  descriptions_jp=('新機能' 'バグ修正' 'ドキュメント更新' 'スタイル修正' 'リファクタリング' 'パフォーマンス改善' 'テスト追加/修正' 'ライブラリアップデート' 'CIの設定変更' 'ビルドプロセス' '緊急修正' '破壊的変更')
  local length=${#descriptions_jp[@]}
  echo '以下からコミットタイプを選択してください:'
  for ((i=0; i<length; i++)); do
    echo "$((i+1))) ${descriptions_jp[$i+1]}"
  done

  local prefix_index=0
  while [[ $prefix_index -lt 1 ]] || [[ $prefix_index -gt $length ]]; do
    echo -n '番号で選択してください: '
    read -r input
    if [[ "$input" =~ ^[0-9]+$ ]] && (( input >= 1 && input <= length )); then
      prefix_index=$input
    else
      echo "無効な入力です。1から$length の番号を入力してください。"
    fi
  done

  local selected_prefix=${prefixes[$((prefix_index))]}
  echo -n 'コミットメッセージを入力してください: '
  read -r commit_message

  git commit -m "${selected_prefix}: ${commit_message}"
  echo "コミット完了：${selected_prefix}: ${commit_message}"
}
