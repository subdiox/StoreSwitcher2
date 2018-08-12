#import "SSViewController.h"

@implementation SSViewController
@synthesize tableViewController;
@synthesize accounts;

- (UINavigationController *)init {
  UITableViewController *contentViewController = [[UITableViewController alloc] initWithStyle:UITableViewStyleGrouped];
  SSViewController *viewController = [super initWithRootViewController:contentViewController];
  [viewController setTableViewController:contentViewController];
  [[contentViewController tableView] setDelegate:viewController];
  [[contentViewController tableView] setDataSource:viewController];
  [[contentViewController tableView] registerClass:[SSTableViewCell class] forCellReuseIdentifier:@"SSTableViewCell"];
  
  return viewController;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [[self tableViewController] setTitle:@"Accounts"];
  UIBarButtonItem *dismissButton =
    [[UIBarButtonItem alloc]
      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
      target:self
      action:@selector(dismissAnimated)
    ];
  [[[self tableViewController] navigationItem] setLeftBarButtonItem:dismissButton];
  [[[self tableViewController] navigationItem] setRightBarButtonItem: [[self tableViewController] editButtonItem]];
  NSMutableArray *allAccounts = [[[objc_getClass("SSAccountStore") defaultStore] accounts] mutableCopy];
  NSIndexSet *localAccountIndexSet = [allAccounts indexesOfObjectsPassingTest:^BOOL(id object, NSUInteger index, BOOL *stop) {
    SSAccount *account = (SSAccount *)object;
    return [account isLocalAccount];
  }];
  [allAccounts removeObjectsAtIndexes:localAccountIndexSet];
  [self setAccounts:allAccounts];
}

- (void)dismissAnimated {
  [self dismissViewControllerAnimated:YES completion:nil];
  return;
}

