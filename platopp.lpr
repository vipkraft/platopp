program platopp;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, fullmap, mainopp, zcomponent, formatmemo, nas,
  nas_edit, other_nas, dialogs, lazmouseandkeyinput, datetimectrls, point_main,
  point_edit, group, group_edit, ats_main, ats_edit, shedule_main, route_main,
  shedule_edit_sostav, lgot_main, lgot_edit, uslugi_main,
  uslugi_edit, shedule_path, platproc, tarif_edit, tarif_main, read_nas,
  kontr1c, kontr_edit, ticketshablon, tickettypes, dogovor_edit, kontr_main,
  dogovor1c, path_main, path_edit, reports, rtfdoc, license, htmldoc, htmlproc,
  datalog, users_main, shedule_grafik, report_main, report_edit, SysUtils,
  report_vibor, shedule_edit, servers_main, shedule_bron, ticket, message_idle,
  shedule_tarif, kontr_tarif, version_info, facelist;

{$R *.res}

 begin
  Application.Title:='АСПБ ПЛАТФОРМА АВ модуль ОПП';

  //if ParamCount < 1 then
  // begin
  //  showmessagealt('Параметры загрузки приложения указаны неправильно !!!');
  //  halt;
  //end;


  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

