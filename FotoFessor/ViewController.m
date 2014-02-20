//
//  ViewController.m
//  FotoFessor
//  https://api.staging.matematikfessor.dk/photo/upload_with_code/
//  Created by Stefan Brankovic on 12/11/13.
//  Copyright (c) 2013 EduLab. All rights reserved.
//  7667

#import "ViewController.h"
#import "HUD.h"


@interface ViewController ()

@property UIImagePickerController *imagePicker;
@property Reachability *internetReachableFoo;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self declareVariables];
    [self loadData];
    [self checkWiFiConn];
    [self setLanguage];
    
}



- (void)takeAPhoto:(UIButton *)sender
{
    
    
    //Check internet connection
    if (_internet == NO){
        [self checkWiFiConn];
    }
    else{
    
        
        
        // Checks the code and if it's good activates the camera
        if ([self checkCode:[NSString stringWithFormat:@"%@",_codeTxt]] == 0)
        {
            _invalideCodeMessage.hidden = YES;
            _code = _codeTxt.text;
        
            _imagePicker = [[UIImagePickerController alloc]init];
        
            _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            _imagePicker.delegate = self;
            _imagePicker.allowsEditing=NO;
        
            [self presentViewController:_imagePicker animated:YES completion:nil];
        
            
        }
        // If the code is bad, shows error message
        
        
        if([self checkCode:[NSString stringWithFormat:@"%@",_codeTxt]] == 1)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Wrong code !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        if([self checkCode:[NSString stringWithFormat:@"%@",_codeTxt]] == 2)
        {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"ERROR" message:@"Please install the newest version of the FotoFessor app!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
     // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Save image
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    _takenPicture = image;
    
    ImageUploader *uploader = [[ImageUploader alloc]init];
   [uploader uploadAnImage:_takenPicture withCode:_codeTxt.text];
    
    
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    UIAlertView *alert;
    
    // Unable to save the image
    if (error)
        alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                           message:@"Unable to save image to Photo Album."
                                          delegate:self cancelButtonTitle:@"Ok"
                                 otherButtonTitles:nil];
    
    
}

-(int)checkCode:(NSString*)code
{
    
    NSString *urlString;
    int returnInt;
    
    
    // THOR - api.fessor.da.thor.office/photo/
    // test server
    urlString = [NSString stringWithFormat:@"http://api.fessor.da.thor.office/photo/check_code/%@?refresh=true",_codeTxt.text];
    
    
    //relase server
    
//    switch ([Constants shared].language) {
//        case DANSK:
//            urlString = [NSString stringWithFormat:@"%@%@",[Constants shared].danskServer, _codeTxt.text];
//            break;
//            
//        case NORGE:
//            urlString = [NSString stringWithFormat:@"%@%@",[Constants shared].norgeServer, _codeTxt.text];
//            break;
//    }
    
    
    
    NSString *returnedString = [self getDataFrom:urlString];
   

    
    char goodCode = [returnedString characterAtIndex:19];
    char protocolVerisionChar;
    
    NSString *isCodeGood = [self charToString:goodCode];
    if ([isCodeGood isEqualToString:@"s"])
    {
        protocolVerisionChar = [returnedString characterAtIndex:47];
    }else{
        protocolVerisionChar = [returnedString characterAtIndex:44];
    }
    NSString *protocoleVersionString = [self charToString:protocolVerisionChar];
    
    int protocolVersion = [protocoleVersionString intValue];
    [HUD hideUIBlockingIndicator];

    if ([isCodeGood isEqualToString:@"s"] && protocolVersion<=2)
    {
        returnInt = 0; // NO ERROR
    }
    if ([isCodeGood isEqualToString:@"s"]==NO && protocolVersion<=2)
   {
       returnInt = 1; // WRONG CODE ERROR
    }
    if ( [isCodeGood isEqualToString:@"s"] == YES && protocolVersion>2){
        
        returnInt = 2; // NEW VERSION ERROR
        
    }
    
    
 
    return returnInt;
    
}

-(NSString*)charToString:(unichar)utf8char{
    char chars[2];
    int len = 1;
    
    if (utf8char > 127) {
        chars[0] = (utf8char >> 8) & (1 << 8) - 1;
        chars[1] = utf8char & (1 << 8) - 1;
        len = 2;
    } else {
        chars[0] = utf8char;
    }
    
    NSString *string = [[NSString alloc] initWithBytes:chars
                                                length:len
                                              encoding:NSUTF8StringEncoding];
    
    return string;
}

-(NSString*)getDataFrom:(NSString*)url
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError* error = [[NSError alloc]init];
    NSHTTPURLResponse *responceCode = nil;
    
    NSData * oResponceData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responceCode error:&error];
    
    if ([responceCode statusCode]!=200){
        NSLog(@"Error getting %@, HTTP Status code %li",url,(long)[responceCode statusCode]);
        return nil;
    }
    
    
    
    
    return [[NSString alloc]initWithData:oResponceData encoding:NSUTF8StringEncoding];
}

