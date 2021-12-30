unit astradno;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZConnection, ZDataset, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, platproc, ExtCtrls, EditBtn,
  Calendar, ExtDlgs;

type

  { TForm27 }

  TForm27 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CalendarDialog1: TCalendarDialog;
    Image1: TImage;
    Image3: TImage;
    Label1: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
    procedure StringGrid1CheckboxToggled(sender: TObject; aCol, aRow: Integer;
      aState: TCheckboxState);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1EditingDone(Sender: TObject);
    procedure StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
      var Value: string);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: char);
    procedure StringGrid1PickListSelect(Sender: TObject);
    procedure StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
      var Editor: TWinControl);
    procedure StringGrid1ValidateEntry(sender: TObject; aCol, aRow: Integer;
      const OldValue: string; var NewValue: String);
    procedure UpdateGrid();
    procedure rep();
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form27: TForm27;
  fl_edit_dog: byte;


implementation
uses
  mainopp,kontr_main,shedule_edit,htmldoc,htmlproc;

{$R *.lfm}
var
   n: integer;
   kontrID : string;
   rep_count:integer=1;

{ TForm27 }


procedure TForm27.rep();
var
   //n:integer=0;
   m:integer=0;
   x:integer=0;
   //check_kontr: string='';
   mas_atp1:array of array of string; //Массив перевозчиков
   //mas_dog:array of array of string; //Массив договоров
   mas_bil:array of array of string; //Массив билетов
   mas_bil2:array of array of string; //Массив билетов одной строчкой на 1 перевозчика
   otd_mas:array of array of string; //Массив отделений
   itogo:array of array of string; //Массив общих итогов
