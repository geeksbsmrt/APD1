//
//  FirstViewController.m
//  testApp
//
//  Created by Adam Crawford on 2/3/14.
//  Copyright (c) 2014 Adam Crawford. All rights reserved.
//

#import "AlarmsViewController.h"

@interface AlarmsViewController ()

@end

@implementation AlarmsViewController

-(void)viewWillAppear:(BOOL)animated
{
	
	timeFormatter = [[NSDateFormatter alloc] init];
	[timeFormatter setTimeStyle: NSDateFormatterShortStyle];
	alarmFormatter = [[NSDateFormatter alloc] init];
	[alarmFormatter setTimeStyle: NSDateFormatterMediumStyle];
	[self tick:self];
	
	[NSTimer scheduledTimerWithTimeInterval:1.0
									 target:self
								   selector:@selector(tick:)
								   userInfo:nil
									repeats:YES];
	
	if ([alarms count] == 0) {
		table.hidden = YES;
		none.hidden = NO;
		control.hidden = YES;
	} else {
		table.hidden = NO;
		none.hidden = YES;
		control.hidden = NO;
	}
	
	[table reloadData];
	
}

- (void)viewDidLoad
{
	alarmsList = [AlarmsList alarms];
	if (alarmsList) {
		alarms = alarmsList.alarms;
	}
	
	
	
		
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tick:(id)sender
{
	NSString *currentTime = [timeFormatter stringFromDate: [NSDate date]];
	time.font = [UIFont fontWithName:@"Orbitron-Bold" size:50.0f];
	time.text = currentTime;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [alarms count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	cell.alarmName.text = [[alarms objectAtIndex:indexPath.row]alarmName];
	cell.alarmTime.text = [[alarms objectAtIndex:indexPath.row]alarmTime];
	cell.toEmail.text = [[alarms objectAtIndex:indexPath.row]toEmail];
	cell.sub.text = [[alarms objectAtIndex:indexPath.row]emailSubject];
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	// ensure we are deleting
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		// remove data from arrays

		[alarms removeObjectAtIndex:indexPath.row];
		// remove table row
		[table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
		if ([alarms count] == 0) {
			table.hidden = YES;
			none.hidden = NO;
			control.hidden = YES;
			[control setTitle:@"Edit" forState:UIControlStateNormal];
			[table setEditing:NO];
		}
		
	}
}


-(BOOL)timeIs12HourFormat {
	
	// Creates date format string from current devices locale
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
	//NSLog(@"%@", formatStringForHours);
	//attempts to find possition of "a" within the string
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
	//If "a" is found, sets hasAMPM to true, else sets false
    BOOL hasAMPM = containsA.location != NSNotFound;
    return hasAMPM;
}

-(IBAction)onClick:(id)sender
{
	UIButton *pressed = (UIButton*)sender;
	switch (pressed.tag) {
		case 0:
		//add
		{
			hrs = [self timeIs12HourFormat];
			if (hrs) {

				[self performSegueWithIdentifier:@"12" sender:self];
			} else {

				[self performSegueWithIdentifier:@"24" sender:self];
			}

			break;
		}
		case 1:
		//Edit
		{
			if (table.editing) {
				// change back to normal
				[table setEditing:NO animated:YES];
				// change button back to edit
				[control setTitle:@"Edit" forState:UIControlStateNormal];
			} else {
				// change to edit mode
				[table setEditing:YES animated:YES];
				// change button to done
				[control setTitle:@"Done" forState:UIControlStateNormal];
				
			}
		
		}
		default:
			break;
	}
		
	
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	hrs = [self timeIs12HourFormat];
	if (hrs) {
		[self performSegueWithIdentifier:@"edit12" sender:self];
	} else {
		[self performSegueWithIdentifier:@"edit24" sender:self];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
	
	NSIndexPath *path = [table indexPathForSelectedRow];
	AddViewController *avc = [segue destinationViewController];
		
	if ([segue.identifier isEqualToString:@"edit12"] || [segue.identifier isEqualToString:@"edit24"]) {
		[avc setSending: [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:path.row] forKey:@"Index"]];
	}

	
	
	
}


@end
