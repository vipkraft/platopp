unit kontr1c;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, FileUtil, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc;

type

  { TForm21 }

  TForm21 = class(TForm)
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Image3: TImage;
    ImageList1: TImageList;
    Label2: TLabel;
    Label4: TLabel;
    ProgressBar1: TProgressBar;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ZConnection1: TZConnection;
    ZQuery1: TZQuery;
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form21: TForm21;

implementation
 uses
  mainopp,kontr_main,kontr_edit;
{$R *.lfm}

{ TForm21 }

//************************************************ ОБРАБОТЧИК НАЖАТИЯ КЛАВИШИ  ******************************************
procedure TForm21.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
      begin
        Form21.Edit1.SetFocus;
      end;
    //ENTER - ПОИСК
    if (Key=13) and (form21.Edit1.Focused) then Form21.ToolButton8.Click;
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then Form21.Close;
    //F7 - Поиск
    //if (Key=118) then form21.ToolButton8.Click;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32) AND (Form21.StringGrid1.Focused=true) then Form21.BitBtn5.Click ;
    if (Key=112) OR (Key=27) OR (Key=13)   then Key := 0;
end;


//*****************************************************  СОРТИРОВКА ********************************************
procedure TForm21.ToolButton1Click(Sender: TObject);
begin
  SortGrid(Form21.StringGrid1,Form21.StringGrid1.col,Form21.ProgressBar1,0,1);
end;

//*****************************************************  ПОИСК В ГРИДЕ ****************************************
procedure TForm21.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(Form21.StringGrid1,Form20.Edit1);
end;

//********************************************** отмена ***********************************************************
procedure TForm21.BitBtn4Click(Sender: TObject);
begin
  Form21.close;
end;

// ********************************************        ВЫБРАТЬ    *****************************************************
procedure TForm21.BitBtn5Click(Sender: TObject);
begin
  with Form21.StringGrid1 do
  begin
//  masedit[0]:=Cells[0,row];//id
  Form20.Edit2.Text:=Cells[2,row];//наименование
  Form20.Edit3.Text:=Cells[3,row];//полное имя
  Form20.Edit7.Text:=Cells[1,row];//код 1с
  Form20.Edit5.Text:=Cells[4,row];//тип
  Form20.Edit8.Text:=Cells[5,row];//инн
  Form20.Edit9.Text:=Cells[6,row];//окпо
  Form20.Edit4.Text:=Cells[7,row];//адрес юридический
  Form20.Edit10.Text:=Cells[9,row];//телефон
  Form20.Memo1.Text:=Cells[10,row];//документ
  //Form20.Edit6.Text:=Cells[8,row];//adres
  end;
 // result_name:=Form21.StringGrid1.Cells[0,Form21.StringGrid1.row];
  vibor:=1;  //флаг выбора
  Form21.close;

end;


//***********************************************  Активация формы ******************************************************
procedure TForm21.FormShow(Sender: TObject);
var
   n:integer;
   ssel,spassport:string;
