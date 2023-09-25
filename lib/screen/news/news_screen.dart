import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_news/res/app_strings.dart';
import 'package:task_news/screen/news_detail/news_detail_screen.dart';
import 'bloc/news_bloc.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final newsBloc = context.read<NewsBloc>();
    newsBloc.add(NewsInitEvent());

    return Scaffold(
      appBar: AppBar(
          leading: const Icon(
            Icons.arrow_back_ios_new,
          ),
          title: const Text(
            AppStrings.notifications,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                newsBloc.add(ToggleAllNewsRead());
              },
              child: const Text(
                AppStrings.markAllRead,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state.listNews != null) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        AppStrings.featured,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppStrings.openSansItalic),
                      ),
                    ),
                  ),
                  SliverAppBar(
                    expandedHeight: 300.0,
                    floating: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: CarouselSlider.builder(
                        itemCount: state.listNews?.articles?.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) {
                          final newsFeatured = state.listNews!.articles![index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailScreen(
                                        imageUrl:
                                            newsFeatured.urlToImage.toString(),
                                        description:
                                            newsFeatured.description.toString(),
                                        title: newsFeatured.title.toString(),
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 358.0,
                                    child: Image.network(
                                      newsFeatured.urlToImage as String,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 20,
                                left: 10,
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      right: 100, left: 10, bottom: 10),
                                  width: MediaQuery.of(context).size.width - 40,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    newsFeatured.title.toString(),
                                    style: const TextStyle(
                                        fontSize: 28,
                                        color: Colors.white,
                                        fontFamily: AppStrings.openSansItalic),
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                        options: CarouselOptions(
                          height: 358.0,
                          viewportFraction: 1.0,
                        ),
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        AppStrings.latesNews,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: AppStrings.openSansItalic,
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final news = state.listNews!.articles![index];
                        //Cтрока с датой
                        String dateString = news.publishedAt.toString();
                        //Преобразование строки в DateTime
                        DateTime newsDate = DateTime.parse(dateString);
                        //Текущая дата и время
                        DateTime currentDate = DateTime.now();
                        //Вычисление разницы в днях
                        Duration difference = currentDate.difference(newsDate);
                        int daysSinceNews = difference.inDays;
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Card(
                            color: state.listColors?[index],
                            child: ListTile(
                              title: Text(
                                news.title.toString(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              subtitle: Text(
                                  daysSinceNews.toString() + AppStrings.dayAgo),
                              leading: SizedBox(
                                  height: 60,
                                  width: 90,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        news.urlToImage as String,
                                        fit: BoxFit.fill,
                                      ))),
                              isThreeLine: true,
                              onTap: () {
                                newsBloc.add(ToggleNewsRead(index));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsDetailScreen(
                                      imageUrl: news.urlToImage.toString(),
                                      description: news.description.toString(),
                                      title: news.title.toString(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      childCount: state.listNews?.articles?.length,
                    ),
                  ),
                ],
              );
            } else if (state.exception == true) {
              return Center(
                child: Text(state.exceptionText.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
