unit kontr_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Grids, Buttons, Spin, kontr_edit,
  StrUtils, report_main, LazUtf8;

type

  { TFormsk }

  TFormsk = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    BitBtn12: TBitBtn;
    BitBtn19: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    IdleTimer3: TIdleTimer;
    Image1: TImage;
    Image3: TImage;
    ImageList1: TImageList;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Shape1: TShape;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    ZQuery2: TZQuery;
    procedure BitBtn11Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox2Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure CheckBox4Change(Sender: TObject);
    procedure CheckBox5Change(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure IdleTimer3Timer(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure RadioButton2Change(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;       aRect: TRect; aState: TGridDrawState);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;       Shift: TShiftState; X, Y: Integer);
    procedure StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;       var CanSelect: Boolean);
    procedure StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
    procedure UpdateGrid();
    procedure UpdateGridATS();
    procedure clear_labels();
  private
    { private declarations }
    formActivated: boolean;
  public
    { public declarations }
  end; 

var
  Formsk: TFormsk;
  Fl_Edit_kontr : byte;
  result_kontr_id:string;

implementation
uses
  mainopp,platproc,shedule_edit,ats_main,dogovor,license,astradno;
var
  per:integer;
  cur_row,filtr:integer;
    dd, ddl : TDateTime;
    stroka:string;

{$R *.lfm}


procedure TFormSK.clear_labels();
begin
   Label8.Caption:='';//всего записей
   Label3.Caption:='';//полное имя
   Label6.Caption:='';//тип юр лица
   Label10.Caption:='';//телефон
   Label12.Caption:='';//инн
   Label14.Caption:='';//адрес юридический
   Label25.Caption:='';//документ
   Label16.Caption:='';//дата окончания договора
   Label18.Caption:='';//дата окончания лицензии
   Label20.Caption:='';//кол-во автобусов
   Label23.Caption:='';//кол-во расписаний
end;

procedure TFormsk.UpdateGridATS();
var
  n,m:integer;
begin
  With FormSK do
  begin
  //проверка зависимого грида
    If Stringgrid1.RowCount<2 then exit;
    try
      strtoint(StringGrid1.Cells[1,StringGrid1.row])
    except
     on exception: EConvertError do exit;
    end;

  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
  end;

  // Запрос АТС
  Formsk.ZQuery1.SQL.clear;
  Formsk.ZQuery1.SQL.add('SELECT b.id_kontr,b.id_ats,a.name,a.gos,a.m_down,a.m_up,a.m_lay,a.m_down_two,a.m_up_two,a.m_lay_two,a.level,a.type_ats,a.comfort,a.god');
  Formsk.ZQuery1.SQL.add('FROM av_spr_ats AS a, av_spr_kontr_ats AS b');
  Formsk.ZQuery1.SQL.add('WHERE b.id_ats=a.id and a.del=0 and b.del=0 and b.id_kontr='+trim(formsk.StringGrid1.Cells[1,formsk.StringGrid1.row]));
  //showmessagealt(Formsk.ZQuery1.SQL.text);
  Formsk.ZQuery1.open;
  if Formsk.ZQuery1.RecordCount=0 then
     begin
       formsk.StringGrid2.RowCount:=1;
       Formsk.ZQuery1.close;
       Formsk.ZConnection1.Disconnect;
       exit;
     end;
  // Заполняем АТС контрагентов
  formsk.StringGrid2.RowCount:=Formsk.ZQuery1.RecordCount+1;
  for n:=1 to  Formsk.ZQuery1.RecordCount do
   begin
    // Заполняем stringgrid
       Formsk.StringGrid2.Cells[0,n]:=formsk.ZQuery1.FieldByName('id_ats').asString;
       Formsk.StringGrid2.Cells[1,n]:=formsk.ZQuery1.FieldByName('name').asString;
       Formsk.StringGrid2.Cells[2,n]:=formsk.ZQuery1.FieldByName('gos').asString;
       if  formsk.ZQuery1.FieldByName('type_ats').asInteger=1 then Formsk.StringGrid2.Cells[3,n]:='М2';
       if  formsk.ZQuery1.FieldByName('type_ats').asInteger=2 then Formsk.StringGrid2.Cells[3,n]:='М3';
       Formsk.StringGrid2.Cells[4,n]:=formsk.ZQuery1.FieldByName('level').asString;
       Formsk.StringGrid2.Cells[5,n]:=inttostr(formsk.ZQuery1.FieldByName('m_up').asinteger+formsk.ZQuery1.FieldByName('m_down').asinteger+formsk.ZQuery1.FieldByName('m_lay').asinteger+formsk.ZQuery1.FieldByName('m_up_two').asinteger+formsk.ZQuery1.FieldByName('m_down_two').asinteger+formsk.ZQuery1.FieldByName('m_lay_two').asinteger);
       Formsk.ZQuery1.Next;
   end;
   Formsk.ZQuery1.Close;
   Formsk.Zconnection1.disconnect;
   //Formsk.StringGrid2.Refresh;
//   If NOT(formsk.Edit1.text='') then
//      formsk.Edit1.SetFocus
//   else
     //formsk.StringGrid1.SetFocus;
end;


//********************************* ОБНОВИТЬ ДАННЫЕ О КОНТРАГЕНТАХ НА ГРИДЕ  ***************
procedure TFormsk.UpdateGrid();
var
  n,m:integer;

  //scel : string;
