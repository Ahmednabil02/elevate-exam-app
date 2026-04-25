import 'dart:async';

import 'package:exam_app/config/dependency_injection/di.dart';
import 'package:exam_app/core/routes/app_routes.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/values/app_colors.dart';
import 'package:exam_app/core/widgets/pagination_state_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/models/subject_entity.dart';
import '../cubit/subject_cubit.dart';

class SubjectScreen extends StatefulWidget {
  const SubjectScreen({super.key});

  @override
  State<SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<SubjectScreen> {
  late final SubjectCubit cubit;
  late final ScrollController scrollController;
  late final TextEditingController searchController;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    cubit = getIt<SubjectCubit>()..doIntent(const GetSubjectsEvent());
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);

    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    scrollController.dispose();
    searchController.dispose();
    _debounce?.cancel();
    cubit.close();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      final query = searchController.text.trim();
      final currentSearch = cubit.currentParams.search?.trim() ?? '';

      // Only search if the query has changed
      if (query != currentSearch) {
        cubit.doIntent(GetSubjectsEvent(search: query.isEmpty ? null : query));
      }
    });
  }

  final InputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide(color: AppColors.gray53),
  );
  void _onScroll() {
    if (cubit.shouldLoadMore(scrollController) && cubit.canLoadMore()) {
      final currentParams = cubit.currentParams;
      final nextPage = cubit.state.subjectState.currentPage + 1;
      cubit.doIntent(
        LoadMoreSubjectsEvent(params: currentParams.copyWith(page: nextPage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Survey",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
                const SizedBox(height: 20),
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,

                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: AppColors.primaryBlue,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: Colors.grey),
                              onPressed: () {
                                searchController.clear();
                              },
                            )
                          : null,

                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                      disabledBorder: border,
                      border: border,
                      enabledBorder: border,

                      focusedBorder: border.copyWith(
                        borderSide: const BorderSide(
                          color: AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  "Browse by subject",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                // Subjects List
                Expanded(
                  child: BlocBuilder<SubjectCubit, SubjectStates>(
                    builder: (context, state) {
                      return PaginationStateBuilder<SubjectEntity>(
                        state: state.subjectState,
                        onEmpty: (context) => const Center(
                          child: Text(
                            "No subjects found",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                        onSuccess: (context, subjects) {
                          return ListView.separated(
                            controller: scrollController,
                            itemCount: subjects.length,
                            physics: const BouncingScrollPhysics(),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 16),
                            itemBuilder: (context, index) {
                              final subject = subjects[index];
                              return GestureDetector(
                                onTap: () {
                                  context.push(
                                    Routes.exams,
                                    extra: {"subject": subject},
                                  );
                                },
                                child: _SubjectItem(subject: subject),
                              );
                            },
                          );
                        },
                        onLoadingMore: (context, subjects) {
                          return Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  controller: scrollController,
                                  itemCount: subjects.length,
                                  physics: const BouncingScrollPhysics(),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 16),
                                  itemBuilder: (context, index) {
                                    final subject = subjects[index];
                                    return _SubjectItem(subject: subject);
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryBlue,
                                ),
                              ),
                            ],
                          );
                        },
                        onError: (context, exception) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error_outline,
                                  size: 64,
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'Error: ${exception.toString()}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.red),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    cubit.refreshSubjects(
                                      search:
                                          searchController.text.trim().isEmpty
                                          ? null
                                          : searchController.text.trim(),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                  ),
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubjectItem extends StatelessWidget {
  final SubjectEntity subject;

  const _SubjectItem({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 0,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          _buildIcon(subject.icon),
          const SizedBox(width: 20),
          Text(
            subject.name ?? "Unknown",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(String? iconUrl) {
    if (iconUrl == null || iconUrl.isEmpty) {
      return const Icon(Icons.subject, size: 32, color: AppColors.primaryBlue);
    }

    return Image.network(
      iconUrl,
      width: 40,
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.subject, size: 32, color: AppColors.primaryBlue),
    );
  }
}