begin
 Setlength(itogo,0,0);
   Setlength(itogo,1,21);

   with Form27 do
    begin
        //--------------------------------------\\
         //-----------ДЛЯ ВСЕХ ОТДЕЛЕНИЙ-----------\\
        //-------СБОР БИЛЕТОВ ПО ПЕРЕВОЗЧИКУ--------\\
       //--------------------------------------------\\
            // -------------------- Соединяемся с локальным сервером ----------------------
          If not(Connect2(Zconnection1, flagProfile)) then
            begin
                 showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
                 exit;
            end;
            ZQuery1.SQL.Clear;
            ZQuery1.SQL.add('SELECT a.point_id, ');
            ZQuery1.SQL.add('(select b.name from av_spr_point b where b.del=0 AND b.id=a.point_id order by b.createdate desc limit 1) as name ');
            ZQuery1.SQL.add('FROM av_servers a ');
            ZQuery1.SQL.add('where a.del=0 ');
            //ZQuery1.SQL.add('and real_virtual=1 ');
            ZQuery1.SQL.add('order by createdate desc ');
            //ZQuery1.SQL.add('limit 12');
            //If not CheckBox7.Checked then  ZQuery1.SQL.add('and a.real_virtual=1 ');
            //showmessage(ZQuery1.SQL.Text);
            try
                  ZQuery1.open;
            except
                  showmessagealt('ОШИБКА ЗАПРОСА !'+#13+ZQuery1.SQL.Text);
                  ZQuery1.Close;
                  Zconnection1.disconnect;
                  exit;
            end;
            // Если нет отделений
            if ZQuery1.RecordCount=0 then
            begin
                 showmessagealt('Нет доступных отделений !!!');
                 ZQuery1.Close;
                 Zconnection1.disconnect;
                 exit;
            end;
            // Заполняем массив
            Setlength(otd_mas,0);
            for n:=0 to ZQuery1.RecordCount-1 do
            begin
                 Setlength(otd_mas,length(otd_mas)+1,2);
                 otd_mas[length(otd_mas)-1,0]:=trim(ZQuery1.FieldByName('point_id').asString);
                 otd_mas[length(otd_mas)-1,1]:=trim(ZQuery1.FieldByName('name').asString);
                 ZQuery1.Next;
            end;

             ZQuery1.Close;
             Zconnection1.disconnect;
            Setlength(mas_bil,0,0);



            //     // Устанавливаем текущий сервер
            //     Tek_server:=strtoint(otd_mas[k,0]);
            //     set_server('remote');

            //     // -------------------- Соединяемся с локальным сервером ----------------------
            //     If not(Connect2(Zconnection1, flagProfile)) then
            //     begin
            //          showmessagealt('1.Нет соединения с сервером '+otd_mas[k,1]+'!'+#13+'Обратитесь к администратору или попробуйте снова !!!');
            //          continue;
            //     end;

            for x:=0 to length(otd_mas)-1 do
            begin

                 Tek_server:=strtoint(otd_mas[x,0]);
                 //If tek_server<>815 then continue;
                 set_server('remote');
                 label19.Caption:=otd_mas[x,0]+'  '+otd_mas[x,1];
                 Panel1.Visible:=true;
                 application.ProcessMessages;

                 If not(Connect2(Zconnection1, 2)) then
                 begin
                      showmessagealt('1.Нет соединения с сервером '+otd_mas[x,1]+'!'+#13+'Обратитесь к администратору или попробуйте снова !!!');
                      label19.Caption:='';
                      Panel1.Visible:=false;
                       application.ProcessMessages;
                      continue;
                 end;


                 //for n:=0 to length(mas_dog)-1 do
                 begin
                  // -------------------- Соединяемся с локальным сервером ----------------------
                      If not(Connect2(Zconnection1, 2)) then
                      begin
                           showmessagealt('Соединение с сервером базы данных отсутствует !'+#13+'Проверьте сетевое соединение и опции файла настроек системы...');
                           exit;
                      end;
                      ZQuery1.SQL.Clear;
                      //Курсор+дата1+дата2
                      ZQuery1.SQL.add('SELECT report_analastr_ticket('+quotedstr('bb')+','+quotedstr(StringGrid1.Cells[1,StringGrid1.Row])+',');
                      ZQuery1.SQL.add(quotedstr(StringGrid1.Cells[2,StringGrid1.Row])+','+inttostr(Tek_server)+','+tekkontr+',');
                      ZQuery1.SQL.add(StringGrid1.Cells[4,StringGrid1.Row]+','+StringGrid1.Cells[5,StringGrid1.Row]+','+StringGrid1.Cells[6,StringGrid1.Row]);
                      //Стоимость багажа+тип расчета
                      ZQuery1.SQL.add(','+StringGrid1.Cells[7,StringGrid1.Row]+','+inttostr(StringGrid1.Columns.Items[3].PickList.IndexOf(Stringgrid1.Cells[3,StringGrid1.Row]))+');');
                      ZQuery1.SQL.add('FETCH ALL IN bb;');
                      //showmessage(ZQuery1.SQL.Text);//$
                      try
                         ZQuery1.open;
                      except
                            Panel1.Visible:=false;
                            showmessage('ОШИБКА ЗАПРОСА НА СЕРВЕРЕ: '+otd_mas[x,1]+#13+ZQuery1.SQL.Text);   //!!!!!!!!!!!!!!!!!!!!!!! РЕМАРИТЬ ЭТО
                            ZQuery1.Close;
                            Zconnection1.disconnect;
                            //exit;        //!!!!!!!!!!!! И ЭТО РЕМАРИТЬ
                            continue;     //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! РАЗРЕМАРИТЬ ЭТО ЧТОБЫ ПРОВЕРИТЬ УДАЛЕНКУ БЕЗ ОШИБОК ОТСУТСВИЯ НА ВСЕХ СЕРВАКАХ ХП
                      end;

                      //Если нет данных
                      if ZQuery1.RecordCount=0 then
                      begin
                           //showmessagealt('ID 2. Отсутствуют данные по договорам для отчета !!!');
                           Panel1.Visible:=false;
                           ZQuery1.Close;
                           Zconnection1.disconnect;
                           continue;
                           //exit;
                      end;

               Panel1.Visible:=false;
               application.ProcessMessages;

                      //Ложим суммы по перевозчику в массив
                      for m:=0 to ZQuery1.RecordCount-1 do
                      begin
                           Setlength(mas_bil,length(mas_bil)+1,21);
                           // ID+имя перевозчика
                           mas_bil[length(mas_bil)-1,0]:=trim(ZQuery1.FieldByName('name_kontr').asString);
                           // сумма билетов
                           mas_bil[length(mas_bil)-1,1]:=trim(ZQuery1.FieldByName('sum_bil').asString);
                           // сумма багажа
                           mas_bil[length(mas_bil)-1,2]:=trim(ZQuery1.FieldByName('sum_bag').asString);
                           // количество билетов межрегион
                           mas_bil[length(mas_bil)-1,3]:=trim(ZQuery1.FieldByName('kol_bil_meg').asString);
                           // стоимость межрегион
                           mas_bil[length(mas_bil)-1,4]:=trim(ZQuery1.FieldByName('stoim3').asString);
                           // доход межрегион
                           mas_bil[length(mas_bil)-1,5]:=trim(ZQuery1.FieldByName('dohod3').asString);
                           // доход багаж межрегион
                           mas_bil[length(mas_bil)-1,6]:=trim(ZQuery1.FieldByName('dohod3_bag').asString);
                           // количество внутреобластных
                           mas_bil[length(mas_bil)-1,7]:=trim(ZQuery1.FieldByName('kol_bil_vobl').asString);
                           // стоимость внутреобластных
                           mas_bil[length(mas_bil)-1,8]:=trim(ZQuery1.FieldByName('stoim2').asString);
                           // доход внутреобластных
                           mas_bil[length(mas_bil)-1,9]:=trim(ZQuery1.FieldByName('dohod2').asString);
                           // доход багаж внутреобластных
                           mas_bil[length(mas_bil)-1,10]:=trim(ZQuery1.FieldByName('dohod2_bag').asString);
                           // количество пригород
                           mas_bil[length(mas_bil)-1,11]:=trim(ZQuery1.FieldByName('kol_bil_pr').asString);
                           // стоимость пригород
                           mas_bil[length(mas_bil)-1,12]:=trim(ZQuery1.FieldByName('stoim1').asString);
                           // доход пригород
                           mas_bil[length(mas_bil)-1,13]:=trim(ZQuery1.FieldByName('dohod1').asString);
                           // доход багаж пригород
                           mas_bil[length(mas_bil)-1,14]:=trim(ZQuery1.FieldByName('dohod1_bag').asString);
                           // количество межрегион+внутреобластные
                           mas_bil[length(mas_bil)-1,15]:=trim(ZQuery1.FieldByName('kol_bil_meg_vobl').asString);
                           // доход межрегион+внутреобластные
                           mas_bil[length(mas_bil)-1,16]:=trim(ZQuery1.FieldByName('dohod_meg_vobl').asString);
                           // доход багаж м+в
                           mas_bil[length(mas_bil)-1,17]:=trim(ZQuery1.FieldByName('dohod_meg_vobl_bag').asString);
                           // колество всех
                           mas_bil[length(mas_bil)-1,18]:=trim(ZQuery1.FieldByName('kol_bil_all').asString);
                           // доход всех
                           mas_bil[length(mas_bil)-1,19]:=trim(ZQuery1.FieldByName('dohod_all').asString);
                           // id_kontr
                           mas_bil[length(mas_bil)-1,20]:=trim(ZQuery1.FieldByName('idkontr').asString);

                           ZQuery1.Next;
                      end;
                      ZQuery1.Close;
                      Zconnection1.disconnect;
                 end;
                 ZQuery1.Close;
                 Zconnection1.disconnect;
          end;

          // Собираем все значения для каждого перевозчика в одну строку
          Setlength(mas_bil2,0,0);
          begin
               n:=0;
               Setlength(mas_bil2,1,21);
               mas_bil2[n,20]:=tekkontr;
               //showmessage(mas_bil2[n,20]+' - '+mas_atp1[n,0]);
               for m:=0 to length(mas_bil)-1 do
               begin
                    //showmessage(mas_bil2[n,20]);
                    //showmessage(mas_bil[n,20]);
                    if mas_bil2[n,20]=mas_bil[m,20] then
                    begin
                         // Пустышки, чтобы не ругался float
                         if mas_bil2[n,1]='' then mas_bil2[n,1]:='0';
                         if mas_bil2[n,2]='' then mas_bil2[n,2]:='0';
                         if mas_bil2[n,3]='' then mas_bil2[n,3]:='0';
                         if mas_bil2[n,4]='' then mas_bil2[n,4]:='0';
                         if mas_bil2[n,5]='' then mas_bil2[n,5]:='0';
                         if mas_bil2[n,6]='' then mas_bil2[n,6]:='0';
                         if mas_bil2[n,7]='' then mas_bil2[n,7]:='0';
                         if mas_bil2[n,8]='' then mas_bil2[n,8]:='0';
                         if mas_bil2[n,9]='' then mas_bil2[n,9]:='0';
                         if mas_bil2[n,10]='' then mas_bil2[n,10]:='0';
                         if mas_bil2[n,11]='' then mas_bil2[n,11]:='0';
                         if mas_bil2[n,12]='' then mas_bil2[n,12]:='0';
                         if mas_bil2[n,13]='' then mas_bil2[n,13]:='0';
                         if mas_bil2[n,14]='' then mas_bil2[n,14]:='0';
                         if mas_bil2[n,15]='' then mas_bil2[n,15]:='0';
                         if mas_bil2[n,16]='' then mas_bil2[n,16]:='0';
                         if mas_bil2[n,17]='' then mas_bil2[n,17]:='0';
                         if mas_bil2[n,18]='' then mas_bil2[n,18]:='0';
                         if mas_bil2[n,19]='' then mas_bil2[n,19]:='0';

                         if mas_bil[m,1]='' then mas_bil[m,1]:='0';
                         if mas_bil[m,2]='' then mas_bil[m,2]:='0';
                         if mas_bil[m,3]='' then mas_bil[m,3]:='0';
                         if mas_bil[m,4]='' then mas_bil[m,4]:='0';
                         if mas_bil[m,5]='' then mas_bil[m,5]:='0';
                         if mas_bil[m,6]='' then mas_bil[m,6]:='0';
                         if mas_bil[m,7]='' then mas_bil[m,7]:='0';
                         if mas_bil[m,8]='' then mas_bil[m,8]:='0';
                         if mas_bil[m,9]='' then mas_bil[m,9]:='0';
                         if mas_bil[m,10]='' then mas_bil[m,10]:='0';
                         if mas_bil[m,11]='' then mas_bil[m,11]:='0';
                         if mas_bil[m,12]='' then mas_bil[m,12]:='0';
                         if mas_bil[m,13]='' then mas_bil[m,13]:='0';
                         if mas_bil[m,14]='' then mas_bil[m,14]:='0';
                         if mas_bil[m,15]='' then mas_bil[m,15]:='0';
                         if mas_bil[m,16]='' then mas_bil[m,16]:='0';
                         if mas_bil[m,17]='' then mas_bil[m,17]:='0';
                         if mas_bil[m,18]='' then mas_bil[m,18]:='0';
                         if mas_bil[m,19]='' then mas_bil[m,19]:='0';

                         // Пустышки, чтобы не ругался float
                         if itogo[0,1]='' then itogo[0,1]:='0';
                         if itogo[0,2]='' then itogo[0,2]:='0';
                         if itogo[0,3]='' then itogo[0,3]:='0';
                         if itogo[0,4]='' then itogo[0,4]:='0';
                         if itogo[0,5]='' then itogo[0,5]:='0';
                         if itogo[0,6]='' then itogo[0,6]:='0';
                         if itogo[0,7]='' then itogo[0,7]:='0';
                         if itogo[0,8]='' then itogo[0,8]:='0';
                         if itogo[0,9]='' then itogo[0,9]:='0';
                         if itogo[0,10]='' then itogo[0,10]:='0';
                         if itogo[0,11]='' then itogo[0,11]:='0';
                         if itogo[0,12]='' then itogo[0,12]:='0';
                         if itogo[0,13]='' then itogo[0,13]:='0';
                         if itogo[0,14]='' then itogo[0,14]:='0';
                         if itogo[0,15]='' then itogo[0,15]:='0';
                         if itogo[0,16]='' then itogo[0,16]:='0';
                         if itogo[0,17]='' then itogo[0,17]:='0';
                         if itogo[0,18]='' then itogo[0,18]:='0';
                         if itogo[0,19]='' then itogo[0,19]:='0';


                         mas_bil2[n,0]:=mas_bil[m,0];
                         //sum_bil
                         mas_bil2[n,1]:=Floattostrf(strtofloat(mas_bil2[n,1])+strtofloat(mas_bil[m,1]),fffixed,15,2);
                         //sum_bag
                         mas_bil2[n,2]:=Floattostrf(strtofloat(mas_bil2[n,2])+strtofloat(mas_bil[m,2]),fffixed,15,2);
                         //kol_b_m
                         mas_bil2[n,3]:=inttostr(strtoint(mas_bil2[n,3])+strtoint(mas_bil[m,3]));
                         //stoim3
                         mas_bil2[n,4]:=mas_bil[m,4];//Floattostrf(strtofloat(mas_bil2[n,4])+strtofloat(mas_bil[m,4]),fffixed,15,2);
                         //d
                         mas_bil2[n,5]:=Floattostrf(strtofloat(mas_bil2[n,5])+strtofloat(mas_bil[m,5]),fffixed,15,2);
                         //db
                         mas_bil2[n,6]:=Floattostrf(strtofloat(mas_bil2[n,6])+strtofloat(mas_bil[m,6]),fffixed,15,2);
                         //kolvobl
                         mas_bil2[n,7]:=inttostr(strtoint(mas_bil2[n,7])+strtoint(mas_bil[m,7]));
                         //s
                         mas_bil2[n,8]:=mas_bil[m,8];//Floattostrf(strtofloat(mas_bil2[n,8])+strtofloat(mas_bil[m,8]),fffixed,15,2);
                         //d
                         mas_bil2[n,9]:=Floattostrf(strtofloat(mas_bil2[n,9])+strtofloat(mas_bil[m,9]),fffixed,15,2);
                         //db
                         mas_bil2[n,10]:=Floattostrf(strtofloat(mas_bil2[n,10])+strtofloat(mas_bil[m,10]),fffixed,15,2);
                         //kolpr
                         mas_bil2[n,11]:=inttostr(strtoint(mas_bil2[n,11])+strtoint(mas_bil[m,11]));
                         //s
                         mas_bil2[n,12]:=mas_bil[m,12];//Floattostrf(strtofloat(mas_bil2[n,12])+strtofloat(mas_bil[m,12]),fffixed,15,2);
                         //d
                         mas_bil2[n,13]:=Floattostrf(strtofloat(mas_bil2[n,13])+strtofloat(mas_bil[m,13]),fffixed,15,2);
                         //db
                         mas_bil2[n,14]:=Floattostrf(strtofloat(mas_bil2[n,14])+strtofloat(mas_bil[m,14]),fffixed,15,2);
                         //kolmv
                         mas_bil2[n,15]:=inttostr(strtoint(mas_bil2[n,15])+strtoint(mas_bil[m,15]));
                         //d
                         mas_bil2[n,16]:=Floattostrf(strtofloat(mas_bil2[n,16])+strtofloat(mas_bil[m,16]),fffixed,15,2);
                         //db
                         mas_bil2[n,17]:=Floattostrf(strtofloat(mas_bil2[n,17])+strtofloat(mas_bil[m,17]),fffixed,15,2);
                         //kolall
                         mas_bil2[n,18]:=inttostr(strtoint(mas_bil2[n,18])+strtoint(mas_bil[m,18]));
                         //dall
                         mas_bil2[n,19]:=Floattostrf(strtofloat(mas_bil2[n,19])+strtofloat(mas_bil[m,19]),fffixed,15,2);

                         //sum_bil
                         itogo[0,1]:=Floattostrf(strtofloat(itogo[0,1])+strtofloat(mas_bil[m,1]),fffixed,15,2);
                         //sum_bag
                         itogo[0,2]:=Floattostrf(strtofloat(itogo[0,2])+strtofloat(mas_bil[m,2]),fffixed,15,2);
                         //kol_b_m
                         itogo[0,3]:=inttostr(strtoint(itogo[0,3])+strtoint(mas_bil[m,3]));
                         //stoim3
                         itogo[0,4]:=Floattostrf(strtofloat(itogo[0,4])+strtofloat(mas_bil[m,4]),fffixed,15,2);
                         //d
                         itogo[0,5]:=Floattostrf(strtofloat(itogo[0,5])+strtofloat(mas_bil[m,5]),fffixed,15,2);
                         //db
                         itogo[0,6]:=Floattostrf(strtofloat(itogo[0,6])+strtofloat(mas_bil[m,6]),fffixed,15,2);
                         //kolvobl
                         itogo[0,7]:=inttostr(strtoint(itogo[0,7])+strtoint(mas_bil[m,7]));
                         //s
                         itogo[0,8]:=Floattostrf(strtofloat(itogo[0,8])+strtofloat(mas_bil[m,8]),fffixed,15,2);
                         //d
                         itogo[0,9]:=Floattostrf(strtofloat(itogo[0,9])+strtofloat(mas_bil[m,9]),fffixed,15,2);
                         //db
                         itogo[0,10]:=Floattostrf(strtofloat(itogo[0,10])+strtofloat(mas_bil[m,10]),fffixed,15,2);
                         //kolpr
                         itogo[0,11]:=inttostr(strtoint(itogo[0,11])+strtoint(mas_bil[m,11]));
                         //s
                         itogo[0,12]:=Floattostrf(strtofloat(itogo[0,12])+strtofloat(mas_bil[m,12]),fffixed,15,2);
                         //d
                         itogo[0,13]:=Floattostrf(strtofloat(itogo[0,13])+strtofloat(mas_bil[m,13]),fffixed,15,2);
                         //db
                         itogo[0,14]:=Floattostrf(strtofloat(itogo[0,14])+strtofloat(mas_bil[m,14]),fffixed,15,2);
                         //kolmv
                         itogo[0,15]:=inttostr(strtoint(itogo[0,15])+strtoint(mas_bil[m,15]));
                         //d
                         itogo[0,16]:=Floattostrf(strtofloat(itogo[0,16])+strtofloat(mas_bil[m,16]),fffixed,15,2);
                         //db
                         itogo[0,17]:=Floattostrf(strtofloat(itogo[0,17])+strtofloat(mas_bil[m,17]),fffixed,15,2);
                         //kolall
                         itogo[0,18]:=inttostr(strtoint(itogo[0,18])+strtoint(mas_bil[m,18]));
                         //dall
                         itogo[0,19]:=Floattostrf(strtofloat(itogo[0,19])+strtofloat(mas_bil[m,19]),fffixed,15,2);

                    end;
               end;
               // Просмотр элементов массива
               //showmessage(inttostr(n)+'. '+mas_bil2[n,0]+','+mas_bil2[n,1]+','+mas_bil2[n,2]+','+mas_bil2[n,3]+','+mas_bil2[n,4]+','+mas_bil2[n,5]+','+mas_bil2[n,6]+','+mas_bil2[n,7]+','+mas_bil2[n,8]+','+mas_bil2[n,9]+','+mas_bil2[n,10]+','+mas_bil2[n,11]+','+mas_bil2[n,12]+','+mas_bil2[n,13]+','+mas_bil2[n,14]+','+mas_bil2[n,15]+','+mas_bil2[n,16]+','+mas_bil2[n,17]+','+mas_bil2[n,18]+','+mas_bil2[n,19]+','+mas_bil2[n,20]+',');
          end;


           // Начало HTML отчета
     if StartHTML(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'rep_'+inttostr(rep_count)+'.html')=false then exit;
     SetHTMLString('АНАЛИЗ РАБОТЫ АВТОВОКЗАЛА<br> за период с '+StringGrid1.Cells[1,StringGrid1.Row]+' по '+StringGrid1.Cells[2,StringGrid1.Row]+'<br> ',3,2,2,'080000');
     SetHTMLString('',2,1,1,'080000');
     // Таблица - Начало
     StartTableHTML(1,'',3);

     //------------------------------------Заголовок---------------------------------\\
     StartRowTableHTML('');
     CellsTableHTML('ПЕРЕВОЗЧИК',3,2,2,'',0,2);
     CellsTableHTML('СУММА<br>ВЫРУЧКИ',3,2,2,'',0,2);
     CellsTableHTML('СУММА<br>БАГАЖА',3,2,2,'',0,2);
     CellsTableHTML('межрегиональный',3,2,2,'',4,0);
     CellsTableHTML('внутриобластной',3,2,2,'',4,0);
     CellsTableHTML('пригород',3,2,2,'',4,0);
     CellsTableHTML('Итого-внутриобласт+межрегион',3,2,2,'',3,0);
     CellsTableHTML('Всего: п/р+в/об+м/рег',3,2,2,'',2,0);
     EndRowTableHTML();
     // Заголовок
     StartRowTableHTML('');
     //----межрегион
     CellsTableHTML('Количество<br>пассажиров',3,2,2,'',0,0);
     CellsTableHTML('Стоимость<br>услуги',3,2,2,'',0,0);
     CellsTableHTML('Доход АВ<br>Сумма',3,2,2,'',0,0);
     CellsTableHTML('Доход от<br>багажа',3,2,2,'',0,0);
     //----внутриобл
     CellsTableHTML('Количество<br>пассажиров',3,2,2,'',0,0);
     CellsTableHTML('Стоимость<br>услуги',3,2,2,'',0,0);
     CellsTableHTML('Доход АВ<br>Сумма',3,2,2,'',0,0);
     CellsTableHTML('Доход от<br>багажа',3,2,2,'',0,0);
     //----пригород
     CellsTableHTML('Количество<br>пассажиров',3,2,2,'',0,0);
     CellsTableHTML('Стоимость<br>услуги',3,2,2,'',0,0);
     CellsTableHTML('Доход АВ<br>Сумма',3,2,2,'',0,0);
     CellsTableHTML('Доход от<br>багажа',3,2,2,'',0,0);
     //----Итого внутриобл и межрег
     CellsTableHTML('Количество<br>пассажиров',3,2,2,'',0,0);
     CellsTableHTML('Доход АВ<br>Сумма',3,2,2,'',0,0);
     CellsTableHTML('Доход от<br>багажа',3,2,2,'',0,0);
     //----Всего
     CellsTableHTML('Количество<br>пассажиров',3,2,2,'',0,0);
     CellsTableHTML('Доход АВ<br>Сумма',3,2,2,'',0,0);
     EndRowTableHTML();
     //------------------------------------Заголовок конец---------------------------------\\




     //----Запиливаем таблицу с данными
     for n:=0 to length(mas_bil2)-1 do
     begin
          if (mas_bil2[n,0])<>'' then
          begin
               StartRowTableHTML('');
               CellsTableHTML(mas_bil2[n,0],3,1,2,'',0,0);
               CellsTableHTML(mas_bil2[n,1],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,2],3,1,2,'',0,0);
          //meg
          CellsTableHTML(mas_bil2[n,3],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,4],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,5],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,6],3,1,2,'',0,0);
          //vobl
          CellsTableHTML(mas_bil2[n,7],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,8],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,9],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,10],3,1,2,'',0,0);
          //pr
          CellsTableHTML(mas_bil2[n,11],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,12],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,13],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,14],3,1,2,'',0,0);
          //meg+vobl
          CellsTableHTML(mas_bil2[n,15],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,16],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,17],3,1,2,'',0,0);
          //meg+vobl+pr(all)
          CellsTableHTML(mas_bil2[n,18],3,1,2,'',0,0);
          CellsTableHTML(mas_bil2[n,19],3,1,2,'',0,0);
          EndRowTableHTML();
          end;
     end;
          //итоги ОБЩИЕ
         StartRowTableHTML('');
          CellsTableHTML('ИТОГО:',2,1,2,'',0,0);
          CellsTableHTML(itogo[0,1],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,2],3,1,2,'',0,0);
          //meg
          CellsTableHTML(itogo[0,3],3,1,2,'',0,0);
          CellsTableHTML('-',3,1,2,'',0,0);
          CellsTableHTML(itogo[0,5],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,6],3,1,2,'',0,0);
          //vobl
          CellsTableHTML(itogo[0,7],3,1,2,'',0,0);
          CellsTableHTML('-',3,1,2,'',0,0);
          CellsTableHTML(itogo[0,9],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,10],3,1,2,'',0,0);
          //pr
          CellsTableHTML(itogo[0,11],3,1,2,'',0,0);
          CellsTableHTML('-',3,1,2,'',0,0);
          CellsTableHTML(itogo[0,13],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,14],3,1,2,'',0,0);
          //meg+vobl
          CellsTableHTML(itogo[0,15],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,16],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,17],3,1,2,'',0,0);
          //meg+vobl+pr(all)
          CellsTableHTML(itogo[0,18],3,1,2,'',0,0);
          CellsTableHTML(itogo[0,19],3,1,2,'',0,0);
          EndRowTableHTML();

     //Таблица - Конец
     EndTableHTML();
     // Конец HTML отчета
     EndHTML();
     //Стартуем самый тормазнутый браузер
     startbrowser(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+'rep_'+inttostr(rep_count)+'.html');
     ZQuery1.Close;
     if Zconnection1.Connected then Zconnection1.disconnect;

     Panel1.Visible:=false;
     application.ProcessMessages;
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
 end;
 end;