begin
 With Form21 do
 begin
 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   Form21.ZQuery1.SQL.Clear;
   Form21.ZQuery1.SQL.add('Select * FROM av_1c_kontr ');
   ssel:='WHERE';
   //имя контрагента
   if not(trim(Form20.Edit2.text)='') then ssel:=ssel+' upper(name) LIKE upper('+Quotedstr(trim(Form20.Edit2.text)+'%')+')';
   //полное имя
   if not(trim(Form20.Edit3.text)='') then
     begin
      If ssel<>'WHERE' then ssel:=ssel+' AND ';
      ssel:=ssel+' upper(polname) LIKE upper('+Quotedstr(trim(Form20.Edit3.text)+'%')+')';
     end;
   //код 1С
   if not ((trim(Form20.Edit7.text)='') OR (trim(Form20.Edit7.text)='0')) then
     begin
      If ssel<>'WHERE' then ssel:=ssel+' AND ';
      ssel:=ssel+' kod1c = '+Form20.Edit7.text;
     end;
   //ИНН
   if not(trim(Form20.Edit8.text)='') then
     begin
      If ssel<>'WHERE' then ssel:=ssel+' AND ';
      ssel:=ssel+' upper(inn) LIKE upper('+Quotedstr('%'+trim(Form20.Edit8.text)+'%')+')';
     end;

   //Если какие-либо из вышеперечисленных полей заполнены, добавляем в запрос поиск по ним
   If ssel<>'WHERE' then
      Form21.ZQuery1.SQL.add(ssel);
   Form21.ZQuery1.SQL.add(' ORDER BY name;');
   //showmessage(ZQuery1.SQL.text);
   try
        ZQuery1.open;
    except
       showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    end;
    If ZQuery1.RecordCount<1 then exit;
   if Form21.ZQuery1.RecordCount=0 then
     begin
      Form21.ZQuery1.Close;
      Form21.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   Form21.ProgressBar1.Max:=Form21.ZQuery1.RecordCount;
   Form21.ProgressBar1.Visible:=true;
   Form21.StringGrid1.RowCount:=Form21.ZQuery1.RecordCount+1;
   for n:=1 to Form21.ZQuery1.RecordCount do
    begin
      Form21.ProgressBar1.Position:=Form21.ProgressBar1.Position+1;
      Form21.ProgressBar1.Refresh;

      Form21.StringGrid1.Cells[0,n]:=IntToStr(n);
      Form21.StringGrid1.Cells[1,n]:=Form21.ZQuery1.FieldByName('kod1c').asString;
      Form21.StringGrid1.Cells[2,n]:=Form21.ZQuery1.FieldByName('name').asString;
      Form21.StringGrid1.Cells[3,n]:=Form21.ZQuery1.FieldByName('polname').asString;
      Form21.StringGrid1.Cells[4,n]:=Form21.ZQuery1.FieldByName('vidkontr').asString;
      Form21.StringGrid1.Cells[5,n]:=Form21.ZQuery1.FieldByName('inn').asString;
      Form21.StringGrid1.Cells[6,n]:=Form21.ZQuery1.FieldByName('okpo').asString;
      Form21.StringGrid1.Cells[7,n]:=Form21.ZQuery1.FieldByName('adrur').asString;
      Form21.StringGrid1.Cells[8,n]:=Form21.ZQuery1.FieldByName('adrpos').asString;
      Form21.StringGrid1.Cells[9,n]:=Form21.ZQuery1.FieldByName('tel').asString;
      //колонка пасспортных данных
    {  spassport := '';
      If trim(Form21.ZQuery1.FieldByName('docsr').asString)<>'' then
        spassport := Form21.ZQuery1.FieldByName('docsr').asString+','+
                   Form21.ZQuery1.FieldByName('docnom').asString+','+
                   Form21.ZQuery1.FieldByName('docorgv').asString+','+
                   FormatDateTime('yyyy-mm-dd',Form21.ZQuery1.FieldByName('docdatv').AsDateTime)
      else
          begin
            If trim(Form21.ZQuery1.FieldByName('docnom').asString)='' then
              begin
              If trim(Form21.ZQuery1.FieldByName('docorgv').asString)='' then
                begin
                If trim(Form21.ZQuery1.FieldByName('docdatv').asString)<>'' then
                 spassport := ','+FormatDateTime('yyyy-mm-dd',Form21.ZQuery1.FieldByName('docdatv').AsDateTime);
                end
              else
                spassport := ','+Form21.ZQuery1.FieldByName('docorgv').asString+','+
                          FormatDateTime('yyyy-mm-dd',Form21.ZQuery1.FieldByName('docdatv').AsDateTime);

              end
            else
               spassport := ','+Form21.ZQuery1.FieldByName('docnom').asString+','+
                   Form21.ZQuery1.FieldByName('docorgv').asString+','+
                   FormatDateTime('yyyy-mm-dd',Form21.ZQuery1.FieldByName('docdatv').AsDateTime);
          end;
      }
      spassport := Form21.ZQuery1.FieldByName('docsr').asString+','+
                   Form21.ZQuery1.FieldByName('docnom').asString+','+
                   Form21.ZQuery1.FieldByName('docorgv').asString+',';

       If trim(Form21.ZQuery1.FieldByName('docdatv').asString)<>'' then
             spassport :=  spassport+FormatDateTime('yyyy-mm-dd',Form21.ZQuery1.FieldByName('docdatv').AsDateTime);
       ////////////////////////////////////////////////////////////////////////

        Form21.StringGrid1.Cells[10,n]:=spassport;

//      ************************
      Form21.ZQuery1.Next;
    end;
   Form21.ProgressBar1.Position:=0;
   Form21.ProgressBar1.Visible:=false;
   Form21.ZQuery1.Close;
   Form21.Zconnection1.disconnect;
 end;
end;


end.

