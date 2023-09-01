defmodule JinxWeb.UserTimelineComponent do
  use JinxWeb, :live_component    
  
  alias Jinx.Votes
  alias Jinx.Options

  use Timex

  def render(assigns) do  
    ~H"""
      <div class="timeline-posts-container" id="timeline-container" phx-hook="timeline">
        <div class="settings-container">
          <div class="settings">
            <.link class="settings-btn" phx-click="timeline sort" phx-value-value="Latest">Latest</.link>
            <.link class="settings-btn" phx-click="timeline sort" phx-value-value="Popular">Popular</.link>
            <.link class="settings-btn" phx-click="timeline sort" phx-value-value="Media">Media</.link>
            <.link class="settings-btn" phx-click="timeline sort" phx-value-value="Video">Poll</.link>
          </div>
          
          <div class="timeline-filter">
            <.button type="button" class="timeline-filter-btn" phx-click={JS.show(show_filter)}>
              <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M10.5 6h9.75M10.5 6a1.5 1.5 0 11-3 0m3 0a1.5 1.5 0 10-3 0M3.75 6H7.5m3 12h9.75m-9.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-3.75 0H7.5m9-6h3.75m-3.75 0a1.5 1.5 0 01-3 0m3 0a1.5 1.5 0 00-3 0m-9.75 0h9.75" />
              </svg>
            </.button>

            <div class="timeline-filter-options none">

            </div>
          </div>

        </div>
        
        
        <%= for post <- @posts do %>
          <section class="timeline-post-container">
            <div class="timeline-post-left">
              <div class="timeline-post-left-top">
                <img class="timeline-post-top-avatar" src={post.user.avatar} />
              </div>

              <div class="timeline-post-left-main">
                <.link class="timeline-post-collapse">

                </.link>
              </div>
            </div>

            <div class="timeline-post-right"> 
              <div class="timeline-post-right-top">
                <div class="timeline-title-container">
                  <div class="timeline-timex">
                    
                    <%= "Posted by" %>
                    <.link class="timeline-username" navigate={post.user.username}><%= post.user.username %></.link>
                    <%= String.capitalize(Timex.from_now(post.inserted_at)) %>
                  </div>

                  <div class="timeline-title">         
                    <%= post.title %>
                  </div>
                </div>

                <div class="timeline-title-tags-container">
                  
          
                </div>
              </div>

              <div class="timeline-post-tag-container">
                <%= for tag <- post.tags do %>
                  <%= if tag.type == "Board" do %>
                    <div class="timeline-category" style={"border: solid 0.1rem #{tag.color}; color: #{tag.color};"}><%= tag.name %></div>
                  <% end %> 

                  <%= if tag.type == "User" do %>
                    <div class="timeline-category" style={"border: solid 0.1rem #{tag.color}; color: #{tag.color};"}><%= tag.name %></div>
                  <% end %>                 
                <% end %>

                <%= if post.spoiler == true do %>
                  <div class="timeline-category" id="timeline-spoiler">Spoiler</div>  
                <% end %>
                
                <%= if post.nsfw == true do %>
                  <div class="timeline-category" id="timeline-category">NSFW</div> 
                <% end %>
              </div>

              <div class={"timeline-post-main-nsfw-#{post.nsfw}"}> 
                <%= if post.media_type != "No Media" do %>
                  <%= if post.media_type === "image" do %>
                    <div class="timeline-media-container" id={"timeline-media-image-#{post.id}"} phx-update="ignore">
                      <img class="timeline-media" src={post.image_url} />
                    </div>
                  <% end %>

                  <%= if post.media_type === "video" do %>
                    <div class="timeline-media-container" id={"timeline-media-video-#{post.id}"} phx-update="ignore">
                      <video class="timeline-media" src={post.video_url} controls/>
                    </div>
                  <% end %>      
                <% end %>

                <%= if post.poll_question !== nil do %>
                  <div class="timeline-poll-container">
                    <div class="timeline-poll-question">
                      <%= post.poll_question %>
                    </div>

                    <% options = Options.get_options!(post) |> Enum.sort_by(& &1.id) %>
                    <% total_sum = Enum.sum(Enum.map(options, &(&1.value))) %>
                    <% vote = Votes.get_poll_vote(@current_user, post) %>

                    <div class="timeline-poll-options">
                      <%= for option <- options do %>
                        <%= if vote do %>
                          <div class="timeline-poll-option-div">
                            <%= if total_sum > 0 do %>
                              <% percentage = (String.to_integer("#{option.value}") * 100) / (String.to_integer("#{total_sum}")) %>
                              <div class="timeline-poll-option-percent-bar" style={"width: #{percentage}%;"}/>
                            <% else %>
                              <div class="timeline-poll-option-percent-bar" style={"width: 0;"}/>
                            <% end %>

                            <div class="timeline-poll-option-label" >
                              <%= option.option %>
                            </div>

                            <div class="timeline-poll-option-percent-value">
                              <%= if total_sum > 0 do %>
                                <% percentage = (String.to_integer("#{option.value}") * 100) / (String.to_integer("#{total_sum}")) %>
                                <%= "#{Float.round(percentage, 2)}%" %>
                              <% end %>
                            </div>                
                          </div>

                        <% else %>

                          <.link class="timeline-poll-option" phx-click="poll vote" phx-value-post-id={post.id} phx-value-option-id={option.id}>
                            <div class="timeline-poll-option-label" >
                              <%= option.option %>
                            </div>
                          </.link>                          
                        <% end %>                
                      <% end %>
                    </div>

                    <div class="timeline-poll-bottom">
                      <div class="timeline-poll-total-votes">
                        <%= "Total Votes: #{total_sum}" %>
                      </div>

                      <div class="timeline-poll-timer">
                        <%= "Time Remaining: " %>
                      </div>
                    </div>
                  </div>
                <% end %>

                <%= if post.body !== nil do %>
                  <div class="timeline-body-container">
                    <div class="timeline-body">
                      <%= convert_to_html(post.body) %>
                    </div>
                  </div>
                <% end %>
              

                <div class="timeline-bottom">
                  <% vote_value = Votes.get_post_vote_value(@current_user, post) %>
                  
                  <div class="timeline-bottom-section">
                    <div class="timeline-bottom-section">
                      <div class="timeline-post-vote">
                        <.link class={"upvote-#{vote_value}"} phx-click="post upvote" phx-value-id={post.id}>
                          <svg viewBox="0 0 300 300" shape-rendering="geometricPrecision" text-rendering="geometricPrecision">
                            <path d="M150.334314,0L30,213.333618l60-13.333351-10-26.666703l70-120.00016l70,120.00016-10,26.666703l60,13.333351L150.334314,0Z" transform="matrix(1 0 0 0.749999 0 0)"/>
                            <path d="M150,80l-40,50l10,20l30.334314-40L180,150l10-20-40-50Z" stroke-width="10"/>
                            <path d="M150,80l-40,50l10,20l30-40l30,40l10-20-40-50Z" transform="matrix(1.000002 0 0 1-.0003 70)"/>
                            <path d="M150,220l-20,30l20.334314,50L170,250l-20-30Z" stroke-width="10"/>
                          </svg>
                        </.link> 
                      </div>

                      <div class="timeline-count">
                        <%= format_number(post.vote_count) %>
                      </div>

                      <div class="timeline-post-vote">
                        <.link class={"downvote-#{vote_value}"} phx-click="post downvote" phx-value-id={post.id}>
                          <svg viewBox="0 0 300 300">
                            <path d="M150.334314,0L30,213.333618l60-13.333351-10-26.666703l70-120.00016l70,120.00016-10,26.666703l60,13.333351L150.334314,0Z" transform="matrix(1 0 0-.749999 0 300)"/>
                            <path d="M150,80l-40,50l10,20l30.334314-40L180,150l10-20-40-50Z" transform="matrix(1 0 0-1 0 230)" />
                            <path d="M150,80l-40,50l10,20l30-40l30,40l10-20-40-50Z" transform="matrix(1.000002 0 0-1-.0003 300)"/>
                            <path d="M150,220l-20,30l20.334314,50L170,250l-20-30Z" transform="matrix(1 0 0-1 0 300)" />
                          </svg>
                        </.link>
                      </div>
                    </div>
                  </div>

                  <div class="timeline-bottom-section">
                    <.link class="timeline-bottom-link" phx-click="increase post view count" phx-value-id={post.id}>
                      <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" >
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20.25 8.511c.884.284 1.5 1.128 1.5 2.097v4.286c0 1.136-.847 2.1-1.98 2.193-.34.027-.68.052-1.02.072v3.091l-3-3c-1.354 0-2.694-.055-4.02-.163a2.115 2.115 0 01-.825-.242m9.345-8.334a2.126 2.126 0 00-.476-.095 48.64 48.64 0 00-8.048 0c-1.131.094-1.976 1.057-1.976 2.192v4.286c0 .837.46 1.58 1.155 1.951m9.345-8.334V6.637c0-1.621-1.152-3.026-2.76-3.235A48.455 48.455 0 0011.25 3c-2.115 0-4.198.137-6.24.402-1.608.209-2.76 1.614-2.76 3.235v6.226c0 1.621 1.152 3.026 2.76 3.235.577.075 1.157.14 1.74.194V21l4.155-4.155" />
                      </svg>
                        
                      <label><%= format_number(post.comment_count) %></label>
                    </.link>
                  </div>

                  <div class="timeline-bottom-section">
                    <.link class="timeline-bottom-link" phx-click="increase post view count" phx-value-id={post.id}>
                      <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M7.217 10.907a2.25 2.25 0 100 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186l9.566-5.314m-9.566 7.5l9.566 5.314m0 0a2.25 2.25 0 103.935 2.186 2.25 2.25 0 00-3.935-2.186zm0-12.814a2.25 2.25 0 103.933-2.185 2.25 2.25 0 00-3.933 2.185z" />
                      </svg>

                      <label><%= "Share" %></label>
                    </.link>
                  </div>

                  <div class="timeline-bottom-section">
                    <.link class="timeline-bottom-link" phx-click="increase post view count" phx-value-id={post.id}>
                      <svg fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M3 3v1.5M3 21v-6m0 0l2.77-.693a9 9 0 016.208.682l.108.054a9 9 0 006.086.71l3.114-.732a48.524 48.524 0 01-.005-10.499l-3.11.732a9 9 0 01-6.085-.711l-.108-.054a9 9 0 00-6.208-.682L3 4.5M3 15V4.5" />
                      </svg>

                      <label><%= "Report" %></label>
                    </.link>
                  </div>


                </div>
              </div>
            </div>
          </section>
        <% end %>
      </div>                     
    """
  end

  def convert_to_html(text) when is_binary(text) do
    text
    |> String.replace(~r/@(\w+)/, "<a href=\"/user/\\1\">@\\1</a>")  # Converts @username mentions to links
    |> String.replace(~r/#(\w+)/, "<a href=\"/tags?tag=\\1\">#\\1</a>")  # Converts #hashtag mentions to links
    |> String.replace(~r/\*\*(.*?)\*\*/, "<strong>\\1</strong>")  # Converts **bold** text to <strong>bold</strong>
    |> String.replace(~r/\*(.*?)\*/, "<em>\\1</em>")  # Converts *italic* text to <em>italic</em>
    |> String.replace(~r/\*\*\*(.*?)\*\*\*/, "<strong><em>\\1</em></strong>")  # Converts ***boldanditalic*** text to <strong>bold</strong>
    |> String.replace(~r/~~(.*?)~~/, "<s>\\1</s>")  # Converts ~~strikethrough~~ text to <s>strikethrough</s>
    |> String.replace(~r/!!(.*?)!!/,"<span class=\"spoiler\">\\1</span>")  # Converts !!spoiler!! text to <del>spoiler</del>
    |> String.replace(~r/`(.*?)`/, "<code>\\1</code>")  # Converts `inline code` to <code>inline code</code>
    |> String.replace(~r/^\s*[-+*]\s+(.*)$/m, "<li>\\1</li>")  # Converts bullet points to <li> items
    |> String.replace(~r/^\s*>\s+(.*)$/m, "<blockquote>\\1</blockquote>")  # Converts blockquotes to <blockquote> items
    |> String.replace(~r/(?<!<blockquote>)\n\s*(?!\n)/, "<br />\n")  # Converts line breaks to <br /> tags
    
    |> raw()
  end

  def convert_to_html(_), do: ""

  def format_number(number) do
    if number >= 1000000 do
      formatted = number / 1000000.0
      "#{formatted |> format_decimal}M"
    else 
      if number >= 1000 do
        formatted = number / 1000.0
        "#{formatted |> format_decimal}K"
      else
        to_string(number)
      end
    end
  end

  defp format_decimal(number) do
    :erlang.float_to_binary(number, [decimals: 2])
  end 

  def show_filter(js \\ %JS{}) do
    js
    |> JS.show(to: ".timeline-filter-options", display: "flex")
    |> JS.hide(to: ".timeline-filter-options")
  end
end