begin
   //dd:=time();
  with Formsk do
  begin
      StringGrid1.RowCount:=1;
      StringGrid2.RowCount:=1;
      clear_labels();
      Panel1.Visible:=true;
      application.ProcessMessages;
 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
  // Запрос контрагентов
  ZQuery1.SQL.clear;
  ZQuery1.SQL.add('SELECT s.* FROM (');
  ZQuery1.SQL.add('SELECT v.* ');
  ZQuery1.SQL.add(',date_mi(v.dataz,current_date) as midog ');
  ZQuery1.SQL.add(',date_mi(v.datao,current_date) as milic ');
  ZQuery1.SQL.add('FROM ( ');
  ZQuery1.SQL.add('SELECT m.id,m.name,m.polname,m.vidkontr,m.kod1c,m.inn,m.tel,m.adrur,m.document,m.del ');
  ZQuery1.SQL.add(',(SELECT Count(*) FROM av_spr_kontr_ats WHERE del=0 and id_kontr=m.id) as kolats '); //кол-во автобусов
  ZQuery1.SQL.add(',(SELECT Count(*) FROM av_shedule_atp WHERE del=0 and id_kontr=m.id) as kolshedule ');//кол-во расписаний
  ZQuery1.SQL.add(',(SELECT max(coalesce(dataok,''2100-01-01'')) FROM av_spr_kontr_license ');
  ZQuery1.SQL.add('WHERE del=0 AND id_kontr=m.id AND datanach is not null ');
  ZQuery1.SQL.add(') as datao ');
  ZQuery1.SQL.add(',(SELECT max(datapog) FROM av_spr_kontr_dog ');
  ZQuery1.SQL.add('WHERE del=0 AND id_kontr=m.id ');
  ZQuery1.SQL.add('AND (cast(case WHEN trim(viddog)='''' then ''0'' ELSE coalesce(viddog,''0'') END AS integer)=2) AND datapog is not null ');
  ZQuery1.SQL.add(') as dataz ');
  ZQuery1.SQL.add('FROM av_spr_kontragent AS m ');
   //если показывать удаленных
     If checkbox4.Checked then
      ZQuery1.SQL.add('WHERE m.del=2 ')
      else
        ZQuery1.SQL.add('WHERE m.del=0 ');

         //осуществлять контекстный поиск или нет
 If filtr=1 then
   begin
   ZQuery1.SQL.add('AND ((m.id='+stroka+') OR (m.kod1c='+stroka+')) ');
   end;
 If filtr=2 then
   begin
   ZQuery1.SQL.add('AND ((UPPER(substr(m.name,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+')) ');
   ZQuery1.SQL.add('OR (UPPER(substr(m.polname,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+'))) ');
   //ZQuery1.SQL.add('OR (UPPER(substr(m.adrur,1,'+inttostr(Utf8length(stroka))+'))=UPPER('+Quotedstr(stroka)+'))) ');
   end;
       //если фильтр на изменный тариф
    If CheckBox1.Checked then
       begin
      ZQuery1.SQL.add('AND ((SELECT Count(*) FROM av_shedule_price WHERE del=0 and id_kontr=m.id)+');
      ZQuery1.SQL.add('(SELECT Count(*) FROM av_shedule_tarif WHERE del=0 and id_kontr=m.id))>0');
       end;
    //если фильтр по перевозчикам, имеющим договор передачи ПДП
      If formsk.CheckBox5.Checked then
     ZQuery1.SQL.add('AND id in (select id_kontr from av_spr_kontr_fio where m.id=id_kontr and del=0) ');


    ZQuery1.SQL.add(') v ) s ');
    ZQuery1.SQL.add('WHERE 1=1 ');
       //показывать только перевозчиков
 if formsk.RadioButton2.Checked then
    ZQuery1.SQL.add('AND s.dataz is not null ');

       //если фильтр по дням до окончания договора
     If CheckBox2.Checked then
        ZQuery1.SQL.add('AND s.midog>0 AND s.midog<'+inttostr(SpinEdit1.Value));

   //если фильтр по дням до окончания лицензии
     If CheckBox3.Checked then
     ZQuery1.SQL.add('AND s.milic>0 AND s.milic<'+inttostr(SpinEdit1.Value));


   ZQuery1.SQL.add('ORDER BY id ASC;');
 //showmessage(Formsk.ZQuery1.SQL.text);//&
 //dd:=time();
  try
   ZQuery1.open;
  except
    Panel1.Visible:=false;
    showmessage('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
 //showmessage(formatdatetime('nn.zzz',dd)+#13+formatdatetime('nn.zzz',time()));
  formsk.Label8.Caption:=inttostr(Formsk.ZQuery1.RecordCount);
  Panel1.Visible:=false;


  if Formsk.ZQuery1.RecordCount=0 then
     begin

       Formsk.ZQuery1.close;
       Formsk.ZConnection1.Disconnect;
       exit;
     end;

  // Заполняем контрагенты

  for n:=1 to Formsk.ZQuery1.RecordCount do
   begin
      StringGrid1.RowCount := (StringGrid1.RowCount+1);
    // Заполняем stringgrid
   //    Formsk.StringGrid1.Cells[0,n]:=inttostr(n);
       StringGrid1.Cells[0,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('kolats').asString;
       StringGrid1.Cells[1,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('id').asString;
       StringGrid1.Cells[2,StringGrid1.RowCount-1]:= ZQuery1.FieldByName('name').asString; // + DupeString(' ',80-Length(scel))+ZQuery1.FieldByName('vidkontr').asString;
       StringGrid1.Cells[3,StringGrid1.RowCount-1]:= ZQuery1.FieldByName('vidkontr').asString;
       StringGrid1.Cells[4,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('kod1c').asString;
       StringGrid1.Cells[5,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('kolshedule').asString;
       StringGrid1.Cells[6,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('tel').asString;
       StringGrid1.Cells[7,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('inn').asString;
       StringGrid1.Cells[8,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('adrur').asString;
       StringGrid1.Cells[9,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('dataZ').asString;
       StringGrid1.Cells[10,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('datao').asString;
       StringGrid1.Cells[11,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('polname').asString;
       StringGrid1.Cells[12,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('document').asString;
       StringGrid1.Cells[13,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('midog').asString;
       StringGrid1.Cells[14,StringGrid1.RowCount-1]:=ZQuery1.FieldByName('milic').asString;

       ZQuery1.Next;
   end;
   ZQuery1.Close;
   Zconnection1.disconnect;
   //StringGrid1.Refresh;
   //StringGrid1.ColWidths[0]:=0;
   //StringGrid1.ColWidths[3]:=0;
   //StringGrid1.ColWidths[5]:=0;
   //StringGrid1.ColWidths[6]:=0;
   //StringGrid1.ColWidths[7]:=0;
   //StringGrid1.ColWidths[8]:=0;
   //StringGrid1.ColWidths[9]:=0;
   //StringGrid1.ColWidths[10]:=0;
 //  If NOT(formsk.Edit1.text='') then
 //     Edit1.SetFocus
//   else

     //StringGrid1.SetFocus;
  end;

  //formsk.UpdateGridAts();
end;

//********************************* ПОКАЗЫВАТЬ ВСЕХ **********************************
procedure TFormsk.RadioButton1Change(Sender: TObject);
begin
  //If (formsk.StringGrid1.RowCount<2) or not formsk.RadioButton1.Checked then exit;
  If not formsk.RadioButton1.Checked then exit;
   formsk.Edit1.Visible:=false;
   filtr:=0;
   stroka:='';
   FormSK.UpdateGrid();
   FormSK.Stringgrid1.Row:=FormSK.Stringgrid1.RowCount-1;
   formsk.StringGrid1.SetFocus;
end;

//*********************** ПОКАЗЫВАТЬ ТОЛЬКО С ДОГОВОРОМ ****************************
procedure TFormsk.RadioButton2Change(Sender: TObject);
begin
  //If (formsk.StringGrid1.RowCount<2) or not formsk.RadioButton2.Checked then exit;
  If not formsk.RadioButton2.Checked then exit;
  //dd:=time();
  formsk.Edit1.Visible:=false;
  filtr:=0;
  stroka:='';
  formsk.UpdateGrid();
  FormSK.Stringgrid1.Row:=FormSK.Stringgrid1.RowCount-1;
  formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.SpinEdit1Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  If formsk.CheckBox2.Checked then
  formsk.UpdateGrid();
end;

procedure TFormsk.SpinEdit2Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
   If formsk.CheckBox3.Checked then
  formsk.UpdateGrid();
end;


procedure TFormsk.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer; aRect: TRect; aState: TGridDrawState);
var
  DateLic : TDateTime;
   myYear, myMonth, myDay : Word;
   tstr:string;
begin
// Рисуем GRID
 with Sender as TStringGrid, Canvas do
 begin
      Brush.Color:=clWhite;
      FillRect(aRect);

   If aCol>4 then exit;//не рисовать невидимые колонки

    if (gdSelected in aState) then
          begin
           pen.Width:=4;
           pen.Color:=clRed;
           MoveTo(aRect.left,aRect.bottom-1);
           LineTo(aRect.right,aRect.Bottom-1);
           MoveTo(aRect.left,aRect.top-1);
           LineTo(aRect.right,aRect.Top);
    //****** id
    If (aRow>0) and (aCol=1) then
    begin
       font.height:=16;
       font.Style:=[];
    end;
    //имя
    If (aRow>0) and (aCol=2) then
    begin
       font.height:=15;
       font.Style:=[fsBold];
    end;
    //код 1с
      If (aRow>0) and (aCol=4) then
    begin
       font.height:=15;
       font.Style:=[];
    end;
 end
 else
    begin
       //****** id
    If (aRow>0) and (aCol=1) then
    begin
       font.height:=14;
       font.Style:=[];
    end;
    //имя
    If (aRow>0) and (aCol=2) then
    begin
       font.height:=13;
       font.Style:=[];
    end;
    //код 1с
      If (aRow>0) and (aCol=4) then
    begin
       font.height:=13;
       font.Style:=[];
    end;
 end;
   //****** id
    If (aRow>0) and (aCol=1) then
    begin
       font.Color:=clBlack;
       TextOut(aRect.Left + 6, aRect.Top+6, Cells[aCol, aRow]);
    end;

//****** поле имени  ********************
   If (aRow>0) and (aCol=2) then
    begin
       font.Color:=clBlack;
       TextOut(aRect.Left + 7, aRect.Top+5, Cells[aCol, aRow]);
    //Договор перевозки
     If (trim(Cells[13,aRow]))<>'' then
      begin
       font.height:=11;
       font.Color:=clBlack;
       tstr:='';
        //проверка даты договора
        try
         If strtoint(StringGrid1.Cells[13,aRow])<1 then
         begin
          tstr:='Договор продажи билетов - ПРОСРОЧЕН !!!';
          Font.Color := $006868DE;
          font.Style:= [fsBold];
         end;
        If (strtoint(StringGrid1.Cells[13,aRow])>0) AND (strtoint(StringGrid1.Cells[13,aRow])<30) then
        begin
          tstr:='ДОГОВОР истекает через '+StringGrid1.Cells[13,aRow]+' дней !';
          Font.Color := clNavy;
          font.Style:= [];
        end;
        except
          exit;
        end;

        TextOut(aRect.right -5 -textwidth(tstr), aRect.bottom -15 -textheight(tstr), tstr);
      end;

     //лицензия
     If (trim(Cells[14,aRow])<>'') then
      begin
       font.height:=11;
       font.Color:=clBlack;
       tstr:='';
        //проверка даты договора
        try
         If strtoint(StringGrid1.Cells[14,aRow])<1 then
         begin
          tstr:='ВНИМАНИЕ ! ЛИЦЕНЗИЯ ПРОСРОЧЕНА !!!';
          Font.Color := clRed;
          font.Style:= [fsBold];
         end;
        If (strtoint(StringGrid1.Cells[14,aRow])>0) AND (strtoint(StringGrid1.Cells[14,aRow])<30) then
        begin
          tstr:='Лицензия истекает через '+StringGrid1.Cells[14,aRow]+' дней !';
          Font.Color := clBlack;
          font.Style:= [];
        end;
        except
          exit;
        end;
        TextOut(aRect.right -5 -textwidth(tstr), aRect.bottom -2 -textheight(tstr), tstr);
      end;
      end;
//*********************

     // код 1С
     if (aRow>0) and (aCol=4) then
        begin
         Font.Color := clBlack;
         TextOut(aRect.Left + 5, aRect.Top+2, Cells[aCol,aRow]);
       end;

     // Заголовок
      if (aRow=0) AND (aCol>0) then
        begin
          Brush.Color:=clCream;
          FillRect(aRect);
          Font.Color := clBlack;
          font.Style:=[fsBold];
          font.height:=13;
          TextOut(aRect.left +(aRect.Right -aRect.Left) div 2 -textwidth(Cells[aCol,aRow]) div 2 -5, aRect.Top+5, Cells[aCol,0]);
        end;
  end;
end;

procedure TFormsk.StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;  Shift: TShiftState; X, Y: Integer);
var
  col,row : integer;
begin
  //Stringgrid1.MouseToCell(X,Y,col,row);
  //if row>0 then exit;
  ////Если щелкнули по той же колонке, то изменить порядок сортировки, иначе сортировка по другому столбцу
  //If Col=sort_col then sort_direction:=sort_direction+1
  //else sort_direction :=1;
  //If sort_direction=3 then sort_direction :=1;
  //sort_col := Col;
  //Stringgrid1.Row:=1;
  //UpdateGrid();
end;

procedure TFormsk.StringGrid1SelectCell(Sender: TObject; aCol, aRow: Integer;
  var CanSelect: Boolean);
begin
  If (aCol=0) or (aCol>4) then
    CanSelect:= false;
end;

procedure TFormsk.StringGrid1Selection(Sender: TObject; aCol, aRow: Integer);
begin
  with formsk do
  begin
   If Stringgrid1.RowCount<2 then exit;
   If Stringgrid1.Cells[1,Stringgrid1.Row]='' then exit;
    Label3.Caption:=Stringgrid1.Cells[11,aRow];//полное имя
    Label6.Caption:=Stringgrid1.Cells[3,aRow];//тип юр лица
    Label10.Caption:=Stringgrid1.Cells[6,aRow];//телефон
    Label12.Caption:=Stringgrid1.Cells[7,aRow];//инн
    Label14.Caption:=Stringgrid1.Cells[8,aRow];//адрес юридический
    Label25.Caption:=Stringgrid1.Cells[12,aRow];//документ
    Label16.Caption:=Stringgrid1.Cells[9,aRow];//дата окончания договора
    Label18.Caption:=Stringgrid1.Cells[10,aRow];//дата окончания лицензии
    Label20.Caption:=Stringgrid1.Cells[0,aRow];//кол-во автобусов
    Label23.Caption:=Stringgrid1.Cells[5,aRow];//кол-во расписаний
  end;
  formsk.UpdateGridATS();
end;

procedure TFormsk.BitBtn4Click(Sender: TObject);
begin
  formsk.Close;
end;

//****************************** УДАЛИТЬ АТС ***********************************************
procedure TFormsk.BitBtn19Click(Sender: TObject);
var
  smess : string;
  n: integer;
begin
 with FormSK do
 begin
    if (trim(formsk.StringGrid2.Cells[0,formsk.StringGrid2.row])='') or  (formsk.StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;
   if not(dialogs.MessageDlg('Удалить АТС из списка ?',mtConfirmation,[mbYes,mbNO], 0)=6) then
     begin
       exit;
     end;
   // Удаляем АТС из списка контрагента
   // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;

//-------------------------- проверка на возможность удаления записи из справочника АТС расписания
  //If DelCheck(Formsk.StringGrid2,0,Formsk.ZConnection1,Formsk.ZQuery1,'av_shedule_ats.id_ats:id_shedule,')<>1  then exit;
    ZQuery1.SQL.Clear;
    ZQuery1.SQL.add('Select c.id_shedule  ');
    ZQuery1.SQL.add(',(SELECT b.name_shedule FROM av_shedule b WHERE b.del=0 AND b.id=c.id_shedule) name_shedule ');
    ZQuery1.SQL.add('FROM av_shedule_atp as c ');
    ZQuery1.SQL.add('WHERE c.del=0 and c.id_kontr='+formsk.StringGrid1.Cells[1,formsk.StringGrid1.row]+' AND c.id_shedule IN ');
    ZQuery1.SQL.add('(Select a.id_shedule FROM av_shedule_ats as a ');
    ZQuery1.SQL.add('Where a.del=0 AND a.flag=1 AND a.id_ats='+Stringgrid2.Cells[0,Stringgrid2.Row]+' and id_kontr='+formsk.StringGrid1.Cells[1,formsk.StringGrid1.row]+');');
    //showmessage(Zquery1.SQL.text);//$
    try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
   end;
     if ZQuery1.RecordCount>0 then
       begin
         smess := '';
       for n:=1 to ZQuery1.RecordCount do
       begin
       smess := smess + ZQuery1.FieldByName('id_shedule').asString +' - ' + ZQuery1.FieldByName('name_shedule').asString +',  '+#13;
       ZQuery1.Next;
       end;
        showmessagealt('Операция НЕВОЗМОЖНА !'+#13+'Сначала отметьте как неактивное АТС в следующих расписаниях:'+#13+smess);
        exit;
       end;

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
    //удаляем АТС из справочника АТС расписаний если АТС там неактивно
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_shedule_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id_ats=');
     ZQuery1.SQL.add(StringGrid2.Cells[0,StringGrid2.row]+' and id_kontr='+ StringGrid1.Cells[1,StringGrid1.row]+' AND flag=0;');
     ZQuery1.ExecSQL;
   //удаляем АТС из справочника АТС контрагентов
     formsk.ZQuery1.SQL.Clear;
     formsk.ZQuery1.SQL.add('UPDATE av_spr_kontr_ats SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id_ats=');
     formsk.ZQuery1.SQL.add(StringGrid2.Cells[0,StringGrid2.row]+' and id_kontr='+ StringGrid1.Cells[1,StringGrid1.row]+';');
     formsk.ZQuery1.ExecSQL;
   // Завершение транзакции
       Zconnection1.Commit;
    showmessagealt('Транзакция завершена УСПЕШНО !!!');
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
   UpdateGridATS();
 end;
end;

//*********************************   ДОБАВИТЬ  ***********************************
procedure TFormsk.BitBtn1Click(Sender: TObject);
begin
 formsk.Edit1.Visible:=false;
  fl_Edit_kontr:=1; //флаг операции
  Form20:=TForm20.create(self);
  Form20.ShowModal;
  FreeAndNil(Form20);
  filtr:=0;
   stroka:='';
  FormSK.UpdateGrid();
  FormSK.Stringgrid1.Row:=FormSK.Stringgrid1.RowCount-1;
end;

//*********************************   Отчет АСТРАднищам  ***********************************
procedure TFormsk.BitBtn11Click(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  tekkontr:='';
    If trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row])='' then
    begin
      showmessagealt('Сначала выберите контрагента !');
      exit;
    end;

    tekkontr:=formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row];

  //запоминаем текущую строку
  cur_row:=0;
  If (formsk.StringGrid1.RowCount>0) AND (formsk.Stringgrid1.Row>0) then
    begin
      cur_row:=formsk.Stringgrid1.Row;
    end;



  //If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
  Form27:=TForm27.create(self);
  Form27.ShowModal;
  FreeAndNil(Form27);
  //formsk.UpdateGrid();
  If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
end;

//************************************ УДАЛИТЬ КОНТРАГЕНТА ******************************
procedure TFormsk.BitBtn2Click(Sender: TObject);
var
  sstr : string;
  resF : byte;
begin
  With FormSK do
  begin
   formsk.Edit1.Visible:=false;
  //Удаляем запись
   if (trim(StringGrid1.Cells[2,StringGrid1.row])='') or (StringGrid1.RowCount=1) then
     begin
       showmessagealt('Не выбрана запись для удаления !');
       exit;
     end;

 IF dialogs.MessageDlg('Удалить выбранного контрагента ?',mtConfirmation,[mbYes,mbNO], 0)<>6 then exit;

 //**************** проверка на возможность удаления записи  *****************************************
  sstr :='av_spr_kontr_dog.id_kontr,av_spr_kontr_license.id_kontr,av_spr_kontr_ats.id_kontr,av_shedule_atp.id_kontr,av_shedule_ats.id_kontr,';
  resF := DelCheck(FormSK.StringGrid1, 1, FormSK.ZConnection1, FormSK.ZQuery1, sstr);
  IF resF<>1 then exit;
      // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
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
     ZQuery1.SQL.Clear;
     ZQuery1.SQL.add('UPDATE av_spr_kontragent SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE id='+trim(StringGrid1.Cells[1,StringGrid1.row])+' and del=0;');
     ZQuery1.ExecSQL;
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
   filtr:=0;
   stroka:='';
   UpdateGrid();
   FormSK.Stringgrid1.Row:=FormSK.Stringgrid1.RowCount-1;
  end;
end;

//************************************   ИЗМЕНИТЬ  ********************************
procedure TFormsk.BitBtn12Click(Sender: TObject);
begin
   with Formsk.StringGrid1 do
   begin
   formsk.Edit1.Visible:=false;
   //Редактируем запись контрагента
  if (trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row])='') or (Formsk.StringGrid1.RowCount=1) then
    begin
      showmessagealt('Не выбрана запись для редактирования !');
      exit;
    end;

  fl_Edit_kontr:=2; //флаг операции
    //запоминаем текущую строку
  cur_row:=0;
  If (formsk.StringGrid1.RowCount>0) AND (formsk.Stringgrid1.Row>0) then
    begin
      cur_row:=formsk.Stringgrid1.Row;
    end;
  //If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
  Form20:=TForm20.create(self);
  Form20.ShowModal;
  FreeAndNil(Form20);
  FormSK.UpdateGrid();
  If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
 end;
end;



//********************************************** ОБНОВИТЬ ИЗ 1С **************************************************
procedure TFormsk.BitBtn3Click(Sender: TObject);
var
 szap,comma,stim,ssd,ttabl1,ttabl2: string;
 widezap: widestring;
 bCH,bDog,bVid,bLic: byte;
 chislo : longint;
 kolvo, n: integer;
 sstr:string;
begin
  if not(dialogs.MessageDlg('Вы действительно хотите обновить данные из 1С ?',mtConfirmation,[mbYes,mbNO], 0)=6) then
     begin
       exit;
     end;
   bCH:=0;
   bDog:=0;
   bVid:=0;
   bLic:=0;
   kolvo:=0;
   szap:='';
   comma:=',';
   with FormSK do
   begin
  // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;

//****************************************************************  обновление контрагентов **************
 //ищем удаленных из 1С   ****************************************
   szap:='Select id FROM av_spr_kontragent as a WHERE a.del=0 AND a.kod1c>0 AND NOT EXISTS (SELECT kod1c FROM av_1c_kontr AS b WHERE b.kod1c=a.kod1c)';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add(szap+';');
 //  showmessagealt(ZQuery1.SQL.Text);
   try
      ZQuery1.Open;
   except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;

  if ZQuery1.RecordCount>0 then
  begin
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
   kolvo:=ZQuery1.RecordCount;
   //помечаем на удаление
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('UPDATE av_spr_kontragent SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
   szap:='';
   ZQuery1.ExecSQL;

  // Завершение транзакции
   Zconnection1.Commit;
    showmessagealt('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
    bCH:=1;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

  //ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kod1c FROM av_1c_kontr AS a ');
   szap:='WHERE a.kod1c>0 AND NOT EXISTS (SELECT kod1c FROM av_spr_kontragent AS b WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0);';
   ZQuery1.SQL.add(szap);
  // showmessagealt(ZQuery1.SQL.Text);
   try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x01'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpK'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,');
  ZQuery1.SQL.Add('adrpos character(200) NOT NULL,adrelect character(200) NOT NULL,tel character(50) NOT NULL,docsr character(30) NOT NULL,docnom character(30) NOT NULL,docorgv character(50) NOT NULL,');
  ZQuery1.SQL.Add('docdatv date,grprosv smallint NOT NULL DEFAULT 0,gorod character(60) NOT NULL,podr character(60) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT row_number() over (order by a.kod1c)+coalesce((select max(id) from av_spr_kontragent),0) as id,* FROM av_1c_kontr AS a '+szap);
  ZQuery1.ExecSQL;
  //добавляем новые записи в таблицу контрагентов
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) ');
  ZQuery1.SQL.Add('SELECT id,now(),0,'+intTostr(id_user)+',name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,docsr || '+QuotedStr(comma)+' || docnom || '+QuotedStr(comma)+' || docorgv || ');
  ZQuery1.SQL.Add(QuotedStr(comma)+' || coalesce('''' || docdatv || '''','''') AS document,now(),'+intTostr(id_user)+' FROM '+ttabl1+';');
  ZQuery1.ExecSql;

   // Завершение транзакции
   Zconnection1.Commit;
    showmessagealt('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'Добавлено  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bCH:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

   //ищем отредактированные в 1с   ********************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT a.kod1c FROM av_1c_kontr AS a,av_spr_kontragent AS b ');
   ZQuery1.SQL.add('WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0 AND NOT(a.name=b.name AND a.polname=b.polname AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos ');
   ZQuery1.SQL.add('AND a.tel=b.tel AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
 //showmessagealt(ZQuery1.SQL.text);
  try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
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
  kolvo:=ZQuery1.RecordCount;
  DateTimeToString(stim,'hhmmzzz',now);
  Randomize;
  chislo:=Random(200)+1;
  try
  chislo:=ABS(chislo*StrToInt(stim));
  except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x02'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
  ttabl2:='tmpK'+IntToStr(chislo);
  ZQuery1.SQL.Clear;
  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl2+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL,polname character(200) NOT NULL,');
  ZQuery1.SQL.Add('vidkontr character(50) NOT NULL,inn character(20) NOT NULL,okpo character(15) NOT NULL,adrur character(200) NOT NULL,');
  ZQuery1.SQL.Add('adrpos character(200) NOT NULL,tel character(50) NOT NULL,document character(200) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl2+' SELECT b.id,a.kod1c,a.name,a.polname,a.vidkontr,a.inn,a.okpo,a.adrur,a.adrpos,a.tel,a.docsr || '+QuotedStr(comma));
  ZQuery1.SQL.Add(' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''','''') AS document FROM av_1c_kontr AS a ');
  ZQuery1.SQL.Add('LEFT JOIN av_spr_kontragent AS b USING (kod1c) ');
  ZQuery1.SQL.Add('WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0 AND NOT(a.name=b.name AND a.polname=b.polname ');
  ZQuery1.SQL.Add('AND a.vidkontr=b.vidkontr AND a.inn=b.inn AND a.okpo=b.okpo AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel ');
  ZQuery1.SQL.Add('AND a.adrur=b.adrur AND a.adrpos=b.adrpos AND a.tel=b.tel AND (a.docsr || '+QuotedStr(comma)+' || a.docnom || '+QuotedStr(comma)+' || a.docorgv || '+QuotedStr(comma)+' || coalesce('''' || a.docdatv || '''',''''))=b.document);');
  ZQuery1.ExecSQL;

  //помечаем на удаление прежние записи
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('UPDATE av_spr_kontragent SET del=1,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN (SELECT id FROM '+ttabl2+');');
  ZQuery1.ExecSQL;
 //
  //добавляем новые записи в таблицу контрагентов
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first) ');
  ZQuery1.SQL.Add('SELECT id,now(),0,'+intTostr(id_user)+',name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,NULL,NULL FROM '+ttabl2+';');
  //INSERT INTO av_spr_kontragent(id,createdate,del,id_user,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,createdate_first,id_user_first)
  //SELECT id,now(),0,1,name,polname,kod1c,vidkontr,inn,okpo,adrur,adrpos,tel,document,now(),1 FROM ttabl2;
  ZQuery1.ExecSQL;

   // Завершение транзакции
   Zconnection1.Commit;
    showmessagealt('КОНТРАГЕНТЫ. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bCH:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
   end;

// *************************************************************


// ************************************************  обновление договоров ***************************
//ищем удаленных из 1С   ****************************************
   szap:='Select id FROM av_spr_kontr_dog as a WHERE a.del=0 AND a.kod1c>0 AND NOT EXISTS (SELECT kod1c FROM av_1c_kontr_dog AS b WHERE b.kod1c=a.kod1c AND b.kodkont=a.kodkont AND a.kod1c>0)';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add(szap+';');
 //  showmessagealt(ZQuery1.SQL.Text);
   try
      ZQuery1.Open;
   except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;

  if ZQuery1.RecordCount>0 then
  begin
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
   kolvo:=ZQuery1.RecordCount;
   //помечаем на удаление
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('UPDATE av_spr_kontr_dog SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
   szap:='';
   ZQuery1.ExecSQL;

  // Завершение транзакции
   Zconnection1.Commit;
    showmessagealt('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       bDog:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

  //****************  ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kodkont FROM av_1c_kontr_dog AS a ');
   szap:='WHERE NOT EXISTS (SELECT kodkont FROM av_spr_kontr_dog AS b WHERE b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.kod1c>0 AND b.del=0);';
   ZQuery1.SQL.add(szap);
//  showmessagealt(ZQuery1.SQL.text);
   try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x03'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpDog'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
//  ZQuery1.SQL.Add('CREATE TABLE '+ ttabl1 +' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(200) NOT NULL,datazak date,datavoz date,datapog date,');
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ ttabl1 +' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(200) NOT NULL,datazak date,datavoz date,datapog date,');
  ZQuery1.SQL.Add('val character(20) NOT NULL,datanacsh date,dataprsh date,stav numeric(5,2) NOT NULL DEFAULT 0,viddog character(20) NOT NULL,podr character(50) NOT NULL,otcblm numeric(5,2) NOT NULL DEFAULT 0,otcbagm numeric(5,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('otcblp numeric(5,2) NOT NULL DEFAULT 0,otcbagp numeric(5,2) NOT NULL DEFAULT 0,komotd numeric(10,2) NOT NULL DEFAULT 0,med numeric(10,2) NOT NULL DEFAULT 0,ubor numeric(10,2) NOT NULL DEFAULT 0,stop numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('disp numeric(10,2) NOT NULL DEFAULT 0,voin numeric(5,2) NOT NULL DEFAULT 0,lgot numeric(5,2) NOT NULL DEFAULT 0,dopus numeric(5,2) NOT NULL DEFAULT 0,vidar character(200) NOT NULL,sumar numeric(20,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr1 numeric(10,2) NOT NULL DEFAULT 0,shtr11 numeric(10,2) NOT NULL DEFAULT 0,shtr2 numeric(10,2) NOT NULL DEFAULT 0,shtr3 numeric(10,2) NOT NULL DEFAULT 0,shtr4 numeric(10,2) NOT NULL DEFAULT 0,shtr41 numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr5 numeric(10,2) NOT NULL DEFAULT 0,shtr6 numeric(10,2) NOT NULL DEFAULT 0,shtr7 numeric(10,2) NOT NULL DEFAULT 0,edizm1 character(20) NOT NULL,edizm11 character(20) NOT NULL,edizm2 character(20) NOT NULL,edizm3 character(20) NOT NULL,');
  ZQuery1.SQL.Add('edizm4 character(20) NOT NULL,edizm41 character(20) NOT NULL,edizm5 character(20) NOT NULL,edizm6 character(20) NOT NULL,edizm7 character(20) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('insert into '+ ttabl1+' SELECT row_number() over (order by a.kodkont)+coalesce((select max(id) from av_spr_kontr_dog),0) as id,0 as id_kontr,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,');
  ZQuery1.SQL.Add('otcblm,otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7 FROM av_1c_kontr_dog AS a '+szap);
  ZQuery1.ExecSQL;

  //кол-во строк до заполнения
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT COUNT(*) FROM av_spr_kontr_dog;');
  ZQuery1.Open;
  kolvo:=0;
  if ZQuery1.RecordCount>0 then
   kolvo:= ZQuery1.FieldByName('count').AsInteger;

  //добавляем новые записи в таблицу договоров
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog (id,id_kontr,del,createdate,id_user,createdate_first,id_user_first,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,otcblm,');
  ZQuery1.SQL.add('otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7) ');
  ZQuery1.SQL.add('SELECT a.id,b.id as id_kontr,0,now(),'+inttostr(id_user)+',now(),'+inttostr(id_user)+',a.kodkont,a.kod1c,a.name,a.datazak,a.datavoz,a.datapog,a.val,a.datanacsh,a.dataprsh,a.stav,a.viddog,a.podr,a.otcblm,a.otcbagm,a.otcblp,a.otcbagp,');
  ZQuery1.SQL.add('a.komotd,a.med,a.ubor,a.stop,a.disp,a.voin,a.lgot,a.dopus,a.vidar,a.sumar,a.shtr1,a.shtr11,a.shtr2,a.shtr3,a.shtr4,a.shtr41,a.shtr5,a.shtr6,a.shtr7,a.edizm1,a.edizm11,a.edizm2,a.edizm3,a.edizm4,a.edizm41,a.edizm5,a.edizm6,a.edizm7 ');
  ZQuery1.SQL.add('FROM '+ ttabl1 +' as a JOIN av_spr_kontragent AS b ON a.kodkont=b.kod1c AND b.del=0 order by a.id;');
  ZQuery1.ExecSQL;

  //кол-во строк after заполнения
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('SELECT COUNT(*) FROM av_spr_kontr_dog;');
  ZQuery1.Open;
  if ZQuery1.RecordCount>0 then
   kolvo:= ZQuery1.FieldByName('count').AsInteger - kolvo;

  // Завершение транзакции
   Zconnection1.Commit;
    showmessagealt('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'Добавлено  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bDog:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;
 //  **************************************************
 //ищем отредактированные в 1С  ************************************************

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('Select a.kodkont,a.kod1c FROM av_1c_kontr_dog AS a ');
  widezap :='WHERE NOT EXISTS (SELECT b.kodkont FROM av_spr_kontr_dog AS b WHERE '+
  'b.kodkont=a.kodkont AND b.kod1c=a.kod1c AND b.kod1c>0 AND b.del=0 AND coalesce(a.datapog,''1.1.1970'')=coalesce(b.datapog,''1.1.1970'') AND coalesce(a.datazak,''1.1.1970'')=coalesce(b.datazak,''1.1.1970'') '+
  'AND coalesce(a.datavoz,''1.1.1970'')=coalesce(b.datavoz,''1.1.1970'') AND coalesce(a.datanacsh,''1.1.1970'')=coalesce(b.datanacsh,''1.1.1970'') AND coalesce(a.dataprsh,''1.1.1970'')=coalesce(b.dataprsh,''1.1.1970'') '+
  'AND a.name=b.name  AND a.stav=b.stav  AND a.val=b.val AND a.viddog=b.viddog '+
  'AND a.podr=b.podr AND a.otcblm=b.otcblm AND a.otcbagm=b.otcbagm AND a.otcblp=b.otcblp AND a.otcbagp=b.otcbagp AND a.komotd=b.komotd AND a.med=b.med AND a.ubor=b.ubor AND a.stop=b.stop AND a.disp=b.disp AND a.voin=b.voin AND ' +
  'a.lgot=b.lgot AND a.dopus=b.dopus AND a.vidar=b.vidar AND a.sumar=b.sumar AND a.shtr1=b.shtr1 AND a.shtr2=b.shtr2 AND a.shtr11=b.shtr11 AND '+
  'a.shtr3=b.shtr3 AND a.shtr4=b.shtr4 AND a.shtr41=b.shtr41 AND a.shtr5=b.shtr5 AND a.shtr6=b.shtr6 AND a.shtr7=b.shtr7 AND '+
  'a.edizm1=b.edizm1 AND a.edizm11=b.edizm11 AND a.edizm2=b.edizm2 AND a.edizm3=b.edizm3 AND a.edizm4=b.edizm4 AND a.edizm41=b.edizm41 AND a.edizm5=b.edizm5 AND a.edizm6=b.edizm6 AND a.edizm7=b.edizm7);';
  ZQuery1.SQL.add(widezap);
 // showmessagealt(ZQuery1.SQL.text);

  try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
   end;

   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x04'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpDog'+IntToStr(chislo);

   //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ ttabl1 +' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,del smallint NOT NULL DEFAULT 0, createdate timestamp without time zone NOT NULL DEFAULT now(),');
//  ZQuery1.SQL.Add('CREATE TABLE '+ ttabl1 +' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,del smallint NOT NULL DEFAULT 0, createdate timestamp without time zone NOT NULL DEFAULT now(),');
  ZQuery1.SQL.Add('id_user integer NOT NULL DEFAULT 0, createdate_first timestamp without time zone,id_user_first integer,');
  ZQuery1.SQL.Add('kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(200) NOT NULL,datazak date,datavoz date,datapog date,');
  ZQuery1.SQL.Add('val character(20) NOT NULL,datanacsh date,dataprsh date,stav numeric(5,2) NOT NULL DEFAULT 0,viddog character(20) NOT NULL,podr character(50) NOT NULL,otcblm numeric(5,2) NOT NULL DEFAULT 0,otcbagm numeric(5,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('otcblp numeric(5,2) NOT NULL DEFAULT 0,otcbagp numeric(5,2) NOT NULL DEFAULT 0,komotd numeric(10,2) NOT NULL DEFAULT 0,med numeric(10,2) NOT NULL DEFAULT 0,ubor numeric(10,2) NOT NULL DEFAULT 0,stop numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('disp numeric(10,2) NOT NULL DEFAULT 0,voin numeric(5,2) NOT NULL DEFAULT 0,lgot numeric(5,2) NOT NULL DEFAULT 0,dopus numeric(5,2) NOT NULL DEFAULT 0,vidar character(200) NOT NULL,sumar numeric(20,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr1 numeric(10,2) NOT NULL DEFAULT 0,shtr11 numeric(10,2) NOT NULL DEFAULT 0,shtr2 numeric(10,2) NOT NULL DEFAULT 0,shtr3 numeric(10,2) NOT NULL DEFAULT 0,shtr4 numeric(10,2) NOT NULL DEFAULT 0,shtr41 numeric(10,2) NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('shtr5 numeric(10,2) NOT NULL DEFAULT 0,shtr6 numeric(10,2) NOT NULL DEFAULT 0,shtr7 numeric(10,2) NOT NULL DEFAULT 0,edizm1 character(20) NOT NULL,edizm11 character(20) NOT NULL,edizm2 character(20) NOT NULL,edizm3 character(20) NOT NULL,');
  ZQuery1.SQL.Add('edizm4 character(20) NOT NULL,edizm41 character(20) NOT NULL,edizm5 character(20) NOT NULL,edizm6 character(20) NOT NULL,edizm7 character(20) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

   //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('insert into '+ ttabl1+' SELECT 0 as id,0 as id_kontr,0 as del,now() as createdate,'+inttostr(id_user)+' as id_user,NULL as createdate_first,NULL as id_user_first,* ');
  ZQuery1.SQL.add('FROM av_1c_kontr_dog as a '+widezap);
//  showmessagealt(ZQuery1.SQL.text);
  ZQuery1.ExecSQL;

   //*** помечаем на удаление устаревшие записи
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE av_spr_kontr_dog SET del=1,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND kod1c>0 AND id IN (');
  ZQuery1.SQL.add('Select id FROM av_spr_kontr_dog AS a WHERE EXISTS(');
  ZQuery1.SQL.add('Select kodkont,kod1c from '+ ttabl1+' AS b WHERE a.kod1c=b.kod1c AND b.kodkont=a.kodkont));');
  ZQuery1.ExecSQL;


  //добавляем новые записи в таблицу договоров
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('INSERT INTO av_spr_kontr_dog (id,id_kontr,del,createdate,id_user,createdate_first,id_user_first,kodkont,kod1c,name,datazak,datavoz,datapog,val,datanacsh,dataprsh,stav,viddog,podr,otcblm,');
  ZQuery1.SQL.add('otcbagm,otcblp,otcbagp,komotd,med,ubor,stop,disp,voin,lgot,dopus,vidar,sumar,shtr1,shtr11,shtr2,shtr3,shtr4,shtr41,shtr5,shtr6,shtr7,edizm1,edizm11,edizm2,edizm3,edizm4,edizm41,edizm5,edizm6,edizm7) ');
  ZQuery1.SQL.add('SELECT b.id,b.id as id_kontr,0,a.createdate,a.id_user,NULL,NULL,a.kodkont,a.kod1c,a.name,a.datazak,a.datavoz,a.datapog,a.val,a.datanacsh,a.dataprsh,a.stav,a.viddog,a.podr,a.otcblm,a.otcbagm,a.otcblp,a.otcbagp,');
  ZQuery1.SQL.add('a.komotd,a.med,a.ubor,a.stop,a.disp,a.voin,a.lgot,a.dopus,a.vidar,a.sumar,a.shtr1,a.shtr11,a.shtr2,a.shtr3,a.shtr4,a.shtr41,a.shtr5,a.shtr6,a.shtr7,a.edizm1,a.edizm11,a.edizm2,a.edizm3,a.edizm4,a.edizm41,a.edizm5,a.edizm6,a.edizm7 ');
  ZQuery1.SQL.add('FROM '+ ttabl1+' as a JOIN av_spr_kontragent AS b ON a.kodkont=b.kod1c AND b.del=0 order by a.id;');
  ZQuery1.ExecSQL;

  // Завершение транзакции
   Zconnection1.Commit;
   showmessagealt('ДОГОВОРА. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bDog:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

 //***************************************************************** ВИДЫ ДОГОВОРОВ ***************************************************
 //ищем удаленных из 1С   ****************************************
   szap:='Select id FROM av_spr_kontr_viddog as a WHERE a.del=0 AND a.kod1c>0 AND NOT EXISTS (SELECT kod1c FROM av_1c_viddog AS b WHERE b.kod1c=a.kod1c AND a.kod1c>0)';
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add(szap+';');
   //showmessagealt(ZQuery1.SQL.Text);
   try
      ZQuery1.Open;
   except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;

  if ZQuery1.RecordCount>0 then
  begin
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
   kolvo:=ZQuery1.RecordCount;
   //помечаем на удаление
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.Add('UPDATE av_spr_kontr_viddog SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
   szap:='';
   ZQuery1.ExecSQL;

  //Завершение транзакции
  Zconnection1.Commit;
   showmessagealt('Виды ДОГОВОРОВ. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bDog:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

  //ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kod1c FROM av_1c_viddog AS a ');
   szap:='WHERE a.kod1c>0 AND trim(a.name)!='''' AND NOT EXISTS (SELECT kod1c FROM av_spr_kontr_viddog AS b WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0);';
   ZQuery1.SQL.add(szap);
  // showmessagealt(ZQuery1.SQL.text);
   try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x05'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpViddog'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
//  ZQuery1.SQL.Add('CREATE TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT row_number() over (order by a.kod1c)+coalesce((select max(id) from av_spr_kontr_viddog),0) as id,* FROM av_1c_viddog AS a '+szap);
  ZQuery1.ExecSQL;
  //добавляем новые записи в таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontr_viddog(id,kod1c,name,id_user,createdate,id_user_first,createdate_first,del) ');
  ZQuery1.SQL.Add('SELECT id,kod1c,name,'+intTostr(id_user)+',now(),'+intTostr(id_user)+',now(),0 as del FROM '+ttabl1+';');
  ZQuery1.ExecSQL;

  //Завершение транзакции
  Zconnection1.Commit;
   showmessagealt('Виды Договоров. Транзакция завершена УСПЕШНО !'+#13+'Добавлено  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bVid:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;
//****************************************************************************************************************
//ищем отредактированные в 1С  ************************************************

  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('Select a.kodkont,a.kod1c FROM av_1c_kontr_dog AS a ');
   szap :='WHERE NOT EXISTS (SELECT b.kodkont FROM av_spr_kontr_viddog AS b WHERE b.name=a.name AND b.kod1c=a.kod1c AND b.kod1c>0 AND b.del=0 );';
  ZQuery1.SQL.add(widezap);
 // showmessagealt(ZQuery1.SQL.text);

  try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
   end;

   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x06'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpViddog'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
//  ZQuery1.SQL.Add('CREATE TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,name character(100) NOT NULL) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;

  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT 0 as id,kod1c,name FROM av_1c_viddog AS a '+szap);
  ZQuery1.ExecSQL;

   //*** помечаем на удаление устаревшие записи
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE av_spr_kontr_viddog SET del=1,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND kod1c>0 AND id IN (');
  ZQuery1.SQL.add('Select id FROM av_spr_kontr_viddog AS a WHERE EXISTS(');
  ZQuery1.SQL.add('Select kod1c from '+ ttabl1+' AS b WHERE a.kod1c=b.kod1c));');
  ZQuery1.ExecSQL;

  //добавляем новые записи в таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontr_viddog(id,kod1c,name,id_user,createdate,id_user_first,createdate_first,del) ');
  ZQuery1.SQL.Add('SELECT b.id,a.kod1c,a.name,'+intTostr(id_user)+',now(),NULL,NULL,0 as del FROM '+ttabl1+' as a ');
  ZQuery1.SQL.add('JOIN av_spr_kontr_viddog AS b ON a.kod1c=b.kod1c AND b.del=0 order by a.id;');
  ZQuery1.ExecSQL;

  //Завершение транзакции
  Zconnection1.Commit;
   showmessagealt('Виды ДОГОВОРОВ. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bVid:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

//***************************************************************** ЛИЦЕНЗИИ ***************************************************
//ищем удаленных из 1С   ****************************************
  szap:='Select id FROM av_spr_kontr_license as a WHERE a.del=0 AND a.kod1c>0 AND NOT EXISTS (SELECT kod1c FROM av_1c_license AS b WHERE b.kod1c=a.kod1c AND b.kodkont=a.kodkont AND a.kod1c>0)';
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add(szap+';');
//  showmessagealt(ZQuery1.SQL.Text);
  try
     ZQuery1.Open;
  except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
  end;

 if ZQuery1.RecordCount>0 then
 begin
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
  kolvo:=ZQuery1.RecordCount;
  //помечаем на удаление
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('UPDATE av_spr_kontr_license SET del=2,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND id IN ('+szap+');');
  szap:='';
  ZQuery1.ExecSQL;

 // Завершение транзакции
 Zconnection1.Commit;
   showmessagealt('Лицензии. Транзакция завершена УСПЕШНО !'+#13+'УДАЛЕНО  '+intToStr(kolvo)+' записей !');
       kolvo:=0;
       bLic:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
 end;

  //ищем новые из 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kod1c FROM av_1c_license AS a ');
   szap:='WHERE a.kod1c>0 AND trim(a.name)!='''' AND NOT EXISTS (SELECT kod1c FROM av_spr_kontr_license AS b WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0) ORDER BY kod1c;';
   ZQuery1.SQL.add(szap);
  //showmessage(ZQuery1.SQL.text);
   try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    Zconnection1.disconnect;
    exit;
   end;
   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=ABS(chislo*StrToInt(stim));
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x07'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpLic'+IntToStr(chislo);

  //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
//  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+'
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('name character(200) NOT NULL,datanach date,dataok date) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT row_number() over (order by a.kod1c)+coalesce((select max(id) from av_spr_kontr_license),0) as id,0 as id_kontr, * FROM av_1c_license AS a '+szap);
  ZQuery1.ExecSQL;
  //добавляем новые записи в таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontr_license(id,id_kontr,kodkont,kod1c,name,datanach,dataok,id_user,createdate,id_user_first,createdate_first,del) ');
  ZQuery1.SQL.Add('SELECT a.id,b.id as id_kontr,a.kodkont,a.kod1c,a.name,a.datanach,a.dataok,'+intTostr(id_user)+',now(),'+intTostr(id_user)+',now(),0 as del ');
  ZQuery1.SQL.Add('FROM '+ttabl1+' as a JOIN av_spr_kontragent AS b ON a.kodkont=b.kod1c AND b.del=0 order by a.id;');
 //showmessagealt(ZQuery1.SQL.text);
  ZQuery1.ExecSQL;

  // Завершение транзакции
 Zconnection1.Commit;
   showmessagealt('ЛИЦЕНЗИИ. Транзакция завершена УСПЕШНО !'+#13+'ДОБАВЛЕНО  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bLic:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

//****************************************************************************************************************
//ищем отредактированные в 1С  ************************************************
   ZQuery1.SQL.Clear;
   ZQuery1.SQL.add('SELECT kod1c FROM av_1c_license AS a ');
   szap:='WHERE a.kod1c>0 AND trim(a.name)!='''' AND NOT EXISTS (SELECT kod1c FROM av_spr_kontr_license AS b WHERE a.kod1c=b.kod1c AND b.del=0 AND b.kod1c>0 AND '+
   'b.kodkont=a.kodkont AND coalesce(a.datanach,''1.1.1970'')=coalesce(b.datanach,''1.1.1970'') AND coalesce(a.dataok,''1.1.1970'')=coalesce(b.dataok,''1.1.1970'')) ORDER BY kod1c;';
   ZQuery1.SQL.add(szap);
  //showmessagealt(ZQuery1.SQL.text);

  try
    ZQuery1.Open;
   except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
    exit;
   end;

   if ZQuery1.RecordCount>0 then
   begin
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
   kolvo:=ZQuery1.RecordCount;
   DateTimeToString(stim,'hhmmzzz',now);
   Randomize;
   chislo:=Random(200)+1;
   try
   chislo:=chislo*StrToInt(stim);
   except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x08'+#13+'Значение: ' + stim);
       exit;
       end;
   end;
   ttabl1:='tmpLic'+IntToStr(chislo);

   //cоздаем временную таблицу для новых записей
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('CREATE LOCAL TEMPORARY TABLE '+ttabl1+' (id integer NOT NULL DEFAULT 0,id_kontr integer NOT NULL DEFAULT 0,kodkont integer NOT NULL DEFAULT 0,kod1c integer NOT NULL DEFAULT 0,');
  ZQuery1.SQL.Add('name character(200) NOT NULL,datanach date,dataok date) WITH (OIDS=FALSE);');
  ZQuery1.ExecSQL;
  //добавляем новые записи во временную таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO '+ttabl1+' SELECT 0 as id,0 as id_kontr, * FROM av_1c_license AS a '+szap);
  ZQuery1.ExecSQL;

   //*** помечаем на удаление устаревшие записи
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.add('UPDATE av_spr_kontr_license SET del=1,id_user='+inttostr(id_user)+',createdate=default WHERE del=0 AND kod1c>0 AND id IN (');
  ZQuery1.SQL.add('Select id FROM av_spr_kontr_license AS a WHERE EXISTS(');
  ZQuery1.SQL.add('Select kodkont,kod1c from '+ ttabl1+' AS b WHERE a.kod1c=b.kod1c AND b.kodkont=a.kodkont));');
 //showmessagealt(ZQuery1.SQL.text);
  ZQuery1.ExecSQL;

   //добавляем новые записи в таблицу
  ZQuery1.SQL.Clear;
  ZQuery1.SQL.Add('INSERT INTO av_spr_kontr_license(id,id_kontr,kodkont,kod1c,name,datanach,dataok,id_user,createdate,id_user_first,createdate_first,del) ');
  ZQuery1.SQL.Add('SELECT b.id,b.id as id_kontr,a.kodkont,a.kod1c,a.name,a.datanach,a.dataok,'+intTostr(id_user)+',now(),'+intTostr(id_user)+',now(),0 as del ');
  ZQuery1.SQL.Add('FROM '+ttabl1+' as a JOIN av_spr_kontragent AS b ON a.kodkont=b.kod1c AND b.del=0 order by a.id;');
  ZQuery1.ExecSQL;


   // Завершение транзакции
 Zconnection1.Commit;
   showmessagealt('ЛИЦЕНЗИИ. Транзакция завершена УСПЕШНО !'+#13+'Отредактировано  '+intToStr(kolvo)+' ЗАПИСЕЙ !');
       kolvo:=0;
       bLic:=1;
       ZQuery1.Close;
   except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
   end;
   Zconnection1.disconnect;
  end;

//************************************************************************************************************
  If bCH=0 then
     showmessagealt('Изменений в справочнике контрагентов НЕ ОБНАРУЖЕНО!');

  If bDog=0 then
     showmessagealt('Изменений в справочнике договоров НЕ ОБНАРУЖЕНО!');

  If bVid=0 then
     showmessagealt('Изменений в справочнике видов договоров НЕ ОБНАРУЖЕНО!');

  If bLic=0 then
     showmessagealt('Изменений в справочнике лицензий НЕ ОБНАРУЖЕНО!');

  Zconnection1.disconnect;

  RadioButton2.Checked:=false;
  RadioButton2.Checked:=true;
//  UpdateGrid();
 end;
end;

procedure TFormsk.BitBtn5Click(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
   if (formsk.StringGrid1.RowCount>1) then
    begin
     result_kontr_id:=trim(formsk.StringGrid1.Cells[1,formsk.StringGrid1.row]);
     formsk.close;
    end;
end;

//******************** ДОБАВИТЬ АТС ПЕРЕВОЗЧИКУ **********************************
procedure TFormsk.BitBtn6Click(Sender: TObject);
var
 n, new_id : integer;
 satp : string;
begin
  With FOrmsk do
  begin
  If not (RadioButton2.Checked) then
   begin
      showmessagealt('Контрагент НЕ имеет договор перевозки !');
      exit;
   end;
  result_name_ats := '';
  form13:=Tform13.create(self);
  form13.ShowModal;
  FreeAndNil(form13);

  // Заполняем поля для АТС
  if result_name_ats='' then exit;
 // Проверяем что такого АТС еще нет в списке
  if StringGrid2.RowCount>1 then
     begin
       for n:=1 to StringGrid2.RowCount-1 do
          begin
          try
              if strtoint(StringGrid2.Cells[0,n])=strtoint(result_name_ats) then
                 begin
                   showmessagealt('Добавляемое АТС уже присутствует в списке !'+#13+'Добавить данное АТС в список невозможно !');
                   exit;
                 end;
          except
       on exception: EConvertError do
       begin
       showmessagealt('ОШИБКА КОНВЕРТАЦИИ !!!'+'x09'+#13+'Значение: ' + result_name_ats);
       exit;
       end;
   end;
          end;
     end;


    // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      exit;
     end;
//Проверка, что АТС используется другим перевозчиком
    // ZQuery1.SQL.Clear;
    // ZQuery1.SQL.add('select id_kontr from av_spr_kontr_ats WHERE del=0 AND id_ats='+trim(result_name_ats)+';');
    //// showmessage(zquery1.SQL.Text);
    //try
    // ZQuery1.open;
    //except
    //  showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    //  ZQuery1.Close;
    //  Zconnection1.disconnect;
    //  exit;
    //end;
    //if ZQuery1.RecordCount>0 then
    //    begin
    //      satp := '';
    //      for n:=0 to ZQuery1.RecordCount-1 do
    //        begin
    //          satp:= satp+ Zquery1.FieldByName('id_kontr').AsString+',';
    //          Zquery1.Next;
    //        end;
    //      //удаляем последную запятую
    //      satp := copy(satp,1,length(satp)-1);
    //      //запрос имен контрагентов
    //       ZQuery1.SQL.Clear;
    //       ZQuery1.SQL.add('select name from av_spr_kontragent WHERE del=0 AND id IN ('+satp+');');
    //       try
    //         ZQuery1.open;
    //       except
    //         showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ ZQuery1.SQL.Text);
    //         ZQuery1.Close;
    //         Zconnection1.disconnect;
    //         exit;
    //       end;
    //       if ZQuery1.RecordCount>0 then
    //       begin
    //         satp := '';
    //         for n:=0 to ZQuery1.RecordCount-1 do
    //           begin
    //             satp := satp + Zquery1.FieldByName('name').AsString+ ',' +#13;
    //             Zquery1.Next;
    //           end;
    //       end;
    //      showmessagealt('Данное АТС уже имеется у следующих контрагентов:'+#13+satp);
    //      exit;
    //   end;
          {     try
      ZQuery1.SQL.Clear;
      ZQuery1.SQL.add('select * from av_spr_ats where id='+trim(result_name_ats)+';');
      ZQuery1.open;
     except
      showmessagealt('ОШИБКА запроса к базе данных !'+#13+ZQuery1.SQL.Text);
      Zconnection1.disconnect;
      result_name_ats:='';
      exit;
     end;
     if ZQuery1.RecordCount=0 then
        begin
          ZQuery1.Close;
          ZConnection1.Disconnect;
          result_name_ats:='';
          exit;
        end;
     result_name_ats:='';
     }
     // Записываем как новую запись
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
     //Определяем текущий id+1
        new_id := 0;
        ZQuery2.SQL.Clear;
        ZQuery2.SQL.add('SELECT MAX(id) as maxid FROM av_spr_kontr_ats WHERE del=0;');
        ZQuery2.open;
        new_id:=ZQuery2.FieldByName('maxid').asInteger+1;

     ZQuery2.SQL.Clear;
     ZQuery2.SQL.add('INSERT INTO av_spr_kontr_ats(id_kontr,id_ats,createdate,id_user,del,id_user_first,createdate_first,id) VALUES (');
     ZQuery2.SQL.add(trim(StringGrid1.Cells[1,StringGrid1.row])+','+result_name_ats+',');
     ZQuery2.SQL.add('now(),'+ inttostr(id_user)+',0,' + inttostr(id_user)+',now(),'+inttostr(new_id)+');');
     ZQuery2.ExecSQL;

  //Завершение транзакции
   Zconnection1.Commit;
  // showmessagealt('Транзакция завершена УСПЕШНО !!!');
 except
     ZConnection1.Rollback;
     showmessagealt('Данные не записаны !'+#13+'Не удается завершить транзакцию !!!'+#13+'Запрос SQL: '+ZQuery1.SQL.Text);
     ZQuery1.Close;
     ZQuery2.Close;
     exit;
 end;
     ZQuery1.Close;
     ZQuery2.Close;
     ZConnection1.Disconnect;
     UpdateGridATS();
  end;
end;

//************************************* ДОГОВОРА ****************************************
procedure TFormsk.BitBtn7Click(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  tekkontr:='';
    If trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row])='' then
    begin
      showmessagealt('Сначала выберите контрагента !');
      exit;
    end;

    tekkontr:=formsk.StringGrid1.Cells[1,formsk.StringGrid1.Row];

  //запоминаем текущую строку
  cur_row:=0;
  If (formsk.StringGrid1.RowCount>0) AND (formsk.Stringgrid1.Row>0) then
    begin
      cur_row:=formsk.Stringgrid1.Row;
    end;



  //If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
  Form23:=TForm23.create(self);
  Form23.ShowModal;
  FreeAndNil(Form23);
  formsk.UpdateGrid();
  If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
end;

///*************************************** ЛИЦЕНЗИИ *************************************
procedure TFormsk.BitBtn8Click(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
   If trim(Formsk.StringGrid1.Cells[1,Formsk.StringGrid1.row])='' then
    begin
      showmessagealt('Сначала выберите контрагента !');
      exit;
    end;
   //запоминаем текущую строку
  cur_row:=0;
  If (formsk.StringGrid1.RowCount>0) AND (formsk.Stringgrid1.Row>0) then
    begin
      cur_row:=formsk.Stringgrid1.Row;
    end;
  //If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
  FormLic:=TFormLic.create(self);
  FormLic.ShowModal;
  FreeAndNil(FormLic);
  formsk.UpdateGrid();
    If cur_row>0 then formSK.Stringgrid1.Row:=cur_row;
end;

procedure TFormsk.CheckBox1Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  filtr:=0;
   stroka:='';
  formsk.UpdateGrid();
  formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.CheckBox2Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  filtr:=0;
   stroka:='';
  formsk.UpdateGrid();
  formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.CheckBox3Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  filtr:=0;
   stroka:='';
  formsk.UpdateGrid();
  formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.CheckBox4Change(Sender: TObject);
begin
  formsk.Edit1.Visible:=false;
  filtr:=0;
   stroka:='';
  formsk.UpdateGrid();
  formsk.StringGrid1.SetFocus;
end;

procedure TFormsk.CheckBox5Change(Sender: TObject);
begin
   formsk.Edit1.Visible:=false;
  filtr:=0;
   stroka:='';
  formsk.UpdateGrid();
  formsk.StringGrid1.SetFocus;
end;

//********************************** отфильтровать грид ******************
procedure TFormSK.Edit1Change(Sender: TObject);
begin
If  formSk.IdleTimer3.Enabled=false then
     formSK.IdleTimer3.Enabled:=true;
  If  formSK.IdleTimer3.AutoEnabled=false then
     formSK.IdleTimer3.AutoEnabled:=true;
end;



//контекстный поиск
procedure TFormsk.IdleTimer3Timer(Sender: TObject);
var
  typ:byte=0;
  ss:string='';
  n:integer=0;
begin
  with FOrmSk do
begin
  ss:=trimleft(Edit1.Text);
  filtr:=0;
  stroka:='';
  if UTF8Length(ss)>0 then
       begin
         //определяем тип данных для поиска
         for n:=1 to UTF8Length(ss) do
           begin
             //если хоть один нецифровой символ, тогда отвал и поиск строковых значений
              if not(ss[n] in ['0'..'9']) then
                begin
                typ:=2;
                break;
                end;
           end;
            if typ=2 then
             begin
             filtr:=2;
             stroka:=ss;
             end
           else
             begin
             filtr:=1;
             stroka:=ss;
             end;
         updategrid();
       end
  else
     begin
      updategrid();
      Edit1.Visible:=false;
     end;
   formSK.IdleTimer3.AutoEnabled:=false;
   formSK.IdleTimer3.Enabled:=false;
end;
end;


//************************************************* HOTKEYS ********************************************************************
procedure TFormsk.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  with FormSk do
  begin
    //поле поиска
  If Edit1.Visible then
    begin
      If not Edit1.Focused then Edit1.SetFocus;
    // ESC поиск // Вверх по списку   // Вниз по списку
  if (Key=27) OR (Key=38) OR (Key=40) then
     begin
       Edit1.Visible:=false;
       StringGrid1.SetFocus;
       key:=0;
       exit;
     end;
      // ENTER - остановить контекстный поиск
   if (Key=13) then
     begin
       StringGrid1.SetFocus;
       //exit;
     end;

    end;

    // Контекcтный поиск
   if (Edit1.Visible=false) AND not SpinEdit1.Focused AND not SpinEdit2.Focused then
     begin
       If (get_type_char(key)>0) or (key=8) or (key=46) or (key=96) then //8-backspace 46-delete 96- numpad 0
       begin
         Edit1.text:='';
         Edit1.Visible:=true;
         Edit1.SetFocus;
       end;
     end;
   // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[F2] - Договора'+#13+'[F3] - добавить АТС'+#13+'[F4] - Изменить'+#13+'[F5] - Добавить'+#13+'[F8] - Удалить'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
    //F2 - Договора
    if (Key=113) and (bitbtn7.enabled=true) then  bitbtn7.click;
    //F3 - ATC
    if (Key=114) and (bitbtn6.enabled=true) then  bitbtn6.click;
    //F4 - Изменить
    if (Key=115) and (bitbtn12.enabled=true) then  BitBtn12.Click;
    //F5 - Добавить
    if (Key=116) and (bitbtn1.enabled=true) then  BitBtn1.Click;
    //F7 - Поиск
    //if (Key=118) then ToolButton8.Click;
    //F8 - Удалить
    if (Key=119) and (bitbtn2.enabled=true) then  BitBtn2.Click;
    // ESC
    if (Key=27) then  Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32) and (StringGrid1.Focused) then BitBtn5.Click;

   if (Key=112) or (Key=113) or (Key=114) or (Key=115) or (Key=116) or (Key=27) or (Key=13)  then Key:=0;
  end;
end;

procedure TFormsk.FormShow(Sender: TObject);
 begin
 with formsk do
   begin
 // per:=2;
     if (flag_access=1) or (fl_print=1) then
     begin
        BitBtn1.Enabled:=false;
        BitBtn2.Enabled:=false;
        BitBtn12.Enabled:=false;
       end;
    If (fl_print=1) then
    begin
       GroupBox1.Enabled:=false;
       GroupBox2.Enabled:=false;
    end;
   StringGrid1.ColWidths[0]:=0;
   StringGrid1.ColWidths[3]:=0;
   StringGrid1.ColWidths[5]:=0;
   StringGrid1.ColWidths[6]:=0;
   StringGrid1.ColWidths[7]:=0;
   StringGrid1.ColWidths[8]:=0;
   StringGrid1.ColWidths[9]:=0;
   StringGrid1.ColWidths[10]:=0;
   StringGrid1.ColWidths[11]:=0;
   StringGrid1.ColWidths[12]:=0;
   StringGrid1.ColWidths[13]:=0;
   StringGrid1.ColWidths[14]:=0;
   StringGrid1.RowHeights[0]:=30;
   filtr:=0;
   stroka:='';
   cur_row:=0;
   end;
end;

procedure TFormsk.FormActivate(Sender: TObject);
begin
  if not FormActivated then begin
    FormActivated := True;
   UpdateGrid();
   Stringgrid1.Row:=Stringgrid1.RowCount-1;
  end;
end;


end.

