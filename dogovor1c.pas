unit dogovor1c;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, ZDataset, ZConnection, LazFileUtils, Forms, Controls, Graphics,
  Dialogs, Grids, Buttons, ComCtrls, StdCtrls, ExtCtrls,platproc;

type

  { TForm25 }

  TForm25 = class(TForm)
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
    procedure StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
      aRect: TRect; aState: TGridDrawState);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);

  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form25: TForm25;

implementation
 uses
  mainopp,dogovor,dogovor_edit;
{$R *.lfm}

{ TForm25 }

//************************************************ ОБРАБОТЧИК НАЖАТИЯ КЛАВИШИ  ******************************************
procedure TForm25.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  // Автоматический контекстный поиск
    if (GetSymKey(char(Key))=true) then
      begin
        Form25.Edit1.SetFocus;
      end;
     // ENTER - ПОИСК
    if (Key=13) and (Form25.Edit1.Focused) then fORM25.ToolButton8.Click;
    // F1
    if Key=112 then showmessagealt('[F1] - Справка'+#13+'[ENTER] - начать поиск'+#13+'[ПРОБЕЛ] - Выбрать'+#13+'[ESC] - Отмена\Выход');
    // ESC
    if Key=27 then Form25.Close;
    // ПРОБЕЛ - ВЫБРАТЬ
    if (Key=32) AND (FORM25.StringGrid1.Focused=true) then Form25.BitBtn5.Click ;

    if (Key=112) or (Key=113) or (Key=120) or (Key=27)   then Key:=0;

end;



//*****************************************************  СОРТИРОВКА ********************************************
procedure TForm25.ToolButton1Click(Sender: TObject);
begin
  SortGrid(Form25.StringGrid1,Form25.StringGrid1.col,Form25.ProgressBar1,0,1);
end;

//*****************************************************  ПОИСК В ГРИДЕ ****************************************
procedure TForm25.ToolButton8Click(Sender: TObject);
begin
   GridPoisk(Form25.StringGrid1,Form24.Edit1);
end;

//********************************************** отмена ***********************************************************
procedure TForm25.BitBtn4Click(Sender: TObject);
begin
  Form25.close;
end;

// ********************************************        ВЫБРАТЬ    *****************************************************
procedure TForm25.BitBtn5Click(Sender: TObject);
begin
  with Form24 ,Form25.StringGrid1 do
  begin
      Edit2.Text:=Form25.StringGrid1.Cells[2,row];//наименование
      DateEdit1.Text:=Form25.StringGrid1.Cells[5,row];//дата заключения договора
      DateEdit2.Text:=Form25.StringGrid1.Cells[6,row];//дата возникновения обязательств
      DateEdit3.Text:=Form25.StringGrid1.Cells[7,row];//дата погашения обязательств
      //SpinEdit9.value:=strToInt(Form25.StringGrid1.Cells[3,row]);//код контрагента
      //SpinEdit8.value:=strToInt(Form25.StringGrid1.Cells[1,row]);//код 1С
      FloatSpinEdit21.value:=strToFloat(Form25.StringGrid1.Cells[13,row]);//отчисления билетов МЖГ
      FloatSpinEdit22.value:=strToFloat(Form25.StringGrid1.Cells[14,row]);//отчисления багажа МЖГ
      FloatSpinEdit23.value:=strToFloat(Form25.StringGrid1.Cells[15,row]);//отчисления билетов ПРГ
      FloatSpinEdit24.value:=strToFloat(Form25.StringGrid1.Cells[16,row]);//отчисления багажа ПРГ
      FloatSpinEdit25.value:=strToFloat(Form25.StringGrid1.Cells[25,row]);//льготы
      FloatSpinEdit26.value:=strToFloat(Form25.StringGrid1.Cells[24,row]);//воинские
      FloatSpinEdit27.value:=strToFloat(Form25.StringGrid1.Cells[26,row]);//доп услуги
      FloatSpinEdit1.value:=strToFloat(Form25.StringGrid1.Cells[17,row]);//комната отдыха
      FloatSpinEdit2.value:=strToFloat(Form25.StringGrid1.Cells[18,row]);//медосмотр
      FloatSpinEdit3.value:=strToFloat(Form25.StringGrid1.Cells[19,row]);//уборка
      FloatSpinEdit4.value:=strToFloat(Form25.StringGrid1.Cells[20,row]);//стоянка
      FloatSpinEdit5.value:=strToFloat(Form25.StringGrid1.Cells[21,row]);//диспетчеризация
      FloatSpinEdit6.value:=strToFloat(Form25.StringGrid1.Cells[23,row]);//сумма аренды
      Edit3.Text:=Form25.StringGrid1.Cells[22,row];//вид аренды
      Edit6.Text:=Form25.StringGrid1.Cells[8,row];//валюта договора
      ComboBox1.Text:=Form25.StringGrid1.Cells[4,row];//вид договора
      DateEdit4.Text:=Form25.StringGrid1.Cells[9,row];//дата начала начисления штрафных санкций
      DateEdit5.Text:=Form25.StringGrid1.Cells[10,row];//дата конца начисления штрафных санкций
      FloatSpinEdit6.value:=strToFloat(Form25.StringGrid1.Cells[11,row]);////ставка штрафных санкций
      Edit8.Text:=Form25.StringGrid1.Cells[12,row];//подразделение
      FloatSpinEdit8.value:=strToFloat(Form25.StringGrid1.Cells[27,row]);//срыв рейса межгород
      FloatSpinEdit9.value:=strToFloat(Form25.StringGrid1.Cells[28,row]);//срыв рейса пригород
      FloatSpinEdit10.value:=strToFloat(Form25.StringGrid1.Cells[29,row]);//незаход
      FloatSpinEdit11.value:=strToFloat(Form25.StringGrid1.Cells[30,row]);//неостановка на жезл
      FloatSpinEdit12.value:=strToFloat(Form25.StringGrid1.Cells[31,row]);//опоздание до 1 часа
      FloatSpinEdit13.value:=strToFloat(Form25.StringGrid1.Cells[32,row]);//опоздание после 1 часа
      FloatSpinEdit14.value:=strToFloat(Form25.StringGrid1.Cells[33,row]);//алкогольное опьянение
      FloatSpinEdit15.value:=strToFloat(Form25.StringGrid1.Cells[34,row]);//экипировка
      FloatSpinEdit16.value:=strToFloat(Form25.StringGrid1.Cells[35,row]);//провоз безбилетных
      ComboBox2.Text:=Form25.StringGrid1.Cells[36,row];
      ComboBox3.Text:=Form25.StringGrid1.Cells[37,row];
      ComboBox4.Text:=Form25.StringGrid1.Cells[38,row];
      ComboBox5.Text:=Form25.StringGrid1.Cells[39,row];
      ComboBox6.Text:=Form25.StringGrid1.Cells[40,row];
      ComboBox7.Text:=Form25.StringGrid1.Cells[41,row];
      ComboBox8.Text:=Form25.StringGrid1.Cells[42,row];
      ComboBox9.Text:=Form25.StringGrid1.Cells[43,row];
      ComboBox10.Text:=Form25.StringGrid1.Cells[44,row];
  end;

  vibor_dog:=1;  //флаг выбора
  Form25.close;

end;


//***********************************************  Активация формы ******************************************************
procedure TForm25.FormShow(Sender: TObject);
var
   n:integer;
   ssel,spassport:string;
begin
 Centrform(Form25);
 With Form25 do
 begin
 Form25.StringGrid1.RowHeights[0]:=30;
 Form25.StringGrid1.ColWidths[0]:=0;
// Form25.Repaint;

 // Подключаемся к серверу
   If not(Connect2(Zconnection1, flagProfile)) then
     begin
      showmessagealt('Соединение с основным сервером потеряно !'+#13+'Проверьте соединение и/или'+#13+' обратитесь к администратору.');
      Close;
      exit;
     end;
   //запрос списка
   Form25.ZQuery1.SQL.Clear;
   Form25.ZQuery1.SQL.add('Select * FROM av_1c_kontr_dog ');
   ssel:='WHERE';
   //наименование договора
   if not(trim(Form24.Edit2.text)='') then ssel:=ssel+' upper(name) LIKE upper('+Quotedstr(trim(Form24.Edit2.text)+'%')+')';
   //код 1с
   if Form24.SpinEdit8.value>0 then
     begin
      If ssel<>'WHERE' then ssel:=ssel+' AND ';
      ssel:=ssel+' kod1c= '+intToStr(Form24.SpinEdit8.value);
     end;
   //код контарегнта
   if Form24.SpinEdit9.value>0 then
     begin
      If ssel<>'WHERE' then ssel:=ssel+' AND ';
      ssel:=ssel+' kodkont = '+intToStr(Form24.SpinEdit9.value);
     end;

   //Если какие-либо из вышеперечисленных полей заполнены, добавляем в запрос поиск по ним
   If ssel<>'WHERE' then
      Form25.ZQuery1.SQL.add(ssel);
   Form25.ZQuery1.SQL.add(' ORDER BY kodkont;');

  with FOrm25 do
  begin
  try
   ZQuery1.open;
  except
    showmessagealt('ОШИБКА запроса к базе данных !'+#13+'Команда: '+ZQuery1.SQL.Text);
    ZQuery1.Close;
    Zconnection1.disconnect;
  end;
  end;
   if Form25.ZQuery1.RecordCount=0 then
     begin
      Form25.ZQuery1.Close;
      Form25.Zconnection1.disconnect;
      exit;
     end;
   // Заполняем stringgrid
   Form25.ProgressBar1.Max:=Form25.ZQuery1.RecordCount;
   Form25.ProgressBar1.Visible:=true;
   Form25.StringGrid1.RowCount:=Form25.ZQuery1.RecordCount+1;
   for n:=1 to Form25.ZQuery1.RecordCount do
    begin


//      Form25.StringGrid1.Cells[0,n]:=IntToStr(n);
      Form25.StringGrid1.Cells[1,n]:=Form25.ZQuery1.FieldByName('kod1c').asString;
      Form25.StringGrid1.Cells[2,n]:=Form25.ZQuery1.FieldByName('name').asString;
      Form25.StringGrid1.Cells[3,n]:=Form25.ZQuery1.FieldByName('kodkont').asString;
      Form25.StringGrid1.Cells[4,n]:=Form25.ZQuery1.FieldByName('viddog').asString;
      Form25.StringGrid1.Cells[5,n]:=Form25.ZQuery1.FieldByName('datazak').asString;
      Form25.StringGrid1.Cells[6,n]:=Form25.ZQuery1.FieldByName('datavoz').asString;
      Form25.StringGrid1.Cells[7,n]:=Form25.ZQuery1.FieldByName('datapog').asString;
      Form25.StringGrid1.Cells[8,n]:=Form25.ZQuery1.FieldByName('val').asString;
      Form25.StringGrid1.Cells[9,n]:=Form25.ZQuery1.FieldByName('datanacsh').asString;
      Form25.StringGrid1.Cells[10,n]:=Form25.ZQuery1.FieldByName('dataprsh').asString;
      Form25.StringGrid1.Cells[11,n]:=Form25.ZQuery1.FieldByName('stav').asString;
      Form25.StringGrid1.Cells[12,n]:=Form25.ZQuery1.FieldByName('podr').asString;
      Form25.StringGrid1.Cells[13,n]:=Form25.ZQuery1.FieldByName('otcblm').asString;
      Form25.StringGrid1.Cells[14,n]:=Form25.ZQuery1.FieldByName('otcbagm').asString;
      Form25.StringGrid1.Cells[15,n]:=Form25.ZQuery1.FieldByName('otcblp').asString;
      Form25.StringGrid1.Cells[16,n]:=Form25.ZQuery1.FieldByName('otcbagp').asString;
      Form25.StringGrid1.Cells[17,n]:=Form25.ZQuery1.FieldByName('komotd').asString;
      Form25.StringGrid1.Cells[18,n]:=Form25.ZQuery1.FieldByName('med').asString;
      Form25.StringGrid1.Cells[19,n]:=Form25.ZQuery1.FieldByName('ubor').asString;
      Form25.StringGrid1.Cells[20,n]:=Form25.ZQuery1.FieldByName('stop').asString;
      Form25.StringGrid1.Cells[21,n]:=Form25.ZQuery1.FieldByName('disp').asString;
      Form25.StringGrid1.Cells[22,n]:=Form25.ZQuery1.FieldByName('vidar').asString;
      Form25.StringGrid1.Cells[23,n]:=Form25.ZQuery1.FieldByName('sumar').asString;
      Form25.StringGrid1.Cells[24,n]:=Form25.ZQuery1.FieldByName('voin').asString;
      Form25.StringGrid1.Cells[25,n]:=Form25.ZQuery1.FieldByName('lgot').asString;
      Form25.StringGrid1.Cells[26,n]:=Form25.ZQuery1.FieldByName('dopus').asString;
      Form25.StringGrid1.Cells[27,n]:=Form25.ZQuery1.FieldByName('shtr1').asString;
      Form25.StringGrid1.Cells[28,n]:=Form25.ZQuery1.FieldByName('shtr11').asString;
      Form25.StringGrid1.Cells[29,n]:=Form25.ZQuery1.FieldByName('shtr2').asString;
      Form25.StringGrid1.Cells[30,n]:=Form25.ZQuery1.FieldByName('shtr3').asString;
      Form25.StringGrid1.Cells[31,n]:=Form25.ZQuery1.FieldByName('shtr4').asString;
      Form25.StringGrid1.Cells[32,n]:=Form25.ZQuery1.FieldByName('shtr41').asString;
      Form25.StringGrid1.Cells[33,n]:=Form25.ZQuery1.FieldByName('shtr5').asString;
      Form25.StringGrid1.Cells[34,n]:=Form25.ZQuery1.FieldByName('shtr6').asString;
      Form25.StringGrid1.Cells[35,n]:=Form25.ZQuery1.FieldByName('shtr7').asString;
      Form25.StringGrid1.Cells[36,n]:=Form25.ZQuery1.FieldByName('edizm1').asString;
      Form25.StringGrid1.Cells[37,n]:=Form25.ZQuery1.FieldByName('edizm11').asString;
      Form25.StringGrid1.Cells[38,n]:=Form25.ZQuery1.FieldByName('edizm2').asString;
      Form25.StringGrid1.Cells[39,n]:=Form25.ZQuery1.FieldByName('edizm3').asString;
      Form25.StringGrid1.Cells[40,n]:=Form25.ZQuery1.FieldByName('edizm4').asString;
      Form25.StringGrid1.Cells[41,n]:=Form25.ZQuery1.FieldByName('edizm41').asString;
      Form25.StringGrid1.Cells[42,n]:=Form25.ZQuery1.FieldByName('edizm5').asString;
      Form25.StringGrid1.Cells[43,n]:=Form25.ZQuery1.FieldByName('edizm6').asString;
      Form25.StringGrid1.Cells[44,n]:=Form25.ZQuery1.FieldByName('edizm7').asString;

//      ************************
      Form25.ProgressBar1.Position:=Form25.ProgressBar1.Position+1;
      Form25.ProgressBar1.Refresh;

      Form25.ZQuery1.Next;
    end;
   Form25.ProgressBar1.Position:=0;
   Form25.ProgressBar1.Visible:=false;
   Form25.ZQuery1.Close;
   Form25.Zconnection1.disconnect;

 end;
end;

//***********************************   ОТРИСОВКА ГРИДА ****************************************************
procedure TForm25.StringGrid1DrawCell(Sender: TObject; aCol, aRow: Integer;
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
            font.Size:=10;
            font.Style:= [];
           end
         else
          begin
            font.Style:= [];
            Font.Color := cFont;
            font.Size:=10;
          end;

     //Остальные поля
  if (ARow > 0) then
  begin
    TextOut(aRect.Left+10, aRect.Top+5, Cells[ACol, ARow]);
  end;

   //Если есть договор истек
     if (ARow > 0) AND (ACol=2) AND (strToDate(Cells[7,aRow])<Date) then
      begin
        Font.Color := cAl;
        TextOut(aRect.Left+20, aRect.Top+25, sAlarm);
      end;

  // Заголовок
  if aRow=0 then
         begin

           Brush.Color:=cDefault;
           FillRect(aRect);
           Font.Color := cFont;
           font.Size:=9;
           TextOut(aRect.Left + 5, aRect.Top+5, Cells[aCol, aRow]);
          end;

 end;

end;


end.

