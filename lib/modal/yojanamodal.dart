class Yojanalist {
  dynamic pariyojana_id;
  dynamic pariyojana_name;
  dynamic title;
  dynamic contracter_name;
  dynamic start_date;
  dynamic end_date;
  dynamic start_date_nep;
  dynamic end_date_nep;
  dynamic address;
  dynamic woda_id;
  dynamic current_status;
  dynamic progress_status;
  dynamic percent_progress;
  dynamic total_amount;
  dynamic paid_amount;
  dynamic last_paid_date;
  dynamic running_bill;
  dynamic vat_bill;
  dynamic project_report;
  dynamic other_file;
  dynamic remark;
  dynamic detail;
  dynamic detail1;
  dynamic approved1;
  dynamic approved2;
  dynamic approved3;
  dynamic notif_status;
  dynamic created_at;
  dynamic updated_at;
  Yojanalist({
    this.pariyojana_id,
    this.pariyojana_name,
    this.title,
    this.contracter_name,
    this.start_date,
    this.end_date,
    this.start_date_nep,
    this.end_date_nep,
    this.address,
    this.woda_id,
    this.current_status,
    this.progress_status,
    this.percent_progress,
    this.total_amount,
    this.paid_amount,
    this.last_paid_date,
    this.running_bill,
    this.vat_bill,
    this.project_report,
    this.other_file,
    this.remark,
    this.detail,
    this.detail1,
    this.approved1,
    this.approved2,
    this.approved3,
    this.notif_status,
    this.created_at,
    this.updated_at,
  });

  factory Yojanalist.fromJson(Map<String, dynamic> map) {
    return Yojanalist(
      pariyojana_id: map['pariyojana_id'],
      pariyojana_name: map['pariyojana_name'],
      title: map['title'],
      contracter_name: map['contracter_name'],
      start_date: map['start_date'],
      end_date: map['end_date'],
      start_date_nep: map['start_date_nep'],
      end_date_nep: map['end_date_nep'],
      address: map['address'],
      woda_id: map['woda_id'],
      current_status: map['current_status'],
      progress_status: map['progress_status'],
      percent_progress: map['percent_progress'],
      total_amount: map['total_amount'],
      paid_amount: map['paid_amount'],
      last_paid_date: map['last_paid_date'],
      running_bill: map['running_bill'],
      vat_bill: map['vat_bill'],
      project_report: map['project_report'],
      other_file: map['other_file'],
      remark: map['remark'],
      detail: map['detail'],
      detail1: map['detail1'],
      approved1: map['approved1'],
      approved2: map['approved2'],
      approved3: map['approved3'],
      notif_status: map['notif_status'],
      created_at: map['created_at'],
      updated_at: map['updated_at'],
    );
  }
}
