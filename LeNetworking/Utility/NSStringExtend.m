//
//  NSStringExtend.m
//  fushihui
//
//  Created by jinzhu on 10-8-11.
//  Copyright 2010 Sharppoint Group All rights reserved.
//


#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>
#import "NSStringExtend.h"
//#import "NSDataAdditions.h"
#import "NSURLAdditions.h"

#pragma mark -
@implementation NSString(ExtendedForUrlComponents)
- (NSString *)stringByAppendingUrlComponent:(NSString *)urlComponent
{
	if(urlComponent == nil || [urlComponent length] == 0)
		return self;
	
	NSString *url = self;
	int len = [url length];
	unichar tail = [url characterAtIndex:len-1];
	unichar head = [urlComponent characterAtIndex:0];
	unichar sep = (unichar)'/';
	if(tail != sep && head != sep)
	{
		url = [url stringByAppendingString:@"/"];
	}
	url = [url stringByAppendingString:urlComponent];
	return url;
}

- (NSString *)stringByAppendingUrlParameter:(NSString *)param forKey:(NSString *)key
{
	NSString *url = self;
	NSRange ret = [url rangeOfString:@"?"];
	if(ret.location == NSNotFound)
	{
		url = [url stringByAppendingFormat:@"?%@=%@", key, param];
	}
	else
	{
		url = [url stringByAppendingFormat:@"&%@=%@", key, param];
	}
	
	return url;
}

- (NSString *)stringbyDeletingUrlParameter:(NSString *)key
{
    NSRange range = [self rangeOfString:@"?"];
    if(range.length == 0)
    {
        return self;
    }
    
    BOOL bFound = NO;
    
    NSString *target = [key stringByAppendingString:@"="];
    NSString *query = [self substringFromIndex:range.location + 1];
    NSMutableArray *parameters = [NSMutableArray arrayWithArray:[query componentsSeparatedByString:@"&"]];
    for(NSString *aParam in parameters)
    {
        if([aParam hasPrefix:target])
        {
            [parameters removeObject:aParam];
            bFound = YES;
            break;
        }
    }
    
    if(!bFound)
    {
        return self ;
    }
    
    NSString *finalUrl = [self substringToIndex:range.location];
    if([parameters count])
    {
        NSString *reQuery = @"";
        for(NSString *aParam in parameters)
        {
            if([reQuery length])
            {
                reQuery = [reQuery stringByAppendingString:@"&"];
            }
            reQuery = [reQuery stringByAppendingString:aParam];
        }
        
        finalUrl = [finalUrl stringByAppendingString:reQuery];
    }
    
    return finalUrl;
}

- (NSString *)stringByAddPrefix:(NSString *)prefix
{
	NSString *url = self;
	if (![url hasPrefix:prefix])
	{
		//NSAssert(0, (@"url missing the prefix:%@",url));
		url = [NSString stringWithFormat:@"%@%@",prefix,url];
		
	}
	return url;
}

- (NSString *)stringByReplaceUrlHost:(NSString *)newHost
{
	NSURL *tmpUrl = [NSURL URLWithString:self];
	return [tmpUrl stringByReplacingUrlHost:newHost];
}

- (BOOL)isAppUrlString
{
	return [[NSURL URLWithString:self] isAppURL];
}

- (BOOL)isNmuberString
{
    BOOL isNmuberString = NO;
    long long int n = [self longLongValue];
    if (n < 18999999999 && n > 13000000000) {
        isNmuberString = YES;
    }
    return isNmuberString;
}

- (BOOL)isEmailString
{
    BOOL isEmailString = NO;
    NSRange range = [self rangeOfString:@"@"];
    if (range.length > 0) {
        isEmailString = YES;
    }
    return isEmailString;
}

@end


#pragma mark -
@implementation NSString(URLEncodeExtended)

