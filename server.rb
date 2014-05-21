require "sinatra"
require "csv"
require "pry"

def get_player_data
  players = []
  CSV.foreach("./lackp_starting_rosters.csv", headers: true, header_converters: :symbol) do |row|
    players << row.to_hash
  end
  players
end

def find_teams
  teams = []
  player_data = get_player_data
  player_data.each {|player| teams << player[:team]}
  teams = teams.uniq
end

def find_positions
  positions = []
  player_data = get_player_data
  player_data.each {|player| positions << player[:position]}
  positions = positions.uniq
end

def make_subset_array(key, subset_type)
  subset_array = []
  player_data = get_player_data
  player_data.each do |player|
    subset_array << player if player[key] == subset_type
  end
  subset_array
end

get "/" do
  @teams = find_teams
  erb :teams 
end

get "/teams" do
  @teams = find_teams
  erb :teams 
end

get "/positions" do
  @positions = find_positions
  erb :positions 
end

get "/teams/:team_name" do
  @team_name = params[:team_name]
  @team_subset_array = make_subset_array(:team, @team_name)
  @teams = find_teams
  erb :players_by_team 
end

get "/positions/:position_name" do
  @position_name = params[:position_name]
  @position_subset_array = make_subset_array(:position, @position_name)
  @positions = find_positions
  erb :players_by_position 
end












