-(void)declareVariables
{
    [Constants shared].daLabel1 = @"Indtast koden der vises på din computer:";
    [Constants shared].daLabel2 = @"Tjek at du har skrevet den rigtige kode og prøv igen.";
    
    [Constants shared].noLabel1 = @"Tast inn koden som vises på datamaskinen din:";
    [Constants shared].noLabel2 = @"Sjekk at du har skrevet riktig kode og prøv igjen.";
    
    [Constants shared].danskServer =@"https://api.matematikfessor.dk/";
    [Constants shared].norgeServer =@"https://api.mattemestern.no/";
    
    
    // DANISH
    
    [Constants shared].danishOne = @"Tag et billede af dine mellemregninger";
    [Constants shared].danishTwo =@"FotoFessor kan tage et billede og gemme det sammen med dine lektier på MatematikFessor.dk.";
    [Constants shared].danishThree=@"Sådan gør du";
    [Constants shared].danishFour=@"Når du laver lektier på MatematikFessor.dk, har du mulighed for at tilføje en mellemregning. Du kan enten tilføje en mellemregning fra din computer, lave den på computeren med Fessors tegneværktøj eller du kan tage et billede af den med din telefon.\n1. Tryk på 'Tilføj note' på din computer.\n2. Indtast den 4-cifrede kode i FotoFessor.\n3. Tag et billede.\nNu bliver billedet sendt fra din telefon til MatematikFessor.dk og kommer efter kort tid frem på skærmen.\n4. Godkend billedet på computeren og gå videre til næste opgave.";
    [Constants shared].danishFive=@"MatematikFessor.dk";
    [Constants shared].danishSix=@"MatematikFessor.dk er Danmarks førende matematikportal, hvor der hver uge løses over 1 mio. spørgsmål. Her kan du få hjælp til matematik på netop dit niveau og få succes med faget.\nFeedback på FotoFessor er mere end velkomment på support@matematikfessor.dk.";
    [Constants shared].danishSeven=@"Vælg sprog";
    
    
    // NORVEGIAN
    
    [Constants shared].norgeOne = @"Ta et bilde av mellomregningene dine";
    [Constants shared].norgeTwo =@"Med FotoMester kan du ta bilder og lagre de sammen med leksene dine på Mattemestern.no.";
    [Constants shared].norgeThree=@"Slik gjør du";
    [Constants shared].norgeFour=@"Når du gjør lekser på Mattemestern.no har du mulighet til å legge til mellomregningene dine. Du kan enten legge den til fra datamaskinen din, lage den på datamaskinen din eller ta et bilde av den med telefonen din.\n1.Trykk på 'Legg til notat' på datamaskinen din.\n2.Tast inn den 4 sifrede koden i FotoMester.\n3.Ta et bilde.\nNå blir bildet sendt fra telefonen din og kommer kort tid etter frem på skjermen din.\n4.Godkjenn bildet på datamaskinen og gå videre til neste oppgave.";
    [Constants shared].norgeSix=@" ";
    [Constants shared].norgeSeven=@"Velg språk";
    
}

-(void)loadData
{
    NSData *settingsData = [[NSUserDefaults standardUserDefaults] objectForKey:@"settings"];
    NSArray *settings = [NSKeyedUnarchiver unarchiveObjectWithData:settingsData];
    
    
    // We picked a language in the past
    if ([settings count]>0){
        
        Language *language = settings[0];
        [Constants shared].language = language.language;
        _firstTime = language.first_time;
    }
    
    // default language is dansk
    else{
        [Constants shared].language = DANSK;
    }
}

- (void)checkWiFiConn
{


    Reachability* wifiReach = [Reachability reachabilityForLocalWiFi];
    NetworkStatus wifiStatus = [wifiReach currentReachabilityStatus];
    
    
    if (wifiStatus!=ReachableViaWiFi)
    {
        _noInternetConnectionTitle =@"No internet connection";
        _noInternetConnectionMessage=@"Enable your Internet connection and try again !";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:_noInternetConnectionTitle
                                                            message:_noInternetConnectionMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        _internet = NO;
    }

    _internet=YES;

}

-(void)setLanguage
{
   
    if (_firstTime != 123 && [self checkDefaultNorge] == YES){
        
        [Constants shared].language = NORGE;
        [_appLogo setImage:[UIImage imageNamed:@"logo.no.png"]];
    }else{
    
        switch ([Constants shared].language) {
        
            case DANSK:
                [_appLogo setImage:[UIImage imageNamed:@"logo.da.png"]];
                break;
            
            case NORGE:
                [_appLogo setImage:[UIImage imageNamed:@"logo.no.png"]];
                break;
        }
    
    }
    
}

-(BOOL)checkDefaultNorge
{
    BOOL returnValue = NO;
    
    NSString *languageCode = [[NSLocale preferredLanguages] objectAtIndex:0];
    
    
    if([languageCode caseInsensitiveCompare:@"nb"]!=NSOrderedSame ){
        returnValue = NO;
    }else{
        returnValue = YES;
    }
    
    return returnValue;
    
}

@end