+ (NSString*)stringWithStringEncodeUTF8:(NSString *)strToEncode
{
	if (strToEncode == nil ) {
		return @"";
	}
	
	return [strToEncode urlEncodedStringUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)encodedUTF8String
{
	return [self urlEncodedStringUsingEncoding:NSUTF8StringEncoding];
}


+ (NSString*)stringWithStringUrlEncoded:(NSString *)strToEncode usingEncoding:(NSStringEncoding)encoding
{
	if (strToEncode == nil ) {
		return @"";
	}
	
	return [strToEncode urlEncodedStringUsingEncoding:encoding];
}

- (NSString *)urlEncodedStringUsingEncoding:(NSStringEncoding)encoding
{
	CFStringEncoding cfencoding = CFStringConvertNSStringEncodingToEncoding(encoding);
    
	return [self urlEncodedUsingCFStringEncoding:cfencoding alreadyPercentEscaped: NO];
}

//- (NSString *)urlEncodedUsingCFStringEncoding:(CFStringEncoding)cfencoding alreadyPercentEscaped:(BOOL)percentEscaped
//{
//    //CFStringRef nonAlphaNumValidChars = CFSTR("![ DISCUZ_CODE_1 ]’()*+,-./:;=?@_~");
//	CFStringRef nonAlphaNumValidChars = CFSTR("![ ]’()*+,-./:;=?@_~");
//	CFStringRef preprocessedString = NULL;
//    if(percentEscaped)
//    {
//        preprocessedString = CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault, (CFStringRef)self, CFSTR(""), cfencoding);
//    }
//	CFStringRef newStr = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,preprocessedString ? preprocessedString : (CFStringRef)self,
//                                                                 NULL,nonAlphaNumValidChars, cfencoding);
//	if(preprocessedString)
//    {
//        CFRelease(preprocessedString);
//    }
//	NSString *re = [NSString stringWithFormat:@"%@",(NSString *)newStr];
//	CFRelease(newStr);
//	return re;
//}
//
//- (NSString *)urlEncodedUsingCFStringEncoding:(CFStringEncoding)cfencoding
//{
//    return [self urlEncodedUsingCFStringEncoding: cfencoding alreadyPercentEscaped:YES];
//}
//
//- (NSString *)urlDecodeUsingCFStringEncoding:(CFStringEncoding)encode
//{
//    return (NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
//                                                                                ( CFStringRef)self,
//                                                                                CFSTR(""),
//                                                                                encode);
//    
//}
//
//- (NSString *)decodedUTF8String
//{
//    return [self urlDecodeUsingCFStringEncoding:kCFStringEncodingUTF8];
//}
@end

#pragma mark -
@implementation NSString(MD5Extended)
//+ (NSString *)stringWithUUIDGenerated
//{
//	CFUUIDRef uuid = CFUUIDCreate(NULL);
//	CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
//	NSString *finalStr = [NSString stringWithString:(NSString *)uuidStr];
//	CFRelease(uuid);
//	CFRelease(uuidStr);
//	
//	return finalStr;
//}


+(NSString*)generatingMD5:(NSArray *)array
{
    if(array==nil )
		return @"ERROR GETTING MD5";
	
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
	
	for(NSString *string in array)
	{
		const char* data = [string UTF8String];
        CC_MD5_Update(&md5, data, strlen(data));
	}
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
	NSString* md5String = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						   digest[0], digest[1],
						   digest[2], digest[3],
						   digest[4], digest[5],
						   digest[6], digest[7],
						   digest[8], digest[9],
						   digest[10], digest[11],
						   digest[12], digest[13],
						   digest[14], digest[15]];
	
	
    return md5String;
}

//- (NSString*)md5Hash
//{
//	return [[self dataUsingEncoding:NSUTF8StringEncoding] md5Hash];
//}
@end


