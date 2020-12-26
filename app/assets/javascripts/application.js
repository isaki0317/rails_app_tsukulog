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
    const html = `<div class="js-material-group" data-index="${index}">
                  <span class="material_name"><input placeholder="材料or道具..." class="text-form material_name-form" type="text" name="post[materials_attributes][${index}][material_name]" id="post_materials_attributes_${index}_material_name"></span>
                  <span class="material_shop"><input placeholder="購入先..." class="text-form material_shop-form" type="text" name="post[materials_attributes][${index}][shop]" id="post_materials_attributes_${index}_shop"></span>
                  <span class="delete-form-btn">削除</span>
                </div>`;
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

// フォーム削除時に番号再発行
// $( function() {
//   var i = 0;
//   $('.delete-work-btn').on('click', function(){
//     i += 1
//     $('.js-work-group').attr("data-index", ([i += 1]));
//   });
// });

//works.imagesプレビュー
function imgClick(obj){
  var inp = $(obj).parent().children("input");
  // console.log(inp);
  inp.click();
}
   $(function() {
    function readURL(input) {
        if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
          // console.log($(input).parent().children("img"));
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
                  <span class="js-work-num">〖${index}〗</span>
                  <span class="delete-work-btn">削除</span><br>
                  <input id="works_img${index}" class="work_img_field" style="display:none;" date="{:index=>&quot;0&quot;}" type="file" name="post[works_attributes][${index}][images]">
                  <img onclick="imgClick(this)" id="work_img_prev" class="img-size" src="/assets/sample-92269c50190175d7b24c2a2f9c64501c92b4318bab6bcfd32da727530e422086.jpg">
                  <br>
                  <textarea style="width:100%; height:15vh;" class="works_detail text-form" placeholder="説明をここに..." name="post[works_attributes][${index}][detail]" id="post_works_attributes_${index}_detail"></textarea>
                </div>`;
    return html;
  }

  let fileIndex = [2, 3, 4, 5, 6, 7, 8] // 追加するフォームのインデックス番号を用意
  var lastIndex = $(".js-work-group:last").data("index"); // 編集フォーム用（すでにデータがある分のインデックス番号が何か取得しておく）
  fileIndex.splice(0, lastIndex); // 編集フォーム用（データがある分のインデックスをfileIndexから除いておく）
  let fileCount = $(".hidden-destroy").length; // 編集フォーム用（データがある分のフォームの数を取得する）
  let displayCount = $(".js-work-group").length // 見えているフォームの数を取得する
  $(".hidden-destroy").hide(); // 編集フォーム用（削除用のチェックボックスを非表示にしておく）
  if (fileIndex.length == 0) $(".add-form-btn-work").css("display","none"); // 編集フォーム用（フォームが8つある場合は追加ボタンを非表示にしておく）

  $(".add-form-btn-work").on("click", function() { // 追加ボタンクリックでイベント発
    // var index_list =  []
    // $(".js-work-group").each(function() {
    //   index_list.push($(this).data('index').val())
    // })
    // console.log(index_list)
    // var max_index = Math.max.apply(null, index_list)
    // console.log(max_index)
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

// いいね数モーダルウィンドウ
$( function() {
	$('#favorite-button').click( function () {
	  console.log('favorite')
		$('#favorite-modal').modal();
	});
});

// 無限スクロール
$(window).on('scroll', function() {
    scrollHeight = $(document).height();
    scrollPosition = $(window).height() + $(window).scrollTop();
    if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
          $('.jscroll').jscroll({
            contentSelector: '.jscroll-select',
            nextSelector: 'li.next:last a'
          });
    }
});
// ツールチップ
$(document).on("turbolinks:load",function(){
  $('[data-toggle="tooltip"]').tooltip();
})

// スクロールボタン
$(document).on("turbolinks:load",function() {
  $('.scroll-event a').on('click',function(event){
    $('body, html').animate({
      scrollTop:0
    }, 450);
    event.preventDefault();
  });
});

// 文字数count処理
$(function (){

  // \nは"改行"に変換して2文字にする。
  var count = $('.js-text').text().replace(/\n/g, "改行").length;
  // 残りの文字数を計算
  var now_count = 50 - count;
  // 文字数オーバーで文字色のスタイルを付与
  if (count > 50) {
    $('.js-text-count').css("color","red");
  }
  // 入力可能な文字数を表示
  $('.js-text-count').text("残り" + now_count + "文字");
  // キーボードを押して戻ったタイミングで、残り何文字入力できるか数えて表示
  $('.js-text').on("keyup", function() {
    // フォームのvalueの文字数を数える
    var count = $(this).val().replace(/\n/g, "改行").length;
    var now_count = 50 - count;

    if (count > 50) {
      $('.js-text-count').css("color","red");
    } else {
      $('.js-text-count').css("color","black");
    }
    $('.js-text-count').text("残り" + now_count + "文字");
  });
});

$(function() {
  $(".alert").fadeOut(6000);
})

// コメント非同期(jsの勉強のつもりだったが、あまり使わない方法らしいので注意)
// $(function() {
//   function buildHTML(comment){
//     var html =
//       `<div class="comment-section_head">
//         <h5 class="commented-user">
//           <a data-turbolinks="false" href="/end_users/${comment.end_user}">
//             <strong>${comment.end_user_name}</strong>
//           </a>
//         </h5>
//         <p class="commented-time">
//           ${comment.created_at}
//         </p>
//         <p>
//           <a class="comment-destroy-btn" data-remote="true" rel="nofollow" data-method="delete" href="/posts/${comment.post}/comments/${comment.comment_id}">削除</a>
//         </p>
//         </div>
//         <p class="comment-section_body">
//           ${comment.body}
//         </p>`
//     return html;
//   }

//   $("#submit").on("click",function(e){
//     e.preventDefault();
//     var formData = new FormData(document.querySelector("#new_comment"));
//     var url =$("#new_comment").attr("action");

//     $.ajax({
//       url: url,
//       type: "POST",
//       data: formData,
//       processData:false,
//       contentType:false
//     })
//     .done(function(data){
//       var html = buildHTML(data);
//       console.log($('.comment-section'))
//       $('.comment-section').prepend(html)
//       $('.comment-form').val('');
//       $('.post-comment').prop('disabled', false);
//     })
//     .fail(function(){
//       alert("コメントを入力してください")
//     })
//   })
// })