program WordleGame;

uses

  Crt; // Unit untuk mengubah warna konsol
const
 Words: array[1..20] of string = ('MINUM', 'BUAYA', 'LASER', 'MUSIK', 'KURSI','POHON','MOBIL','HUTAN','GELAP','ORANG',
                                   'MAKAN', 'JUMBO', 'ZEBRA', 'TUGAS', 'PINTU','CINTA','DAMAI','EMBER','LAMPU','JALAN');
var
  TargetWord: string;
  GuessedWord: string;
  MaxAttempts,RandomIndex: integer;
  ulang:char;

procedure InitializeGame;
begin
  // Inisialisasi kata target dan aturan permainan
  randomize;
  RandomIndex := Random(20) + 1;
  TargetWord := Words[RandomIndex];
  MaxAttempts := 6;
  GuessedWord := StringOfChar('_', Length(TargetWord));
end;

procedure DisplayWord;
var
  i: integer;
begin
  // Tampilkan kata yang telah ditebak dengan penanda background
  for i := 1 to Length(GuessedWord) do
  begin
    if Pos(GuessedWord[i], TargetWord) > 0 then
    begin
    if GuessedWord[i] = TargetWord[i] then
    begin
      Textcolor(green);
      write(GuessedWord[i]);END
      else
      begin
      Textcolor(yellow);
      write(GuessedWord[i]);END;
    end
    else
    begin
      TextCOLOR(BlacK); // Background default
      write(GuessedWord[i]);
    end;
  end;
  TextBackground(Black); // Mengembalikan background default setelah tampilan kata
  writeln;
end;

procedure DisplayAttemptsRemaining(AttemptsRemaining: integer);
begin
  // Tampilkan sisa percobaan
  TEXTCOLOR(WHITE);
  writeln('Sisa percobaan: ', AttemptsRemaining);
end;

procedure TakeGuess;
var
  Guess: string;
begin
  // Ambil tebakan dari pemain
  write('Masukkan tebakan: ');
  readln(Guess);
  Guess:= upcase(Guess);
  if Length(Guess) <> Length(TargetWord) then
    writeln('Tebakan harus memiliki panjang yang sama dengan kata target.')
  else
    GuessedWord := Guess;
end;

function CheckGuess: boolean;
begin
  // Periksa apakah tebakan benar
  CheckGuess := GuessedWord = TargetWord;
end;

procedure PlayWordleGame;
var
  AttemptsRemaining: integer;
begin
  InitializeGame;
  AttemptsRemaining := MaxAttempts;
  Textcolor(11);
  writeln('Selamat datang di Wordle Game!');
  DisplayWord;

  while (AttemptsRemaining > 0) and (not CheckGuess) do
  begin
    DisplayAttemptsRemaining(AttemptsRemaining);
    TakeGuess;
    if not CheckGuess then
    begin
      writeln('Tebakan salah. Coba lagi.');
      Dec(AttemptsRemaining);
    end;
    DisplayWord;
  end;

  if CheckGuess then
    writeln('Selamat! Anda berhasil menebak kata "', TargetWord, '".')
  else
    Textcolor(red);
    writeln('Maaf, Anda kehabisan percobaan. Kata yang benar adalah "', TargetWord, '".');
end;

begin
    repeat
  // Panggil prosedur utama untuk memulai permainan
  
  ClrScr; // Bersihkan layar sebelum memulai permainan
  PlayWordleGame;
  write('apakah ingin mengulang?(y/n) ');
  readln(ulang);
  until (ulang = 'n') or (ulang = 'N');
end.