current_page = 0;
image_speed = 0.17; 

display_set_gui_size(1366, 768); 

var _mid_x = 1366 / 2;
var _mid_y = 768 * 0.45; 
var _floor_y = 768 * 0.55;

fade_alpha = 0;       
fade_state = 0;     
fade_speed = 0.05;    
target_page = 0;

//ColonizerKing
hover_timer = 0;
hover_speed = 0.05;
hover_range = 10;

story_data = [
    { 
        text: "Cerita ini dimulai pada suatu kerajaan yang tertimpa serangan Colonizers, yaitu penjajah dari luar angkasa, yang sudah melanda hingga zaman dahulu.", 
        layers: [
            { sprite: OculusIdle, x: _mid_x, y: _mid_y + 110, scale: 5 }
        ]
    },
    { 
        text: "Prophecy menyebutkan bahwa hanya HERO yang bisa menyelamatkan kerajaan dari serangan Colonizers yang sampai sekarang tidak berhenti.", 
        layers: [
            { sprite: HeroIdle, x: _mid_x, y: _mid_y + 120, scale: 6 }
        ]
    },
    { 
        text: "Tetapi, pada tahun 1078, HERO tersebut sudah dibunuh terlebih dahulu oleh sihir gelap Colonizer KING. Seiring Colonizer KING meninggalkan kerajaan tersebut, tubuh HERO pun menghilang.", 
        layers: [
            { sprite: HeroDead, x: _mid_x - 200, y: _floor_y + 20, scale: 4 }, 
            { sprite: ColonizerKING, x: _mid_x + 300, y: _mid_y - 80, scale: 4 } 
        ]
    },
    { 
        text: "Menghadapi dilema ini, kerajaan mengirim pasukan ksatria berkali-kali untuk melawan kembali, tetapi selalu gagal. Ini membuat penduduk kerajaan makin lama makin menyerah atas serangan Colonizers.", 
        layers: [
            { sprite: PlayerDead, x: _mid_x - 30, y: _floor_y + 15, scale: 5 },
            { sprite: OculusAttack, x: _mid_x + 165, y: _mid_y + 100, scale: 4 }
        ]
    },
    { 
        text: "Apalagi saat Colonizer KING kembali lagi setelah lama tidak menyerang kerajaan.", 
        layers: [
            { sprite: ColonizerKING, x: _mid_x, y: _mid_y - 75, scale: 4 }
        ]
    }
];