#pragma mark --
@implementation NSString(StringCount)
- (int)getChineseStringLength:(NSString*)strtemp
{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

- (float)chineseLength
{
    if (!self) {
        return 0.0;
    }
    
    NSUInteger len = self.length;
    
    // 汉字字符集
    NSString *pattern = @"[\u4e00-\u9fa5]";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    
    // 计算中文字符的个数
    NSInteger numMatch = [regex numberOfMatchesInString:self options:NSMatchingReportProgress range:NSMakeRange(0, len)];
    
    return (len + numMatch) / 2.0;
}

@end
#pragma mark --
@implementation NSString(Base64Extended)
//- (NSString*)base64Encoding
//{
//	NSData* data;
//    data = [NSData base64EncodedData:self withWrapped:NO];
//	NSString* string = [[NSString alloc] initWithCString:(const char*)[data bytes] encoding:NSUTF8StringEncoding];
//	
//	return [string autorelease];
//}
//
//- (NSString*)base64Decoding
//{
//	NSData* data;
//	data = [NSData base64DecodedData:self];
//	NSString* string = [[NSString alloc] initWithCString:(const char*)[data bytes] encoding:NSUTF8StringEncoding];
//	return [string autorelease];
//}

@end


#pragma mark -
@implementation NSString (CoreTextExtention)

//- (NSArray *)splitStringWithFont:(UIFont *)font constrainedToWidth:(CGFloat)lineWidth {
//	CGRect box = CGRectMake(0,0, lineWidth, CGFLOAT_MAX);
//	
//	CGMutablePathRef path = CGPathCreateMutable();
//	CGPathAddRect(path, NULL, box);
//	
//	CFMutableAttributedStringRef _attributedString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
//	int length = CFAttributedStringGetLength(_attributedString);
//	CFAttributedStringReplaceString(_attributedString, CFRangeMake(0, length), (CFStringRef)self);
//	CGFloat pointSize = [font pointSize];
//	CTFontRef myFont = CTFontCreateWithName((CFStringRef)[font fontName], pointSize, NULL);
//	int newLength = CFStringGetLength((CFStringRef)self);
//	CFAttributedStringSetAttribute(_attributedString, CFRangeMake(0, newLength), kCTFontAttributeName, myFont);
//	CFRelease(myFont);
//	CTFramesetterRef _framesetter = CTFramesetterCreateWithAttributedString(_attributedString);
//	CFRelease(_attributedString);
//	
//	// Create a frame for this column and draw it.
//	CTFrameRef _frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, NULL);
//	
//    CFRelease(path);
//    //{ added cxt 2011-12-31
//    CFRelease(_framesetter);
//    
//	CFArrayRef _lineArray = CTFrameGetLines(_frame);
//	NSMutableArray *returnedArray = [NSMutableArray array];
//	CTLineRef oneLine = NULL;
//	CFRange oneRange;
//	NSString *oneSubString = NULL;
//	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
//	for (int i = 0; i < CFArrayGetCount(_lineArray); i++) {
//		oneLine = CFArrayGetValueAtIndex(_lineArray, i);
//		oneRange = CTLineGetStringRange(oneLine);
//		oneSubString = [self substringWithRange:NSMakeRange(oneRange.location, oneRange.length)];
//		[returnedArray addObject:oneSubString];
//	}
//    CFRelease(_frame);
//	[pool drain];
//	return returnedArray;
//}

@end


#pragma mark -
@implementation NSString (WhitespaceExtention)

- (NSString *) trimmedString {
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	return [trimmedString length] ? trimmedString : nil;
}

- (BOOL)isWhitespaceAndNewlines {
    NSCharacterSet* whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![whitespace characterIsMember:c]) {
            return NO;
        }
    }
    return YES;
}


- (BOOL)isEmptyOrWhitespace {
    // A nil or NULL string is not the same as an empty string
    return 0 == self.length ||
    ![self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length;
}

@end


#pragma mark -
@implementation NSString (FormatExtention)
+ (NSString *)stringFromTime:(CGFloat)time
{
    if (time < 0) {
        time = 0;
    }
	int nHours = (int)(time/3600);
	time -= nHours *3600;
	int nMinutes = (int)(time/60);
	time -= nMinutes*60;
	int nSeconds = (int)time%60;
	if(nSeconds <= 0) nSeconds = 0;
	
	NSMutableString*strRet = [NSMutableString stringWithFormat:@"%02d:%02d:%02d",nHours,nMinutes,nSeconds];
	return [NSString stringWithString:strRet];
}

+ (NSString *) trimHourStringFromTime:(CGFloat)time {
    if (time < 0) {
        time = 0;
    }
	int nHours = (int)(time/3600);
	time -= nHours *3600;
	int nMinutes = (int)(time/60);
	time -= nMinutes*60;
	int nSeconds = (int)time%60;
	if(nSeconds <= 0) nSeconds = 0;
	
	NSMutableString*strRet;
    if (nHours == 0) {
        strRet = [NSMutableString stringWithFormat:@"%02d:%02d",nMinutes,nSeconds];
    }
    else {
        strRet = [NSMutableString stringWithFormat:@"%02d:%02d:%02d",nHours,nMinutes,nSeconds];
    }
	return [NSString stringWithString:strRet];
}

+ (NSString *)stringWithObject:(id)object
{
    if (object)
    {
        if ([object isKindOfClass:[NSNull class]])
        {
            return @"";
        }
        if ([object isKindOfClass:[NSString class]])
        {
            return [self stringWithString:object];
        }
        else
        {
            return [self stringWithFormat:@"%@",object];
        }
    }
    return @"";
}

+ (NSString *)stringWithNum:(id)num
{
    if (num)
    {
        if ([num isKindOfClass:[NSNull class]])
        {
            return @"";
        }
        else
        {
            NSInteger count = [num integerValue];
            if (count > kMAX_NUM_LIMITE)
            {
                return [self stringWithFormat:@"%d+",kMAX_NUM_LIMITE];
            }
            else
            {
                return [self stringWithFormat:@"%ld",(long)count];
            }
        }
    }
    return @"";
}

+ (NSString *)stringWithFormatedFileSize:(int64_t)fileSize
{
    if(fileSize < 1024)
    {
        return [NSString stringWithFormat:@"%lldb", fileSize];
    }
    
    if(fileSize < 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.1fkb", (float)(fileSize / 1024)];
    }
    
    float size_MB = fileSize / (1024.0 * 1024.0);
    return [NSString stringWithFormat:@"%0.2fM",size_MB];
}

- (NSString *) formatCurrentTime {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [dateFormatter setDateFormat:self];
    NSDate *theday = [NSDate dateWithTimeIntervalSinceNow:0];
    NSString *currentTime = [dateFormatter stringFromDate:theday];

    return currentTime;
}

- (NSInteger) secondsValue {
    NSString *datePrefix = @"1990-01-01 01:";
    NSString *baseTimeLineStr = @"00:00";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:[NSString stringWithFormat:@"%@%@",datePrefix,self]];
    if (date) {
        NSDate *baseDate = [formatter dateFromString:[NSString stringWithFormat:@"%@%@",datePrefix,baseTimeLineStr]];
        return [date timeIntervalSinceDate:baseDate];
    }
    
    datePrefix = @"1990-01-01 ";
    baseTimeLineStr = @"00:00:00";
    
    date = [formatter dateFromString:[NSString stringWithFormat:@"%@%@",datePrefix,self]];
    if (date) {
        NSDate *baseDate = [formatter dateFromString:[NSString stringWithFormat:@"%@%@",datePrefix,baseTimeLineStr]];
        return [date timeIntervalSinceDate:baseDate];
    }
    return 0;
}

