    Tree_task.new.Main :AnneRose_main do | o |
      o.Code do
        if o.task.empty?
          o.Flandoll << :title
        end
          case o.Flandoll.pop
          when :title , :MSG_CODE1
            o.Loop :title do |o|
            AnneRose::Title.new o
              o.Code do
                case o.Flandoll.pop
                when :menu , :MSG_CODE1
                  o.Loop :menu do |o|
                  AnneRose::Menu.new o
                    o.Code do
                      case o.Flandoll.pop
                      when :story , :MSG_CODE1
                        o.Loop :story do |o|
                        AnneRose::Story.new o
                          o.Code do
                            case o.Flandoll.pop
                            when :charactor_select , :MSG_CODE1
                              o.Loop :charactor_select do |o|
                              AnneRose::Charactor_select.new o
                                o.Code do
                                  case o.Flandoll.pop
                                  when :field , :MSG_CODE1
                                    o.Loop :field do |o|
                                    AnneRose::Field.new o
                                      o.Code do
                                        case o.Flandoll.pop
                                        when :story_stage0
                                          o.Loop :story_stage0 do |o|
                                          AnneRose::Story_stage0.new o
                                          o.Code do end
                                        end
                                        when :story_stage1
                                          o.Loop :story_stage1 do |o|
                                          AnneRose::Story_stage1.new o
                                          o.Code do end
                                        end
                                        when :story_stage2
                                          o.Loop :story_stage2 do |o|
                                          AnneRose::Story_stage2.new o
                                          o.Code do end
                                        end
                                        when :story_stage3
                                          o.Loop :story_stage3 do |o|
                                          AnneRose::Story_stage3.new o
                                          o.Code do end
                                        end
                                        when :story_stage4
                                          o.Loop :story_stage4 do |o|
                                          AnneRose::Story_stage4.new o
                                          o.Code do end
                                        end
                                        when :story_stage5
                                          o.Loop :story_stage5 do |o|
                                          AnneRose::Story_stage5.new o
                                          o.Code do end
                                        end
                                        when :story_stage6
                                          o.Loop :story_stage6 do |o|
                                          AnneRose::Story_stage6.new o
                                          o.Code do end
                                        end
                                        when :story_stage_ex , :MSG_CODE1
                                          o.Loop :story_stage_ex do |o|
                                          AnneRose::Story_stage_ex.new o
                                            o.Code do
                                              case o.Flandoll.pop
                                            when :ending , :MSG_CODE1
                                            o.Loop :ending do |o|
                                            AnneRose::Ending.new o
                                              o.Code do
                                                case o.Flandoll.pop
                                                when :staff_roll , :MSG_CODE1
                                                  o.Loop :staff_roll do |o|
                                                  AnneRose::Staff_roll.new o
                                                    o.Code do
                                                      case o.Flandoll.pop
                                                      when :return_display
                                                        o.Loop :return_display do |o|
                                                        AnneRose::Return_display.new o
                                                        o.Code do end
                                                      end
                                                      when :cpu_mode , :MSG_CODE1
                                                        o.Loop :cpu_mode do |o|
                                                        AnneRose::Cpu_mode.new o
                                                          o.Code do
                                                            case o.Flandoll.pop
                                                            when :cpu_mode_charactor_select , :MSG_CODE1
                                                              o.Loop :cpu_mode_charactor_select do |o|
                                                              AnneRose::Cpu_mode_charactor_select.new o
                                                                o.Code do
                                                                  case o.Flandoll.pop
                                                                  when :cpu_mode_map_select , :MSG_CODE1
                                                                    o.Loop :cpu_mode_map_select do |o|
                                                                    AnneRose::Cpu_mode_map_select.new o
                                                                      o.Code do
                                                                        case o.Flandoll.pop
                                                                        when :cpu_mode_field , :MSG_CODE1
                                                                          o.Loop :cpu_mode_field do |o|
                                                                          AnneRose::Cpu_mode_field.new o
                                                                            o.Code do
                                                                              case o.Flandoll.pop
                                                                            end
                                                                          end
                                                                        end
                                                                      end
                                                                    end
                                                                  end
                                                                end
                                                              end
                                                            end
                                                            when :cpu_mode_stage0
                                                              o.Loop :cpu_mode_stage0 do |o|
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
                                    when :match_mode
                                      o.Loop :match_mode do |o|
                                      AnneRose::Match_mode.new o
                                      o.Code do end
                                    end
                                    when :vs_network
                                      o.Loop :vs_network do |o|
                                      AnneRose::Vs_network.new o
                                      o.Code do end
                                    end
                                    when :practice
                                      o.Loop :practice do |o|
                                      AnneRose::Practice.new o
                                      o.Code do end
                                    end
                                    when :replay
                                      o.Loop :replay do |o|
                                      AnneRose::Replay.new o
                                      o.Code do end
                                    end
                                    when :relust
                                      o.Loop :relust do |o|
                                      AnneRose::Relust.new o
                                      o.Code do end
                                    end
                                    when :music_room
                                      o.Loop :music_room do |o|
                                      AnneRose::Music_room.new o
                                      o.Code do end
                                    end
                                    when :profile , :MSG_CODE1
                                      o.Loop :profile do |o|
                                      AnneRose::Profile.new o
                                        o.Code do
                                          case o.Flandoll.pop
                                          when :keyconfig
                                            o.Loop :keyconfig do |o|
                                            AnneRose::Keyconfig.new o
                                            o.Code do end
                                          end
                                          when :option , :MSG_CODE1
                                            o.Loop :option do |o|
                                            AnneRose::Option.new o
                                              o.Code do
                                                case o.Flandoll.pop
                                                when :sound
                                                  o.Loop :sound do |o|
                                                  AnneRose::Sound.new o
                                                  o.Code do end
                                                end
                                                when :game_option
                                                  o.Loop :game_option do |o|
                                                  AnneRose::Game_option.new o
                                                  o.Code do end
                                                end
                                              end
                                            end
                                          end
                                          when :exit
                                            o.Loop :exit do |o|
                                            AnneRose::Exit.new o
                                            o.Code do end
                                          end
                                        end
                                      end
                                    end
                                  end
                                end
                              end