//********************************* ОБНОВЛЕНИЕ ДАННЫХ НА ГРИДЕ ******************************************
procedure TForm27.UpdateGrid();
var
   dd : TDateTime;
begin
  With Form27 do
  begin
    Stringgrid1.RowCount:=1;
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   ZQuery1.SQL.Clear;
   //ZQuery1.SQL.add('(select id,'''' as name,null as datazak,datavoz,datapog,0 as kod1c,createdate,''*'' as viddog ');
   ZQuery1.SQL.add('select * from av_spr_kontr_dog3 where del=0 AND id_kontr IN ('+tekkontr+') order by id desc;');

   //showmessage(ZQuery1.SQL.Text);//$
   try
      ZQuery1.open;
   except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
   end;
   if ZQuery1.RecordCount=0 then
     begin
      Form27.ZQuery1.Close;
      Form27.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   StringGrid1.RowCount:=ZQuery1.RecordCount+1;
   for n:=1 to ZQuery1.RecordCount do
    begin

      Form27.StringGrid1.Cells[0,n]:=Form27.ZQuery1.FieldByName('active').asstring;
      Form27.StringGrid1.Cells[1,n]:=Form27.ZQuery1.FieldByName('datavoz').asString;
      Form27.StringGrid1.Cells[2,n]:=Form27.ZQuery1.FieldByName('datapog').asString;
      Form27.StringGrid1.Cells[3,n]:=form27.StringGrid1.Columns.Items[3].PickList.Strings[Form27.ZQuery1.FieldByName('typesumpercent').asINteger];
      If Form27.ZQuery1.FieldByName('typesumpercent').asinteger=0 then
        begin
           Form27.StringGrid1.Cells[4,n]:=Form27.ZQuery1.FieldByName('type1').asString;
           Form27.StringGrid1.Cells[5,n]:=Form27.ZQuery1.FieldByName('type2').asString;
           Form27.StringGrid1.Cells[6,n]:=Form27.ZQuery1.FieldByName('type3').asString;
           Form27.StringGrid1.Cells[7,n]:=Form27.ZQuery1.FieldByName('bag').asString;
        end
      else
        begin
           Form27.StringGrid1.Cells[4,n]:=Form27.ZQuery1.FieldByName('percent1').asString;
           Form27.StringGrid1.Cells[5,n]:=Form27.ZQuery1.FieldByName('percent2').asString;
           Form27.StringGrid1.Cells[6,n]:=Form27.ZQuery1.FieldByName('percent3').asString;
           Form27.StringGrid1.Cells[7,n]:=Form27.ZQuery1.FieldByName('bagpercent').asString;
        end;
      Form27.StringGrid1.Cells[8,n]:=Form27.ZQuery1.FieldByName('createdate').asString;
      Form27.StringGrid1.Cells[9,n]:=Form27.ZQuery1.FieldByName('id').asString;
      Form27.StringGrid1.Cells[10,n]:='Отчет';
      dd:= Form27.ZQuery1.FieldByName('datapog').AsDateTime;
      //Ставим 1, если договор просрочен
      //If dd<Date then
      // Form27.StringGrid1.Cells[8,n]:='1';
      ////договор истекает
      //If ((dd-Date)>0) AND ((dd-Date)<30) then
      // Form27.StringGrid1.Cells[8,n]:='Договор истекает '+DateToStr(dd)+' !';
      Form27.ZQuery1.Next;
    end;

   Form27.ZQuery1.Close;
   Form27.Zconnection1.disconnect;
   Form27.StringGrid1.Refresh;
   //StringGrid1.ColWidths[7]:=0;
   //StringGrid1.ColWidths[8]:=0;
  end;