@end

@implementation NSString (MatchesEmptyString)

+(BOOL)isBlankString:(NSString *)string
{
    
    if (string == nil)
    {
        return YES;
    }
    if (string == NULL)
    {
        return YES;
    }
    
    if ([string isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0)
    {
        return YES;
    }
    return NO;
}

@end

#pragma mark -
@implementation NSString (AssignmentExtention)
+ (NSString *)stringWithObject:(id)object withOriginalString:(NSString *)string
{
    NSString *objectString = [NSString stringWithObject:object];
    if (objectString.length != 0) {
        return objectString;
    }
    else {
        return string;
    }
}

@end


@implementation NSString (SubstringeExtention)

- (NSString *) subStringBetweenLeftStr:(NSString *) leftStr WithRightStr:(NSString *) rightStr {
    NSRange leftStrOcurRange;
    NSRange rightStrOcurRange;
    NSRange destStrRange;
    
    if (leftStr) {
        leftStrOcurRange = [self rangeOfString:leftStr];
    }
    else {
        leftStrOcurRange.location = NSNotFound;
        leftStrOcurRange.length = 0;
    }

    if (rightStr) {
        rightStrOcurRange = [self rangeOfString:rightStr];
    }
    else {
        rightStrOcurRange.location = NSNotFound;
        rightStrOcurRange.length = 0;
    }

    if (leftStrOcurRange.location == NSNotFound && leftStrOcurRange.length == 0) {
        destStrRange.location = 0;
        if (rightStrOcurRange.location == NSNotFound && rightStrOcurRange.length == 0) {
            destStrRange.length = [self length];
        }
        else {
            destStrRange.length = rightStrOcurRange.location;
        }
    }
    else {
        destStrRange.location = leftStrOcurRange.location + leftStrOcurRange.length;
        if (rightStrOcurRange.location == NSNotFound && rightStrOcurRange.length == 0) {
            destStrRange.length = [self length] - destStrRange.location;
        }
        else {
            destStrRange.length = rightStrOcurRange.location - destStrRange.location;
        }
    }
    
    if (destStrRange.length > 0) {
        return [self substringWithRange:destStrRange];
    }
    return nil;
}

@end

@implementation NSString (DateExtention)

- (NSDate *) millisecondStrDate {
    //服务端传的时间戳是毫秒单位
    NSTimeInterval timeInterval = [self doubleValue]/1000;
    return [NSDate dateWithTimeIntervalSince1970:timeInterval];
}

@end

