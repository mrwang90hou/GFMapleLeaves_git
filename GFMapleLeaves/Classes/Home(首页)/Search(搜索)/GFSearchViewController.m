//
//  GFSearchViewController.m
//  GFMapleLeaves
//
//  Created by L on 2018/9/11.
//  Copyright © 2018年 mrwang90hou. All rights reserved.
//
#import "GFSearchViewController.h"
#import "PYSearch.h"
#import "PYTempViewController.h"

@interface GFSearchViewController () <PYSearchViewControllerDelegate>


@end

@implementation GFSearchViewController

#pragma mark - LazyLoad

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    // set title
    self.title = @"PYSearch Example";
    
    
    // 1. Create an Array of popular search
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. Create a search view controller
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"PYExampleSearchPlaceholderText", @"搜索编程语言") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // Called when search begain.
        // eg：Push to a temp view controller
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. Set style for popular search and search history
    if (/* DISABLES CODE */ (1)) {
        searchViewController.hotSearchStyle = 0;
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault;
    } else {
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault;
        searchViewController.searchHistoryStyle = 0;
    }
    // 4. Set delegate
    searchViewController.delegate = self;
    // 5. Present a navigation controller
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) {
        // Simulate a send request to get a search suggestions
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"Search suggestion %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // Refresh and display the search suggustions
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}
@end