end;

//*********************************************** ДОБАВИТЬ **********************************************
procedure TForm27.BitBtn1Click(Sender: TObject);
var n:integer;
begin
  Form27.StringGrid1.RowCount:=Form27.StringGrid1.RowCount+1;
  //for n:=Form27.StringGrid1.RowCount-1 to
  Form27.StringGrid1.Cells[0,form27.StringGrid1.RowCount-1]:='0';
  Form27.StringGrid1.Cells[1,form27.StringGrid1.RowCount-1]:=formatdatetime('dd/mm/yyyy',now());
  Form27.StringGrid1.Cells[2,form27.StringGrid1.RowCount-1]:=formatdatetime('dd/mm/yyyy',(now()+1));
  form27.StringGrid1.Cells[3,form27.StringGrid1.RowCount-1]:=StringGrid1.Columns.Items[3].PickList.Strings[0];
  form27.StringGrid1.Cells[4,form27.StringGrid1.RowCount-1]:='0';
  form27.StringGrid1.Cells[5,form27.StringGrid1.RowCount-1]:='0';
  form27.StringGrid1.Cells[6,form27.StringGrid1.RowCount-1]:='0';
  form27.StringGrid1.Cells[7,form27.StringGrid1.RowCount-1]:='0';
  form27.StringGrid1.Cells[8,form27.StringGrid1.RowCount-1]:='*';
