// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery.jscroll.min.js
//= require bootstrap-sprockets

// posts.imagesメイン写真プレビュー
 $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#user_img").change(function(){
        readURL(this);
    });
  });



//   posts/material/material form追加
$(function(){
  function buildField(index) {  // 追加するフォームのｈｔｍｌを用意
    const html = `<span class="js-material-group" data-index="${index}">
                  <spam class="material_name"><input placeholder="材料or道具..." size="12" class="text-form" type="text" name="post[materials_attributes][${index}][material_name]" id="post_materials_attributes_${index}_material_name"></spam>
                  <spam class="material_shop"><input placeholder="購入先..." size="12" class="text-form" type="text" name="post[materials_attributes][${index}][shop]" id="post_materials_attributes_${index}_shop"></spam>
                  <spam class="delete-form-btn">削除</spam>
                </span><br>`;
    return html;
  }

  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9] // 追加するフォームのインデックス番号を用意
  var lastIndex = $(".js-material-group:last").data("index"); // 編集フォーム用（すでにデータがある分のインデックス番号が何か取得しておく）
  fileIndex.splice(0, lastIndex); // 編集フォーム用（データがある分のインデックスをfileIndexから除いておく）
  let fileCount = $(".hidden-destroy").length; // 編集フォーム用（データがある分のフォームの数を取得する）
  let displayCount = $(".js-material-group").length // 見えているフォームの数を取得する
  $(".hidden-destroy").hide(); // 編集フォーム用（削除用のチェックボックスを非表示にしておく）
  if (fileIndex.length == 0) $(".add-form-btn").css("display","none"); // 編集フォーム用（フォームが５つある場合は追加ボタンを非表示にしておく）

  $(".add-form-btn").on("click", function() { // 追加ボタンクリックでイベント発
    $(".material-area").append(buildField(fileIndex[0])); // fileIndexの一番小さい数字をインデックス番号に使ってフォームを作成
    fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
    if (fileIndex.length == 0) $(".add-form-btn").css("display","none"); // フォームが５つになったら追加ボタンを非表示にする
    displayCount += 1; // 見えているフォームの数をカウントアップしておく
  })

  $(".material-area").on("click", ".delete-form-btn", function() { // 削除ボタンクリックでイベント発火
    $(".add-form-btn").css("display","block"); // どの道フォームは一つ消えるので、追加ボタンを必ず表示させるようにしておく
    const targetIndex = $(this).parent().data("index") // クリックした箇所のインデックス番号を取得
    //alert("消すと元に戻りません")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`); // 編集用（クリックした箇所のチェックボックスを取得）
    var lastIndex = $(".js-material-group:last").data("index"); // フォームの最後に使われているインデックス番号を取得
    displayCount -= 1; // 表示されているフォーム数を一つカウントダウン
    if (targetIndex < fileCount) { // 編集用（チェックボックスがある場合の処理）
      $(this).parent().css("display","none") // フォームを非表示にする
      hiddenCheck.prop("checked", true); // チェックボックスにチェックを入れる
    } else { // チェックボックスがない場合の処理
      $(this).parent().remove(); // フォームを削除する
    }
    // ↓はfileIndex（フォーム追加ように用意してある数字の配列）の処理
    if (fileIndex.length >= 1) { // 数字が一つでも残っている場合
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1); // 配列の一番右側にある数字に１を足した数字を追加
    } else {
      fileIndex.push(lastIndex + 1); // フォームの最後の数字に1を足した数字を追加
    }
    // ↓はフォームがなくならないための処理
    if (displayCount == 0) { // 見えてるフォームの数が0になったとき
      $(".material-area").append(buildField(fileIndex[0] - 1)); // fileIndexの一番左側にある数字から１引いた数字でフォームを作成
      fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
      displayCount += 1; // 見えているフォームの数をカウントアップしておく
    }
  })
})

