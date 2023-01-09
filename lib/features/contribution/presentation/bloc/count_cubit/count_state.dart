part of 'count_cubit.dart';

enum CountStatus { initial, success, error, loading }

extension CountStatusX on CountStatus {
  bool get isInitial => this == CountStatus.initial;
  bool get isSuccess => this == CountStatus.success;
  bool get isError => this == CountStatus.error;
  bool get isLoading => this == CountStatus.loading;
}

class CountState extends Equatable {
  final CountStatus status;
  final int? approved;
  final int? waiting;
  final int? totalDataSubmit;



  const CountState({
    this.status = CountStatus.initial,
    this.approved,
    this.waiting,
    this.totalDataSubmit
  });

  @override
  List<Object?> get props => [
    status,
    approved,
    waiting,
    totalDataSubmit,
  ];

  CountState copyWith({
    CountStatus? status,
    int? approved,
    int? waiting,
    int? totalDataSubmit
  }) {
    return CountState(
        status: status ?? this.status,
        approved: approved ?? this.approved,
        waiting: waiting ?? this.waiting,
        totalDataSubmit: totalDataSubmit ?? this.totalDataSubmit
    );
  }
}
