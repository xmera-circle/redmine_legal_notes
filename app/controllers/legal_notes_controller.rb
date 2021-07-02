# frozen_string_literal: true

# This file is part of the Plugin Redmine Legal Notes.
#
# Copyright (C) 2020-2021 Liane Hampe <liaham@xmera.de>, xmera.
#
# This plugin program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.

##
# Control the LegalNotes page rendering
#
class LegalNotesController < ApplicationController
  self.main_menu = false
  # prevents login action to be filtered by check_if_login_required application scope filter
  skip_before_action :check_if_login_required, :check_password_change

  before_action :find_legal_note, only: :index

  def index
    if @legal_note.present?
      pretty_name
      respond_to do |format|
        format.html { render :index }
      end
    else
      redirect_to home_path
    end
  end

  private

  def find_legal_note
    @legal_note = LegalNote.find(name: name)
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def name
    params[:name]
  end

  def pretty_name
    @pretty_name = name.titleize
  end
end