end;


//********************************************** УДАЛИТЬ  *****************************************************
procedure TForm27.BitBtn2Click(Sender: TObject);
var
   res_flag:integer;
begin
  With Form27 do
  begin
         //Удаляем запись
   if (trim(Form27.StringGrid1.Cells[0,Form27.StringGrid1.row])='') or (Form27.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

    If form27.StringGrid1.Cells[9,Stringgrid1.Row]='' then
    begin
     form27.StringGrid1.DeleteRow(form27.StringGrid1.row);
     exit;
     end;

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;


    //запрос списка
   ZQuery1.SQL.Clear;
   //ZQuery1.SQL.add('(select id,'''' as name,null as datazak,datavoz,datapog,0 as kod1c,createdate,''*'' as viddog ');
   ZQuery1.SQL.add('select * from av_spr_kontr_dog3 where del=0 AND id_kontr IN ('+tekkontr+') and id='+trim(Form27.StringGrid1.Cells[9,Form27.StringGrid1.row])+' limit 1;');

   //showmessage(ZQuery1.SQL.Text);//$
   try
      ZQuery1.open;
   except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
      ZQuery1.Close;
      Zconnection1.disconnect;
   end;
   if ZQuery1.RecordCount=0 then
     begin
      Form27.ZQuery1.Close;
      Form27.Zconnection1.disconnect;
      form27.StringGrid1.DeleteRow(form27.StringGrid1.row);
      form27.StringGrid1.Refresh;
      exit;

     end;



  res_flag := dialogs.MessageDlg('Удалить запись данного договора ?',mtConfirmation,[mbYes,mbNO], 0);
 if res_flag<>6 then exit;

     //проставляем запись на удаление
     //Открываем транзакцию
 try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      exit;
     end;
     Form27.ZQuery1.SQL.Clear;
     Form27.ZQuery1.SQL.add('UPDATE av_spr_kontr_dog3 SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(Form27.StringGrid1.Cells[9,Form27.StringGrid1.row])+' and del=0;');
      //showmessage(ZQuery1.SQL.Text);//$
     Form27.ZQuery1.open;
       //завершение транзакции
   Zconnection1.Commit;
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.close;
     Zconnection1.disconnect;
     exit;
 end;

   Zconnection1.disconnect;
   UpdateGrid();

  end;
end;


 //***************** Сохранить ******************************
procedure TForm27.BitBtn3Click(Sender: TObject);
var
   new_id,j,n:integer;
   flsave,fail:boolean;
begin
  with Form27 do
  begin
//
//     If Dateedit7.Date<Dateedit6.Date then
//      begin
//        showmessagealt('Дата окончания действия договора меньше даты его начала!');
//        exit;
//      end;
//     If  (floatspinedit28.Value=0.00) and  (floatspinedit29.Value=0.00) and (floatspinedit30.Value=0.00) then
//     begin
//      showmessagealt('Все значения пусты!');
//      exit;
//     end;
//
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

   //Определяем текущий id+1
        ZQuery1.SQL.Clear;
        ZQuery1.SQL.add('SELECT coalesce(max(id),0)+1 as new_id FROM av_spr_kontr_dog3;');
        try
            ZQuery1.open;
        except
            ZQuery1.Close;
            ZConnection1.Disconnect;
            showmessagealt('Ошибка !');
            exit;
        end;
        new_id:=ZQuery1.FieldByName('new_id').asInteger;
        ZQuery1.SQL.Clear;

        flsave:=false;

  for n:=1 to Stringgrid1.RowCount-1 do
   begin
      If Stringgrid1.Cells[8,n]<>'*' then continue;
      If strtodate(Stringgrid1.Cells[1,n])>strtodate(Stringgrid1.Cells[2,n]) then
      begin
        showmessagealt('Дата начала действия периода больше даты его окончания!'+#13+'Строка №'+inttostr(n));
        continue;
      end;
      fail:=false;
      //проверяем неперескаемость периодов
      for j:=1 to Stringgrid1.RowCount-1 do
       begin
           If j=n then continue;
           If Stringgrid1.Cells[0,n]='0' then break;
           If Stringgrid1.Cells[0,j]='0' then continue;
           //если начало больше
           If strtodate(Stringgrid1.Cells[1,n])>=strtodate(Stringgrid1.Cells[1,j]) then
              If (strtodate(Stringgrid1.Cells[1,n])<=strtodate(Stringgrid1.Cells[2,j])) then
              //or (strtodate(Stringgrid1.Cells[2,n])<=strtodate(Stringgrid1.Cells[2,j]))
              begin
                fail:=true;
                break;
                end;
           //если начало меньше
            If strtodate(Stringgrid1.Cells[1,n])<=strtodate(Stringgrid1.Cells[1,j]) then
               //If (strtodate(Stringgrid1.Cells[2,n])>=strtodate(Stringgrid1.Cells[2,j]))
               If (strtodate(Stringgrid1.Cells[2,n])>=strtodate(Stringgrid1.Cells[1,j])) then
              begin
                fail:=true;
                break;
                end;
             //если конеч меньше
            If strtodate(Stringgrid1.Cells[2,n])>=strtodate(Stringgrid1.Cells[1,j]) then
               If (strtodate(Stringgrid1.Cells[1,n])<=strtodate(Stringgrid1.Cells[2,j])) then

              begin
                fail:=true;
                break;
                end;
         end;
      If fail then
      begin
        showmessagealt('Обнаружен пересекающийся период с сохраняемым значением!'+#13
        +'Сохранение невозможно!'+#13+'Строка №'+inttostr(n));
         continue;
        end;



      flsave:=true;
 //Открываем транзакцию
 try
   If not Zconnection1.InTransaction then
      Zconnection1.StartTransaction
   else
     begin
      showmessagealt('Ошибка ! Незавершенная транзакция !'+#13+'Попробуйте снова !');
      ZConnection1.Rollback;
      exit;
     end;
       If Stringgrid1.Cells[9,n]<>'' then
         begin
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('UPDATE av_spr_kontr_dog3 SET del=1,createdate=now(),id_user='+inttostr(id_user)+' WHERE del=0 and id='+Stringgrid1.Cells[9,n]+';'); //  +' and id_kontr='+kontrID+' and del=0;');
       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.ExecSQL;
       end;

       //создание записи
       ZQuery1.SQL.Clear;
       ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog3(id,id_kontr,datavoz,datapog,active,typesumpercent,type1,type2,type3,bag,percent1,percent2,percent3,bagpercent,createdate,id_user,createdate_first,id_user_first,del) VALUES (');

       ZQuery1.SQL.add(inttostr(new_id)+','+kontrID+','+Quotedstr(Stringgrid1.Cells[1,n])+','+Quotedstr(Stringgrid1.Cells[2,n])+','+Stringgrid1.Cells[0,n]);
       If form27.StringGrid1.Columns.Items[3].PickList.IndexOf(Stringgrid1.Cells[3,n])=0 then
       //If Stringgrid1.Cells[3,n]='1' then
         begin
           ZQuery1.SQL.add(',0,'+Quotedstr(Stringgrid1.Cells[4,n])+','+Quotedstr(Stringgrid1.Cells[5,n])+','+Quotedstr(Stringgrid1.Cells[6,n]));
           ZQuery1.SQL.add(','+Quotedstr(Stringgrid1.Cells[7,n])+',0,0,0,0,');
         end
       else
       begin
           ZQuery1.SQL.add(',1,0,0,0,0,'+Quotedstr(Stringgrid1.Cells[4,n])+','+Quotedstr(Stringgrid1.Cells[5,n])+','+Quotedstr(Stringgrid1.Cells[6,n]));
           ZQuery1.SQL.add(','+Quotedstr(Stringgrid1.Cells[7,n])+',');
       end;
       ZQuery1.SQL.add('now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',0);');

       //showmessage(ZQuery1.SQL.Text);//$
       ZQuery1.open;
 //Завершение транзакции
    Zconnection1.Commit;

    inc(new_id);
   except
     If ZConnection1.InTransaction then Zconnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     Zconnection1.disconnect;
     exit;
   end;
   //ZQuery1.Close;
   //Zconnection1.disconnect;
   end;
   ZConnection1.Disconnect;

  updategrid();

  If flsave then
      showmessagealt('Транзакция завершена УСПЕШНО !!!')
  else
     showmessagealt('Изменений не было произведено...');


   end;
end;


//***********************************************       ВЫХОД     **********************************************************
procedure TForm27.BitBtn4Click(Sender: TObject);
begin
  Form27.Close;
end;

//***********************************************      ВЫБРАТЬ  ***************************************************************
procedure TForm27.BitBtn5Click(Sender: TObject);
begin
  if (Form27.StringGrid1.RowCount>1) then
    begin
     result_dog:=Form27.StringGrid1.Cells[0,Form27.StringGrid1.row]+'| '+Form27.StringGrid1.Cells[1,Form27.StringGrid1.row];
     Form27.close;
    end;
end;


//************************************************* HOTKEYS ********************************************************************
procedure TForm27.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
   res:integer;
begin
   // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
     //showmessage(inttostr(key));

    If (form27.StringGrid1.Col=4) or (form27.StringGrid1.Col=5) or (form27.StringGrid1.Col=6) or (form27.StringGrid1.Col=7) then
      begin
         label1.Caption:=inttostr(key);
         res:=0;
        //If chr(key) in ['A'..'Z','a'..'z'] then key:=0;
        //If not
        If (chr(key) in ['0'..'9']) then res:=1;
        If (chr(key) in [#8,#9,#13,#37,#38,#39,#40,#46,#110,#188,#190]) then res:=2;
        If (chr(key) in [#96..#105]) then res:=3;

        If res=0 then key:=0;
        //label1.Caption:=inttostr(res);
        //If chr(key) in ['\','?','>','<','|',':','}','{','/','*','-','+',')','(','_','"'] then key:=0;
       end;


    //F5 - Добавить
    if (Key=116) and (Form27.bitbtn1.enabled=true) then Form27.BitBtn1.Click;
    //F8 - Удалить
    if (Key=119) and (Form27.bitbtn2.enabled=true) then Form27.BitBtn2.Click;
    // ESC
    if Key=27 then Form27.Close;

    if (Key=112) or (Key=113) or (Key=115) or (Key=116) or (Key=119) or (Key=27)   then Key:=0;
end;


//***********************************   ОТРИСОВКА ГРИДА ****************************************************
procedure TForm27.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
  aRect: TRect; aState: TGridDrawState);
const
  sAlarm = 'Договор ПРОСРОЧЕН !';
var
    cBrush,cFont,cFontOther,cDefault,cAl,cPen: TColor;
begin
   cBrush:=clMenuHighLight;
   cFont:=clBlack;
   cAl := $000505A8;
   cFontOther := clNavy;//$006868DE;
   cDefault := clCream;
   cPen := clBlue;
 with Sender as TStringGrid,Canvas do
  begin
       Brush.Color:=clWhite;
       //Закрашиваем бэкграунд
       FillRect(aRect);
     if (gdSelected in aState) then
           begin
            pen.Width:=6;
            pen.Color:=cPen;
            MoveTo(aRect.left,aRect.bottom-1);
            LineTo(aRect.right,aRect.Bottom-1);
            MoveTo(aRect.left,aRect.top-1);
            LineTo(aRect.right,aRect.Top);
            Font.Color := cFontOther;
            font.Size:=12;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := cFont;
            font.Size:=12;
          end;

     //Остальные поля
  if (ARow > 0) then
  begin
    TextOut(aRect.Left+10, aRect.Top+5, Cells[ACol, ARow]);
  end;

   ////Если есть договор истек
   //  if (ARow > 0) AND (ACol=1) AND (trim(Cells[8,aRow])='1') AND (trim(Cells[2,aRow])<>'*') then
   //   begin
   //     Font.Color := cAl;
   //     Font.Style := [fsBold];
   //     TextOut(aRect.Left+40, aRect.Top+25, sAlarm);
   //   end;
   //
   ////Если есть договор скоро истечет
   //  if (ARow > 0) AND (ACol=1) AND (trim(Cells[8,aRow])<>'1') then
   //   begin
   //     Font.Color := cAl;
   //     Font.Style := [];
   //     TextOut(aRect.Left+40, aRect.Top+25, Cells[8, ARow]);
   //   end;

  // Заголовок
  if aRow=0 then
         begin
           Brush.Color:=cDefault;
           FillRect(aRect);
           Font.Color := cFont;
           font.Size:=10;
           TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
          end;

 end;

end;

procedure TForm27.StringGrid1EditingDone(Sender: TObject);
begin

end;



procedure TForm27.StringGrid1GetEditMask(Sender: TObject; ACol, ARow: Integer;
  var Value: string);
begin
    if (ARow > 0) and ((ACol = 1) or (ACol = 2)) then
        Value := '!00/00/0000;1;_';
    //if (ARow > 0) and ((ACol=4) or (ACol=5) or (ACol=6) or (ACol=7))  then
        //Value:= '!99990.00;1;_';
    //Value := '!00:00:00;1;_';
end;

procedure TForm27.StringGrid1KeyPress(Sender: TObject; var Key: char);
begin
  If form27.StringGrid1.Col>0 then
   form27.StringGrid1.Cells[8,form27.StringGrid1.Row]:='*';
end;

procedure TForm27.StringGrid1PickListSelect(Sender: TObject);
begin
    form27.StringGrid1.Cells[8,form27.StringGrid1.Row]:='*';
end;

procedure TForm27.StringGrid1SelectEditor(Sender: TObject; aCol, aRow: Integer;
  var Editor: TWinControl);
begin
  // if aCol=3 then begin
  //  if (Editor is TCustomComboBox) then
  //    with Editor as TCustomComboBox do begin
  //      if (aRow mod 2=0) then
  //        Style := csDropDown
  //      else
  //        Style := csDropDownList;
  //      case aRow of
  //        1:
  //          Items.CommaText := 'ONE,TWO,THREE,FOUR';
  //        2:
  //          Items.CommaText := 'A,B,C,D,E';
  //        3:
  //          Items.CommaText := 'MX,ES,NL,UK';
  //        4:
  //          Items.CommaText := 'RED,GREEN,BLUE,YELLOW';
  //      end;
  //    end;
  //end;
end;

procedure TForm27.StringGrid1ValidateEntry(sender: TObject; aCol,
  aRow: Integer; const OldValue: string; var NewValue: String);
begin
   //Constrain to '23:59:59'.
  //This only takes effect on leaving cell.
  if (aRow > 0) and ((aCol = 1) or (aCol = 2)) then
  begin
      If Copy(NewValue, 1, 2)>'31' then
    begin
       NewValue[1] := '3';
       NewValue[2] := '0';
       end;
    If Copy(NewValue, 4, 2)>'12' then
    begin
       NewValue[4] := '1';
       NewValue[5] := '2';
       end;

    if Copy(NewValue, 7, 1)<>'2' then
      NewValue[7] := '2';
    if Copy(NewValue, 8, 1)<> '0' then
      NewValue[8] := '0';
    //if Copy(NewValue, 4, 1) > '5' then
      //NewValue[4] := '5';
    //if Copy(NewValue, 7, 1) > '5' then
      //NewValue[7] := '5';
  end;
end;



  // **************************************  ВОЗНИКНОВЕНИЕ ФОРМЫ ****************************************
procedure TForm27.FormShow(Sender: TObject);
begin
 //Centrform(Form27);
 //Form27.StringGrid1.RowHeights[0]:=30;
 //Form27.Label3.Caption:=formsk.StringGrid1.Cells[2,formsk.StringGrid1.Row];
   Label3.Caption:=Formsk.StringGrid1.Cells[2,Formsk.StringGrid1.Row];
    //id редактируемого контрагента
    kontrID := trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row]);
 //определить уровень доступа
    if flag_access=1 then
     begin
      with Form27 do
       begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn3.Enabled:=false;
       end;
     end;
  Form27.UpdateGrid();

end;

procedure TForm27.StringGrid1ButtonClick(Sender: TObject; aCol, aRow: Integer);
var
   datebefore:Tdate;
begin

   if (aCol = 10) then  //ButtonColumn
  begin
    StringGrid1.Options := StringGrid1.Options - [goEditing];
    //store as string
    StringGrid1.Cells[aCol, aRow] := 'Запуск...';//+IntToStr(aRow);
    //StringGrid1.Options := StringGrid1.Options + [goEditing]; //Turn cell editing back on
    rep();
  end;
    if (aCol = 1) or (aCol = 2)  then
  begin
    try
     datebefore:=strtodate(StringGrid1.cells[aCol,aRow]);
     StringGrid1.cells[aCol,aRow]:=datetostr(date);
    except
        datebefore:=date();
      end;
     CalendarDialog1.Date:= datebefore;

    If CalendarDialog1.Execute then
    begin
      StringGrid1.Cells[aCol, aRow] := Datetostr(form27.CalendarDialog1.Date);
    end;
    If datebefore<>CalendarDialog1.Date then
        form27.StringGrid1.Cells[8,form27.StringGrid1.Row]:='*';
  end;
end;

procedure TForm27.StringGrid1CheckboxToggled(sender: TObject; aCol,
  aRow: Integer; aState: TCheckboxState);
begin
   form27.StringGrid1.Cells[8,form27.StringGrid1.Row]:='*';
end;

end.

