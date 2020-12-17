module EndUser::ChatsHelper

  # 未読メッセージを通知のように件数と表示するための判定とcountに使用
  def unchecked_chats(user_room)
    user_room.room_chats.where(end_user_id: user_room.end_user.id, checked: false)
  end

end