- (NSString *)countryCodeForAccount:(SSAccount *)account {
  NSString *frontIdentifier = [account storeFrontIdentifier];
  NSString *internalCountryCode = [[[[frontIdentifier componentsSeparatedByString:@","] firstObject] componentsSeparatedByString:@"-"] firstObject];
  NSDictionary *countryDict = @{
    @"143563": @"Algeria (DZ)",
    @"143564": @"Angola (AO)",
    @"143538": @"Anguilla (AI)",
    @"143540": @"Antigua & Barbuda (AG)",
    @"143505": @"Argentina (AR)",
    @"143524": @"Armenia (AM)",
    @"143460": @"Australia (AU)",
    @"143445": @"Austria (AT)",
    @"143568": @"Azerbaijan (AZ)",
    @"143559": @"Bahrain (BH)",
    @"143490": @"Bangladesh (BD)",
    @"143541": @"Barbados (BB)",
    @"143565": @"Belarus (BY)",
    @"143446": @"Belgium (BE)",
    @"143555": @"Belize (BZ)",
    @"143542": @"Bermuda (BM)",
    @"143556": @"Bolivia (BO)",
    @"143525": @"Botswana (BW)",
    @"143503": @"Brazil (BR)",
    @"143543": @"British Virgin Islands (VG)",
    @"143560": @"Brunei (BN)",
    @"143526": @"Bulgaria (BG)",
    @"143455": @"Canada (CA)",
    @"143544": @"Cayman Islands (KY)",
    @"143483": @"Chile (CL)",
    @"143465": @"China (CN)",
    @"143501": @"Colombia (CO)",
    @"143495": @"Costa Rica (CR)",
    @"143527": @"Cote d'Ivoire (CI)",
    @"143494": @"Croatia (HR)",
    @"143557": @"Cyprus (CY)",
    @"143489": @"Czech Republic (CZ)",
    @"143458": @"Denmark (DK)",
    @"143545": @"Dominica (DM)",
    @"143508": @"Dominican Rep. (DO)",
    @"143509": @"Ecuador (EC)",
    @"143516": @"Egypt (EG)",
    @"143506": @"El Salvador (SV)",
    @"143518": @"Estonia (EE)",
    @"143447": @"Finland (FI)",
    @"143442": @"France (FR)",
    @"143443": @"Germany (DE)",
    @"143573": @"Ghana (GH)",
    @"143448": @"Greece (GR)",
    @"143546": @"Grenada (GD)",
    @"143504": @"Guatemala (GT)",
    @"143553": @"Guyana (GY)",
    @"143510": @"Honduras (HN)",
    @"143463": @"Hong Kong (HK)",
    @"143482": @"Hungary (HU)",
    @"143558": @"Iceland (IS)",
    @"143467": @"India (IN)",
    @"143476": @"Indonesia (ID)",
    @"143449": @"Ireland (IE)",
    @"143491": @"Israel (IL)",
    @"143450": @"Italy (IT)",
    @"143511": @"Jamaica (JM)",
    @"143462": @"Japan (JP)",
    @"143528": @"Jordan (JO)",
    @"143517": @"Kazakstan (KZ)",
    @"143529": @"Kenya (KE)",
    @"143466": @"Korea, Republic Of (KR)",
    @"143493": @"Kuwait (KW)",
    @"143519": @"Latvia (LV)",
    @"143497": @"Lebanon (LB)",
    @"143522": @"Liechtenstein (LI)",
    @"143520": @"Lithuania (LT)",
    @"143451": @"Luxembourg (LU)",
    @"143515": @"Macau (MO)",
    @"143530": @"Macedonia (MK)",
    @"143531": @"Madagascar (MG)",
    @"143473": @"Malaysia (MY)",
    @"143488": @"Maldives (MV)",
    @"143532": @"Mali (ML)",
    @"143521": @"Malta (MT)",
    @"143533": @"Mauritius (MU)",
    @"143468": @"Mexico (MX)",
    @"143523": @"Moldova, Republic Of (MD)",
    @"143547": @"Montserrat (MS)",
    @"143484": @"Nepal (NP)",
    @"143452": @"Netherlands (NL)",
    @"143461": @"New Zealand (NZ)",
    @"143512": @"Nicaragua (NI)",
    @"143534": @"Niger (NE)",
    @"143561": @"Nigeria (NG)",
    @"143457": @"Norway (NO)",
    @"143562": @"Oman (OM)",
    @"143477": @"Pakistan (PK)",
    @"143485": @"Panama (PA)",
    @"143513": @"Paraguay (PY)",
    @"143507": @"Peru (PE)",
    @"143474": @"Philippines (PH)",
    @"143478": @"Poland (PL)",
    @"143453": @"Portugal (PT)",
    @"143498": @"Qatar (QA)",
    @"143487": @"Romania (RO)",
    @"143469": @"Russia (RU)",
    @"143479": @"Saudi Arabia (SA)",
    @"143535": @"Senegal (SN)",
    @"143500": @"Serbia (RS)",
    @"143464": @"Singapore (SG)",
    @"143496": @"Slovakia (SK)",
    @"143499": @"Slovenia (SI)",
    @"143472": @"South Africa (ZA)",
    @"143454": @"Spain (ES)",
    @"143486": @"Sri Lanka (LK)",
    @"143548": @"St. Kitts & Nevis (KN)",
    @"143549": @"St. Lucia (LC)",
    @"143550": @"St. Vincent & The Grenadines (VC)",
    @"143554": @"Suriname (SR)",
    @"143456": @"Sweden (SE)",
    @"143459": @"Switzerland (CH)",
    @"143470": @"Taiwan (TW)",
    @"143572": @"Tanzania (TZ)",
    @"143475": @"Thailand (TH)",
    @"143539": @"The Bahamas (BS)",
    @"143551": @"Trinidad & Tobago (TT)",
    @"143536": @"Tunisia (TN)",
    @"143480": @"Turkey (TR)",
    @"143552": @"Turks & Caicos (TC)",
    @"143537": @"Uganda (UG)",
    @"143492": @"Ukraine (UA)",
    @"143481": @"United Arab Emirates (AE)",
    @"143444": @"United Kingdom (UK)",
    @"143441": @"United States (US)",
    @"143514": @"Uruguay (UY)",
    @"143566": @"Uzbekistan (UZ)",
    @"143502": @"Venezuela (VE)",
    @"143471": @"Vietnam (VN)",
    @"143571": @"Yemen (YE)"
  };
  NSString *countryCode = countryDict[internalCountryCode];
  if (!countryCode) {
    countryCode = [NSString stringWithFormat: @"Unknown Country [%@]", internalCountryCode];
  }
  return countryCode;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [accounts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"SSTableViewCell";
  SSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
  SSAccount *account = accounts[indexPath.row];
  if ([account firstName]) {
    [[cell textLabel] setText:[NSString stringWithFormat:@"%@ %@", [account firstName], [account lastName]]];
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ - %@", [account accountName], [self countryCodeForAccount:account]]];
  } else {
    [[cell textLabel] setText:[account accountName]];
    [[cell detailTextLabel] setText:[self countryCodeForAccount:account]];
  }
  if ([account isActive]) {
    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  SSAccount *account = accounts[indexPath.row];
  //[[objc_getClass("SSAccountStore") defaultStore] setActiveAccount:account];
  [account setActive:YES];
  [[objc_getClass("SSAccountStore") defaultStore] saveAccount:account verifyCredentials:NO error:nil];
  [[objc_getClass("SSDevice") currentDevice] reloadStoreFrontIdentifier];
  [[[objc_getClass("SKUIClientContext") defaultContext] applicationController] _resetUserInterfaceAfterStoreFrontChange];
  [self dismissAnimated];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
  SSAccount *account = accounts[indexPath.row];
  if (tableView.editing && ![account isActive]) {
    return UITableViewCellEditingStyleDelete;
  }
  return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  SSAccount *account = accounts[indexPath.row];
  if (![account isActive]) {
    [[objc_getClass("SSAccountStore") defaultStore] removeAccount:account error:nil];
    [accounts removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
  }
}

@end