# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = "")
    base_title = t ".title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def avatar_member(member)
    if member.avatar.attached?
      image_tag member.avatar, class: "avatar-default-member", id: "img_member_prev"
    else
      image_tag "defaultavatar.jpeg", class: "avatar-default-member", id: "img_member_prev"
    end
  end

  def avatar_admin(admin)
    if admin.avatar.attached?
      image_tag admin.avatar, class: "avatar-default", id: "img_prev"
    else
      image_tag "defaultavatar.jpeg", class: "avatar-default", id: "img_prev"
    end
  end
end
