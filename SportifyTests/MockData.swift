//
//  MockData.swift
//  Sportify
//
//  Created by Ahmed Salah on 16/05/2026.
//

//
//  MockJSONData.swift
//  SportifyTests
//

import Foundation

enum MockData {


    static let leaguesSuccess = """
    {
        "success": 1,
        "result": [
            {
                "league_key": 1,
                "league_name": "Premier League",
                "country_key": 10,
                "country_name": "England",
                "league_logo": "https://example.com/pl.png",
                "country_logo": "https://example.com/eng.png"
            },
            {
                "league_key": 2,
                "league_name": "La Liga",
                "country_key": 11,
                "country_name": "Spain",
                "league_logo": "https://example.com/ll.png",
                "country_logo": "https://example.com/esp.png"
            }
        ]
    }
    """

    static let leaguesEmpty = """
    { "success": 1, "result": [] }
    """

    static let leaguesFailedSuccess = """
    { "success": 0, "result": [] }
    """


    static let liveMatchesSuccess = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 101,
                "event_date": "2025-05-11",
                "event_time": "20:00",
                "event_status": "65",
                "event_live": "1",
                "event_final_result": "2-1",
                "event_home_team": "Arsenal",
                "event_away_team": "Chelsea",
                "home_team_logo": "https://example.com/arsenal.png",
                "away_team_logo": "https://example.com/chelsea.png",
                "league_name": "Premier League",
                "league_round": "Round 35",
                "stage_name": null,
                "goalscorers": [
                    {
                        "time": "23",
                        "score": "1-0",
                        "home_scorer": "Saka",
                        "away_scorer": "",
                        "home_assist": "Odegaard",
                        "away_assist": "",
                        "info_time": "1H"
                    }
                ]
            }
        ]
    }
    """

    static let liveMatchesEmpty = """
    { "success": 1, "result": [] }
    """


    static let leagueEventsFinished = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 201,
                "event_date": "2025-04-20",
                "event_time": "15:00",
                "event_status": "Finished",
                "event_live": "0",
                "event_final_result": "3-1",
                "event_home_team": "Liverpool",
                "event_away_team": "Man City",
                "home_team_logo": "https://example.com/liv.png",
                "away_team_logo": "https://example.com/mci.png",
                "league_name": "Premier League",
                "league_round": "Round 33",
                "stage_name": null,
                "goalscorers": []
            },
            {
                "event_key": 202,
                "event_date": "2025-04-21",
                "event_time": "17:30",
                "event_status": "Finished",
                "event_live": "0",
                "event_final_result": "1-1",
                "event_home_team": "Everton",
                "event_away_team": "Brentford",
                "home_team_logo": "https://example.com/eve.png",
                "away_team_logo": "https://example.com/bre.png",
                "league_name": "Premier League",
                "league_round": "Round 33",
                "stage_name": null,
                "goalscorers": []
            }
        ]
    }
    """

    static let leagueEventsLive = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 301,
                "event_date": "2025-05-11",
                "event_time": "20:00",
                "event_status": "67",
                "event_live": "1",
                "event_final_result": "2-1",
                "event_home_team": "Barcelona",
                "event_away_team": "Real Madrid",
                "home_team_logo": null,
                "away_team_logo": null,
                "league_name": "La Liga",
                "league_round": "Round 36",
                "stage_name": null,
                "goalscorers": []
            }
        ]
    }
    """

    static let leagueEventsUpcoming = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 401,
                "event_date": "2025-06-10",
                "event_time": "19:00",
                "event_status": "Not Started",
                "event_live": "0",
                "event_final_result": null,
                "event_home_team": "PSG",
                "event_away_team": "Lyon",
                "home_team_logo": null,
                "away_team_logo": null,
                "league_name": "Ligue 1",
                "league_round": "Round 38",
                "stage_name": null,
                "goalscorers": []
            }
        ]
    }
    """

    static let leagueEventsEmpty = """
    { "success": 1, "result": [] }
    """


    static let teamEventsSuccess = """
    {
        "success": 1,
        "result": [
            {
                "event_key": 501,
                "event_date": "2025-03-15",
                "event_time": "14:00",
                "event_status": "Finished",
                "event_live": "0",
                "event_final_result": "2-0",
                "event_home_team": "Arsenal",
                "event_away_team": "Wolves",
                "home_team_logo": "https://example.com/ars.png",
                "away_team_logo": "https://example.com/wol.png",
                "league_name": "Premier League",
                "league_round": "Round 29",
                "stage_name": null,
                "goalscorers": [
                    {
                        "time": "10",
                        "score": "1-0",
                        "home_scorer": "Havertz",
                        "away_scorer": "",
                        "home_assist": "",
                        "away_assist": "",
                        "info_time": "1H"
                    },
                    {
                        "time": "78",
                        "score": "2-0",
                        "home_scorer": "Trossard",
                        "away_scorer": "",
                        "home_assist": "Saka",
                        "away_assist": "",
                        "info_time": "2H"
                    }
                ]
            }
        ]
    }
    """

    static let teamEventsEmpty = """
    { "success": 1, "result": [] }
    """


    static let leagueTeamsSuccess = """
    {
        "success": 1,
        "result": [
            {
                "team_key": 85,
                "team_name": "Arsenal",
                "team_logo": "https://example.com/arsenal.png",
                "players": []
            },
            {
                "team_key": 86,
                "team_name": "Chelsea",
                "team_logo": "https://example.com/chelsea.png",
                "players": []
            }
        ]
    }
    """

    static let leagueTeamsWithPlayers = """
    {
        "success": 1,
        "result": [
            {
                "team_key": 85,
                "team_name": "Arsenal",
                "team_logo": "https://example.com/arsenal.png",
                "players": [
                    {
                        "player_key": 1001,
                        "player_name": "David Raya",
                        "player_number": "22",
                        "player_image": "https://example.com/raya.png",
                        "player_type": "Goalkeepers"
                    },
                    {
                        "player_key": 1002,
                        "player_name": "Bukayo Saka",
                        "player_number": "7",
                        "player_image": "https://example.com/saka.png",
                        "player_type": "Forwards"
                    },
                    {
                        "player_key": 1003,
                        "player_name": "Martin Odegaard",
                        "player_number": "8",
                        "player_image": "https://example.com/odegaard.png",
                        "player_type": "Midfielders"
                    }
                ]
            }
        ]
    }
    """

    static let leagueTeamsEmpty = """
    { "success": 1, "result": [] }
    """
}
