#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-27 | 09:16:52
# - meta script | C:/xxx/gh/last/pr6/sc/__tree_create_v3.rb
#
    require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------

# --- scene ---
    Dir["./AnneRose/*.rb"].map { |m| require m }

# --- Merkle_tree ---

    Merkle_tree.new.Main :AnneRose_main do | o |
      o.Code do
        case
        when o.task.empty? then o.Flandoll << :title
        end
        case o.Flandoll.pop
        when :title , :MSG_CODE1
          o.Task :title do |o|
            o.Code do
              o.Main :title_main do |o|
                AnneRose::Title.new o
                a = nil
                o.n = Fiber.new do
                   loop do
                    p  a = Fiber.yield(5)
                   end
                end

                o.Code do
#                  p 2
#                  p o.n.resume
  #                  p 2
  #                  case o.Flandoll.pop
                    #  AnneRose::Title.new o , f= Fiber.new do
                    #    case Fiber.yield(5)
                    # end
                    # case Fiber.yield
  #                  p o.sym
  #                  case false

                  case a # o.Flandoll.pop
                  when :menu , :MSG_CODE1
                    o.Task :menu do |o|
                      o.Code do
                        o.Main :menu_main do |o|
                          AnneRose::Menu.new o
                          o.Code do
                            case o.Flandoll.pop
                            when :story , :MSG_CODE1
                              o.Task :story do |o|
                                o.Code do
                                  o.Main :story_main do |o|
                                    AnneRose::Story.new o
                                    o.Code do
                                      case o.Flandoll.pop
                                      when :charactor_select , :MSG_CODE1
                                        o.Task :charactor_select do |o|
                                          o.Code do
                                            o.Main :charactor_select_main do |o|
                                              AnneRose::Charactor_select.new o
                                              o.Code do
                                                case o.Flandoll.pop
                                                when :field , :MSG_CODE1
                                                  o.Task :field do |o|
                                                    o.Code do
                                                      o.Main :field_main do |o|
                                                        AnneRose::Field.new o
                                                        o.Code do
                                                          case o.Flandoll.pop
                                                          when :story_stage0, :MSG_CODE1
                                                            o.Task :story_stage0 do |o|
                                                              o.Code do
                                                                o.Main :story_stage0_mainloop do |o|
                                                                  AnneRose::Story_stage0.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage1, :MSG_CODE2
                                                            o.Task :story_stage1 do |o|
                                                              o.Code do
                                                                o.Main :story_stage1_mainloop do |o|
                                                                  AnneRose::Story_stage1.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage2, :MSG_CODE3
                                                            o.Task :story_stage2 do |o|
                                                              o.Code do
                                                                o.Main :story_stage2_mainloop do |o|
                                                                  AnneRose::Story_stage2.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage3, :MSG_CODE4
                                                            o.Task :story_stage3 do |o|
                                                              o.Code do
                                                                o.Main :story_stage3_mainloop do |o|
                                                                  AnneRose::Story_stage3.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage4, :MSG_CODE5
                                                            o.Task :story_stage4 do |o|
                                                              o.Code do
                                                                o.Main :story_stage4_mainloop do |o|
                                                                  AnneRose::Story_stage4.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage5, :MSG_CODE6
                                                            o.Task :story_stage5 do |o|
                                                              o.Code do
                                                                o.Main :story_stage5_mainloop do |o|
                                                                  AnneRose::Story_stage5.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage6, :MSG_CODE7
                                                            o.Task :story_stage6 do |o|
                                                              o.Code do
                                                                o.Main :story_stage6_mainloop do |o|
                                                                  AnneRose::Story_stage6.new o
                                                                o.Code do end
                                                                end
                                                              end
                                                            end
                                                          when :story_stage_ex , :MSG_CODE8
                                                            o.Task :story_stage_ex do |o|
                                                              o.Code do
                                                                o.Main :story_stage_ex_main do |o|
                                                                  AnneRose::Story_stage_ex.new o
                                                                  o.Code do
                                                                    case o.Flandoll.pop
                                                                    when :ending , :MSG_CODE1
                                                                    o.Task :ending do |o|
                                                                      o.Code do
                                                                      o.Main :ending_main do |o|
                                                                        AnneRose::Ending.new o
                                                                        o.Code do
                                                                          case o.Flandoll.pop
                                                                          when :staff_roll , :MSG_CODE1
                                                                            o.Task :staff_roll do |o|
                                                                              o.Code do
                                                                                o.Main :staff_roll_main do |o|
                                                                                  AnneRose::Staff_roll.new o
                                                                                  o.Code do
                                                                                    case o.Flandoll.pop
                                                                                    when :return_display, :MSG_CODE1
                                                                                      o.Task :return_display do |o|
                                                                                        o.Code do
                                                                                          o.Main :return_display_mainloop do |o|
                                                                                            AnneRose::Return_display.new o
                                                                                          o.Code do end
                                                                                          end
                                                                                        end
                                                                                      end
                                                                                    end
                                                                                  end
                                                                                end
                                                                              end
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              when :cpu_mode , :MSG_CODE2
                o.Task :cpu_mode do |o|
                  o.Code do
                    o.Main :cpu_mode_main do |o|
                      AnneRose::Cpu_mode.new o
                      o.Code do
                        case o.Flandoll.pop
                        when :cpu_mode_charactor_select , :MSG_CODE1
                          o.Task :cpu_mode_charactor_select do |o|
                            o.Code do
                              o.Main :cpu_mode_charactor_select_main do |o|
                                AnneRose::Cpu_mode_charactor_select.new o
                                o.Code do
                                  case o.Flandoll.pop
                                  when :cpu_mode_map_select , :MSG_CODE1
                                    o.Task :cpu_mode_map_select do |o|
                                      o.Code do
                                        o.Main :cpu_mode_map_select_main do |o|
                                          AnneRose::Cpu_mode_map_select.new o
                                          o.Code do
                                            case o.Flandoll.pop
                                            when :cpu_mode_field , :MSG_CODE1
                                              o.Task :cpu_mode_field do |o|
                                                o.Code do
                                                  o.Main :cpu_mode_field_main do |o|
                                                    AnneRose::Cpu_mode_field.new o
                                                    o.Code do
                                                      case o.Flandoll.pop
                                                      when :cpu_mode_stage0, :MSG_CODE1
                                                        o.Task :cpu_mode_stage0 do |o|
                                                          o.Code do
                                                            o.Main :cpu_mode_stage0_mainloop do |o|
                                                              AnneRose::Cpu_mode_stage0.new o
                                                            o.Code do end
                                                            end
                                                          end
                                                        end
                                                      end
                                                    end
                                                  end
                                                end
                                              end
                                            end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              when :match_mode, :MSG_CODE3
                o.Task :match_mode do |o|
                  o.Code do
                    o.Main :match_mode_mainloop do |o|
                      AnneRose::Match_mode.new o
                    o.Code do end
                    end
                  end
                end
              when :vs_network, :MSG_CODE4
                o.Task :vs_network do |o|
                  o.Code do
                    o.Main :vs_network_mainloop do |o|
                      AnneRose::Vs_network.new o
                    o.Code do end
                    end
                  end
                end
              when :practice, :MSG_CODE5
                o.Task :practice do |o|
                  o.Code do
                    o.Main :practice_mainloop do |o|
                      AnneRose::Practice.new o
                    o.Code do end
                    end
                  end
                end
              when :replay, :MSG_CODE6
                o.Task :replay do |o|
                  o.Code do
                    o.Main :replay_mainloop do |o|
                      AnneRose::Replay.new o
                    o.Code do end
                    end
                  end
                end
              when :relust, :MSG_CODE7
                o.Task :relust do |o|
                  o.Code do
                    o.Main :relust_mainloop do |o|
                      AnneRose::Relust.new o
                    o.Code do end
                    end
                  end
                end
              when :music_room, :MSG_CODE8
                o.Task :music_room do |o|
                  o.Code do
                    o.Main :music_room_mainloop do |o|
                      AnneRose::Music_room.new o
                    o.Code do end
                    end
                  end
                end
              when :profile , :MSG_CODE9
                o.Task :profile do |o|
                  o.Code do
                    o.Main :profile_main do |o|
                      AnneRose::Profile.new o
                      o.Code do
                        case o.Flandoll.pop
                        when :keyconfig, :MSG_CODE1
                          o.Task :keyconfig do |o|
                            o.Code do
                              o.Main :keyconfig_mainloop do |o|
                                AnneRose::Keyconfig.new o
                              o.Code do end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              when :option , :MSG_CODE10
                o.Task :option do |o|
                  o.Code do
                    o.Main :option_main do |o|
                      AnneRose::Option.new o
                      o.Code do
                        case o.Flandoll.pop
                        when :sound, :MSG_CODE1
                          o.Task :sound do |o|
                            o.Code do
                              o.Main :sound_mainloop do |o|
                                AnneRose::Sound.new o
                              o.Code do end
                              end
                            end
                          end
                        when :game_option, :MSG_CODE2
                          o.Task :game_option do |o|
                            o.Code do
                              o.Main :game_option_mainloop do |o|
                                AnneRose::Game_option.new o
                              o.Code do end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              when :exit, :MSG_CODE11
                o.Task :exit do |o|
                  o.Code do
                    o.Main :exit_mainloop do |o|
                      AnneRose::Exit.new o
                    o.Code do end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
