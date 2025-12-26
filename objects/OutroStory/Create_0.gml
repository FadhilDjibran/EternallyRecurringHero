display_set_gui_size(1366, 768);
var _mid_x = 1366 / 2;
var _mid_y = 768 * 0.45;

current_music = audio_play_sound(GameOverBGM, 10, true, 0.3);
if (instance_exists(ObjectPlayer)) instance_destroy(ObjectPlayer);

current_page = 0;
fade_alpha = 0;
fade_state = 0;     
fade_speed = 0.05;
target_page = 0;

hero_alpha = 1;     
white_fade_alpha = 0;
is_time_traveling = false; 
image_speed = 0.2; 

story_data = [
    { 
        text: "Setelah melalui berbagai cycle yang berulang, ia akhirnya mengalahkan Invader KING.",
        layers: [
            { sprite: PlayerIdle, x: _mid_x + 35, y: _mid_y + 100, scale: 6 }  
        ]
    },
    { 
      
        text: "Seketika, ia pun teringat memori tentang siapa dirinya.",
        layers: [
             { sprite: MainProtagonist, x: _mid_x + 5, y: _mid_y + 100, scale: 6 } 
        ]
    },
    { 
        text: "Selama ini, ia adalah spirit dari HERO yang sudah mati, muncul kembali untuk membunuh Invader KING.",
        layers: [
			 { sprite: MainProtagonist, x: _mid_x - 150, y: _mid_y + 100, scale: 6 },
             { sprite: HeroIdle, x: _mid_x + 150, y: _mid_y + 115, scale: 6 }
        ]
    },
    { 
        text: "Sebagai takdir sebuah HERO, waktu akan berputar kembali untuknya agar ia dapat melindungi kerajaan dari serangan Invader KING.",
        layers: [
             { sprite: MainProtagonist, x: _mid_x, y: _mid_y + 100, scale: 6 } 
        ]
    },
    { 
        text: "Kita bisa bilang, ia adalah Eternally Recurring HERO.",
        layers: [{ sprite: AbsoluteCinema, x: _mid_x, y: _mid_y - 10, scale: 1.5 }] 
    }
];