//works.imagesプレビュー
function imgClick(obj){
  var inp = $(obj).parent().children("input");
  console.log(inp);
  inp.click();
}
   $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          console.log($(input).parent().children("img"));
          $(input).parent().children("img").attr('src', e.target.result);

          //$('#work_img_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $(document).on('change', '.work_img_field', function(){
        readURL(this);
    });
  });

  // posts/index/works form追加
  $(function(){
  function buildField(index) {  // 追加するフォームのｈｔｍｌを用意
    const html = `<div class="js-work-group" date-index="${index}">
                  <span>〖${index}〗</span>
                  <spam class="delete-work-btn">削除</spam><br>
                  <input id="works_img${index}" class="work_img_field" style="display:none;" date="{:index=>&quot;0&quot;}" type="file" name="post[works_attributes][${index}][images]">
                  <img onclick="imgClick(this)" id="work_img_prev" class="img-size" src="/assets/sample-92269c50190175d7b24c2a2f9c64501c92b4318bab6bcfd32da727530e422086.jpg" width="115" height="75">
                  <br>
                  <textarea class="works_detail text-form" placeholder="説明をここに..." name="post[works_attributes][${index}][detail]" id="post_works_attributes_${index}_detail" cols="14" rows="5"></textarea>
                </div>`;
    return html;
  }

  let fileIndex = [2, 3, 4, 5, 6, 7, 8] // 追加するフォームのインデックス番号を用意
  var lastIndex = $(".js-work-group:last").data("index"); // 編集フォーム用（すでにデータがある分のインデックス番号が何か取得しておく）
  fileIndex.splice(0, lastIndex); // 編集フォーム用（データがある分のインデックスをfileIndexから除いておく）
  let fileCount = $(".hidden-destroy").length; // 編集フォーム用（データがある分のフォームの数を取得する）
  let displayCount = $(".js-work-group").length // 見えているフォームの数を取得する
  $(".hidden-destroy").hide(); // 編集フォーム用（削除用のチェックボックスを非表示にしておく）
  if (fileIndex.length == 0) $(".add-form-btn-work").css("display","none"); // 編集フォーム用（フォームが５つある場合は追加ボタンを非表示にしておく）

  $(".add-form-btn-work").on("click", function() { // 追加ボタンクリックでイベント発
    $(".work-area").append(buildField(fileIndex[0])); // fileIndexの一番小さい数字をインデックス番号に使ってフォームを作成
    fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
    if (fileIndex.length == 0) $(".add-form-btn-work").css("display","none"); // フォームが５つになったら追加ボタンを非表示にする
    displayCount += 1; // 見えているフォームの数をカウントアップしておく
  })

  $(".work-area").on("click", ".delete-work-btn", function() { // 削除ボタンクリックでイベント発火
    $(".add-form-btn-work").css("display","block"); // どの道フォームは一つ消えるので、追加ボタンを必ず表示させるようにしておく
    const targetIndex = $(this).parent().data("index") // クリックした箇所のインデックス番号を取得
    // alert("消すと元に戻りません")
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`); // 編集用（クリックした箇所のチェックボックスを取得）
    var lastIndex = $(".js-work-group:last").data("index"); // フォームの最後に使われているインデックス番号を取得
    displayCount -= 1; // 表示されているフォーム数を一つカウントダウン
    if (targetIndex < fileCount) { // 編集用（チェックボックスがある場合の処理）
      $(this).parent().css("display","none") // フォームを非表示にする
      hiddenCheck.prop("checked", true); // チェックボックスにチェックを入れる
    } else { // チェックボックスがない場合の処理
      $(this).parent().remove(); // フォームを削除する
    }
    // ↓はfileIndex（フォーム追加ように用意してある数字の配列）の処理
    if (fileIndex.length >= 1) { // 数字が一つでも残っている場合
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1); // 配列の一番右側にある数字に１を足した数字を追加
    } else {
      fileIndex.push(lastIndex + 1); // フォームの最後の数字に1を足した数字を追加
    }
    // ↓はフォームがなくならないための処理
    if (displayCount == 0) { // 見えてるフォームの数が0になったとき
      $(".work-area").append(buildField(fileIndex[0] - 1)); // fileIndexの一番左側にある数字から１引いた数字でフォームを作成
      fileIndex.shift(); // fileIndexの一番小さい数字を取り除く
      displayCount += 1; // 見えているフォームの数をカウントアップしておく
    }
  })
})

// 退会モーダルダイアログの呼び出し
$( function() {
	$('#quitbutton').click( function () {
		$('#quitmodal').modal();
	});
});

// プロフィール写真変更プレビュー
$(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
    $('#thumb_prev').attr('src', e.target.result);
        }
        reader.readAsDataURL(input.files[0]);
        }
    }
    $("#thumb_img").change(function(){
        readURL(this);
    });
  });

  // お問合せモーダルウィンドウ
$( function() {
	$('#contact-button').click( function () {
		$('#contact-modal').modal();
	});
});

// フォロー申請モーダルウィンドウ
$( function() {
	$('#request-button').click( function () {
		$('#request-modal').modal();
	});
});

// 無限スクロール
$(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
          $('.jscroll').jscroll({
            contentSelector: '.posts-list',
            nextSelector: 'span.next:last a'
          });
    }
});