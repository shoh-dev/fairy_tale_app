<!-- Flutter Version -->
Flutter 3.27.1 • channel stable •
https://github.com/flutter/flutter.git
Framework • revision 17025dd882 (3 months ago) • 2024-12-17
03:23:09 +0900
Engine • revision cb4b5fff73
Tools • Dart 3.6.0 • DevTools 2.40.2



<!-- App Breakdown -->
*   Homepage
        * Top Bar [Row]
            - Application Logo
            - Home button (goes to homepage and scrolls to top)
            - Explore button (goes to explore tales page)
            - Community (forum) button (goes to community page. Page where people can ask and answer questions)
            - Search Field (searches based on which page)
            - Create Tale button (goes to tale creation page)
        * Tale List [Column]
            - Title (My Tales)
            - Last worked Tale banner (full width, 400-500px height)
            - List of my tales (goes to tale edit page)
*   Tale Edit page (when opened selects first page if available)
    * Top Bar [Row]
        - Back button
        - Tabs (Tale, Pages, Interactions)
            * Tale [Column]
                - Title selector dropdown
                - Description selector dropdown
                - Orientation selector
                - Metadata [Column]
                    - Cover image recommended text [260x320]
                    - Selected image preview (fixed size in [260x320])
                    - Replace or Select image button (updates tale with selected image)
                    - Background audio selector
                    - Play button to play(visible only if audio is added)
                    - Replace or Select audio button (updates tale with selected audio)
                - Delete tale button (shows prompt to delete)

            * Pages [Row]
                - Left Bar [Column]
                    - Add Page button (addes new page)
                    - List of tale pages in a device preview (clicking selects the tale page)
                - Body [Column]
                    - Title (Page Details) and Preview button (previews the current selected page)
                    - Page title selector dropdown
                    - Page number selector dropdown
                    - Metadata [Column]
                        - Page background image recommended text (get from [Sizes.deviceSize])
                        - Selected image preview (fixed size in device preview)
                        - Replace or Select image button (updates page with selected image)
                    - Delete page button (shows prompt to delete)
            * Interactions [Row]
                - Left Bar [Column]
                    - Add interaction button (addes new interaction)
                    - Page selector dropdown
                    - List of interactions (clicking selects the interaction)
                - Body
                    - Device preview of selected page
                        (selected interaction is highlighted (can be dragged to change initial size))
                - Right Bar [Column]
                    - Event Type selector dropdown (required)
                    - Event Sub Type selector dropdown (required, visible only if eventType is selected)
                    - Action selector dropdown (required, visible only if eventType is selected)
                    - Hint selector dropdown
                    - Width & Height (required)
                    - Initial Position (dx & dy) (required)
                    - Final Position (dx & dy) (required and visible only if action is [move])
                    - Animation duration (integer, default [500])
                    - Metadata [Column]
                        - Object image recommended text (get from width & height)
                        - Selected image preview (fixed size of [40x40])
                        - Replace or Select image button (updates interaction with selected image)
                        - Audio selector (required and visible only if action is [play_sound])
                            - Play button to play(visible only if audio is added)
                            - Replace or Select audio button (updates interaction with selected audio)
                    - Delete interaction button (shows prompt to delete)