import 'package:attendance_by_biometrics/index.dart';

class CheckInBody extends StatelessWidget {
  const CheckInBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BiometricsCubit, BiometricsStates>(
        listener: (context, state) {},
        builder: (BuildContext context, state) {
          var cubit = BlocProvider.of<BiometricsCubit>(context);
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InfoCard(cubit: cubit),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              CheckingInfoCard(cubit: cubit),
            ],
          );
        });
  }
}

class CheckingInfoCard extends StatelessWidget {
  const CheckingInfoCard({
    super.key,
    required this.cubit,
  });

  final BiometricsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          color: const Color(0xffe0e1dd),
          elevation: 20,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                cubit.permission == LocationPermission.whileInUse ||
                        cubit.permission == LocationPermission.always
                    ? cubit.language == "En"
                        ? "Last check at: \n${cubit.timeAndDate}"
                        : ": قمت بتسجيل الدخول عند \n${cubit.timeAndDate}"
                    : "location services are denied",
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.cubit,
  });

  final BiometricsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          color: const Color(0xffe0e1dd),
          elevation: 20,
          child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.04,
                  horizontal:
                      MediaQuery.of(context).size.height * 0.015),
              child: Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: cubit.language == "En"
                              ? "Status :"
                              : ": الحالة",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: cubit.status,
                          style: TextStyle(
                            fontSize: 25,
                            color: cubit.status == 'IN RANGE'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: cubit.language == "En"
                              ? "   Dis: ${cubit.distanceInMeters.toStringAsFixed(0)}"
                              : "   ${cubit.distanceInMeters.toStringAsFixed(0)}:المسافة",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: '\n${cubit.closePoint}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.blueGrey[400],
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
