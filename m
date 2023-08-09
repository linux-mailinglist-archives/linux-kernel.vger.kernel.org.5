Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB9D776CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjHIXMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHIXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:12:00 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659A0D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1691622719;
  h=message-id:date:from:subject:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=O8lGuJ9pvBvbFH1/xlbsfFi0H6mk4DXHNZdQefLy0p8=;
  b=YCfKrVRAzXUZbR5LtvFOZ+ibFLNMrQWDVAe9CLpL0iTTJEO721hL0E5Z
   IsWG1mrxGWx5CTUW8ropJjGLWvOvY4vEyOqpejMTwX2JHIRynUQ7kqKKx
   PUSCJt/h9hezZXbL3u6ZzV9UVwohUUU/Z98Dx/jmn8AB+FENe3BM3WjvH
   0=;
X-IronPort-RemoteIP: 104.47.51.42
X-IronPort-MID: 119066987
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:ak3UP6ztw0dd1GCLb4x6t+enxyrEfRIJ4+MujC+fZmUNrF6WrkUCn
 TYbW2iBMquJMDHwKtF/aN+0o0sHvJeEytJkTAZrryAxQypGp/SeCIXCJC8cHc8wwu7rFxs7s
 ppEOrEsCOhuExcwcz/0auCJQUFUjP3OHfykTrafYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj75sbSIzdJ4RYtWo4vw/zF8EoHUMja4mtC5QRuPaET5zcyqlFOZH4hDfDpR5fHatE88t6SH
 47r0Ly/92XFyBYhYvvNfmHTKxBirhb6ZGBiu1IOM0SQqkEqSh8ai87XAME0e0ZP4whlqvgqo
 Dl7WT5cfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQq2pYjqhljJBheAGEWxgp4KUsXy
 P4HExMEVzPZtcyf44i3Y/V0n/12eaEHPKtH0p1h5RfwKK58BLrlGuDN79Ie2yosjMdTG/qYf
 9AedTdkcBXHZVtIJ0sTD5U92uyvgxETcRUB8A7T+fVxvjGVkFYZPLvFabI5fvSjQ8lPk1nej
 WXB52njWTkRNcCFyCrD+XWp7gPKtXqiCdpMSuzoqZaGhnWq5n4xDjodW2Krjqb+tROOAM1cK
 2gtr39GQa8asRbDosPGdwG/umCNuhIHc95RFfAqrQ+K16zY6hqYAW5CSSROAPQitckrVXkp2
 0WPktfBGzNiqvuWRGib+7PSqim9UQAfNUcLYS4JS1tD79SLiJ08igLnStdlDbKvidv0CXf8z
 liiqSk4iLI7l8MH16ynu1vAhlqEqpHXQ0g17wPMU2SN6gJ/eZ7jZoq05Fyd5vFFRK6ZVlCpr
 mkYnNLY5+cLZbmdxHKlQ+gXGrytofGfP1XhbUVHGpAg83Gn/SeldIUIujVmfh81aIADZCPjZ
 1LVtUVJ/phPMXC2bKhxJYWsF8AtyqumHtPgPhzJUudzjlFKXFfv1ElTiYS4hggBTGBEfXkDB
 Kqm
IronPort-HdrOrdr: A9a23:YNkOra+IyCpagaa1DoBuk+ALI+orL9Y04lQ7vn2ZhyYlCPBw8P
 re/sjztCWVtN91Yh8dcL+7Sc+9qB/nhPpICMwqTM+ftUrdyRWVxeJZnOjfKkPbakrDH7VmpN
 hdmsFFYbWaZzUX4qfHCUuDYq8dKbK8gcWVbInlvgxQZDAvT6lh6gd/BEK/EldqLTM2dKbRDK
 DsmvavuQDQBEgqUg==
X-Talos-CUID: =?us-ascii?q?9a23=3AWb3DimgL3zN8piqbUQtMO1Xz1jJuWCTgzmjrAEa?=
 =?us-ascii?q?BKjxbZpS2c1O55Lt9qp87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABX1asA7UQ9LYZ8IBtayBNnn5xoxRw7aMDmcGn6w?=
 =?us-ascii?q?WlJbDCnFAYCiejBCOF9o=3D?=
X-IronPort-AV: E=Sophos;i="6.01,160,1684814400"; 
   d="scan'208";a="119066987"
Received: from mail-bn1nam02lp2042.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.42])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 09 Aug 2023 19:11:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRQ4Ia3kaOae0hIYsA93wj0Fwe4C0SogZ/cOIdS0BiaL23qwNwS4SrXx3kVCnm0ucM1oR/DOLIU68emU4bOetYVcnxKyZJZVMhKbMOI44QTvwE0jR+PaLpeL4KEH3JpeHjMr7kPHZ97ea+B2sONyYDakk6GC3m/9HSuxZqYJbcIg9VJVrq74L550NOYQbo6yqYWjdp9P6JlI48EzaLOhaiKmWteMQb71Vh5OVDJ0+kiSD9TE0kiqefe1jwc459aTJIreWya0AAXHHXtWKKqpBfzx3S8I8+K85WxHmwUzcDIvcZyfpAH5CuNFxP9Ug/2g2XG7ociCGobJ6E/+e7aS8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdR45hfpHg9A2hPIfnvSFqwByJTHPP0Q2WXcyD34eU4=;
 b=JvDVA3AJJzsJSYAYssGIj0OX59qA/OJDbyS1aXYNnEJzoAHnI+iO4aXChV+5dEHhWdylSEiMsLOvyhpuKxaJINo+UBpSLa9UwLComMibQ6ZddwHFAaFYIf+S3rylrK2JrJC6BmrAwXgY6hemViU5tirbXTqLyFlOMVL0GpZ99Gb0a/f1fXF1oZ53B3U5WTrwJkgVnKm7Ne1L2R4GubHTHiAKIcQQ/iFbww6RKDzAtahP2netr76HV1/P864c/Blbpo7QvVc6rgGuUQHIC6V1XoavNVb+wT6c+EuC+lXd53rNiubdN0qoAXeY70CJ5IRpoTdCdN/H1dV2UjfygrZrtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdR45hfpHg9A2hPIfnvSFqwByJTHPP0Q2WXcyD34eU4=;
 b=G1R6Kpe4wO/ikw66irkmzrPdn8jXK28znxeUz8hCP4kviiChujmheq9M/ui6Rvdcoy1K7NXJM/TcOs2jI1WLVdEL6sFNut7KO2sAF3aPyk7NNt+s4YnY2IAmKSeBrnc66q5jofA1A9n6Lc2Z/a1vjL/wvvrVdarsyTaT+jmVbd8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
Received: from BYAPR03MB3623.namprd03.prod.outlook.com (2603:10b6:a02:aa::12)
 by PH7PR03MB6970.namprd03.prod.outlook.com (2603:10b6:510:12d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 23:11:52 +0000
Received: from BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea]) by BYAPR03MB3623.namprd03.prod.outlook.com
 ([fe80::6bfe:c2d3:2c8e:d2ea%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 23:11:52 +0000
Message-ID: <1e3c8c24-6d94-d325-6661-ee44be073e46@citrix.com>
Date:   Thu, 10 Aug 2023 00:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH] x86/AMD: Fix ASM constraints in amd_clear_divider()
Content-Language: en-GB
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <20230809202356.357339-1-andrew.cooper3@citrix.com>
 <CAHk-=wiic4XViHp0=0pjLnQALRpfda+naY0ysZdK6Fia86hh2w@mail.gmail.com>
In-Reply-To: <CAHk-=wiic4XViHp0=0pjLnQALRpfda+naY0ysZdK6Fia86hh2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR03MB3623:EE_|PH7PR03MB6970:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b0b77c-7588-49ef-f5cd-08db992e03aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+0K03bjRfhGf0LY3m2YLOVC0H2zkbrMV9R9fHRCBsfhjjJg2BbMdwO03S/1LKgBlsSFL9wu5VP2Kc/ye6NNKvB4RsfLqUR7NFPKuyQo1Qxs8UCCqUmh45wsn25MNcc2gTOpdTHw1WducWcwskFmrE+0DsV5jhUN0N1fan17y+wYqyR+Q0VwCM0otI3qTynxWbs2aqMf5MMHy+gjgNziGA2QiU5/S5NHxclWb4diGxIwSDZ0L0Fdt089f5LcGDBH7RQy230ykilpHXgpPbjI4QmgCYhpV+GA2/HgQnlT3goNRhCm2QJvhSwSu7fA5d2kiBMYVyNs1o9wYWNqRwd5ppv4iTkbOVj5vx2C4eDZpEfaB/Mvf/WAcvSs1fR1jT2sZcZel1hZ9QaofzQVuoym1xldRB0arqvopQ6SUGYIpjz2xl8mX5ZUNEsmhxe0EECiupNacxsgBfGnTXQjR/eXilqXKZ8iTzD5qLOWQh7IpI4gZDygZ539Ty/w4cLZK3UlL0RQIKeS/vP7LPwoBaZ5PHk2qTeMrYpH2k7l2uwnoL9K0RcpZ/YH4xWYrQDbXR5cpMGSTChYGpvE9Ic01FZSC6SGVyYD0H2/5e1cHMbT+sO8ElJeJwX0ezGypMEcYK/3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(1800799006)(451199021)(186006)(2616005)(41300700001)(6512007)(6486002)(966005)(86362001)(82960400001)(478600001)(6666004)(26005)(36756003)(6506007)(53546011)(8936002)(5660300002)(38100700002)(8676002)(4326008)(6916009)(31696002)(54906003)(66946007)(66556008)(316002)(66476007)(2906002)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2NBTm1aS0d0N3pnVTBEbWh6Rnp2WkhJZDZuS0VHV3hrZFQ2eURhN3RCcEZK?=
 =?utf-8?B?RVdkak81QVpQQzJPdmJtOWRCOWg5cU1nakFnRTlRQjQ4SzEvSHhucnk4Nzg0?=
 =?utf-8?B?cExLYUM5RVd6UzkwNEE5Smo0SExERmFManFzYTVmem5wT3hteXRLdkVXWmxk?=
 =?utf-8?B?SlRhRlRvdlMvSjJHb3lIcFg5ZDV0N3hLa3RObndOeWplRnkyRnBhNEhwblRO?=
 =?utf-8?B?cUkzYkljckE4Nkwwajk1NjlWVmVqOVVldmFmMjRKRnFHbkluVDM0aHF3MlF4?=
 =?utf-8?B?ZnlkWEFNenZwdWJ6TU9Kci9MNGthNG40Zlk4QXo5L0pIOEYrMUozK25wQ1Nh?=
 =?utf-8?B?NTY4YU4wUm5RSW1VMFYxbTZHVHVtMFpuOFl2VGJsekVkcnJWL0NwYWxybVNQ?=
 =?utf-8?B?aFNvVkV2alRhOHh5UENCWWVmUVU2dW1YWDBRV2NHZFpDeDMyTk40SXdmZHdL?=
 =?utf-8?B?VUdwTFJTZ2xhY253Y0hLbjQzSUVFM1JGS2RjVFE5S01mZ0ZQeVQwbzRRdG9M?=
 =?utf-8?B?aDFlNkNEeTRQRG5OL0pBSGsxVkxEV04zcUxTdjRsbnZERXMwaG9JK1AvcUMr?=
 =?utf-8?B?Y2JYQVVlYWo2d3RGRlAwMFhGczd1cTRDUHRWR0w5bUJRaTJsVHgrUWQ5NHpI?=
 =?utf-8?B?b2ZUQldWQXJZMldxUi9TdmF5WHpaTTVBam1pbTJqVERNU3I5cTQ1d1RsZWFk?=
 =?utf-8?B?WEpMQW1DVDlad2N6dlNPSGYzKzBKMHVIZ1FOMUpISlRVSnh1cXdVL0JTZHZW?=
 =?utf-8?B?eWZKNlFlT3FobWhoN05sOUJ2STZEKzViQzNsMlk3RFNoMlNEcmNPVE9JQUti?=
 =?utf-8?B?aEpqNHJHWDRYT2QvcFEzUHBTMHEvSEhheVBDMkpRNVZocStoUytPMkZ0SVVN?=
 =?utf-8?B?am1uQUhTbExDVzFyT2JkY0tzUmZ2MjNyMFh1dzBaaVFra0hZWFlDTDlJVCt2?=
 =?utf-8?B?M0FkZVlQdGF3NXRtVVh3R2JtRGZwUEpBSXdUbFJ6VFI1Y2o2dEpwS1JNNXA0?=
 =?utf-8?B?empIeHY1MXFSMUJxU1lzdHFGa1YrSW1uY2gyb1dCM295WVdlcXl5YlJQRG9X?=
 =?utf-8?B?Z3h4ajJQL1hQam9ESXRqQVFlMmpMNkhabEc5eExtNk14Z2gxYTBBNVk2dTBm?=
 =?utf-8?B?ZDBGT21McW1SeTMrQkhmdzRSWjhCbzJnQVkrOVhZNFBFVmErZGFFRGFPK3A5?=
 =?utf-8?B?eFpXNEo5TEJ3M21MZjlOZkVRUWRTZTRQSWxGMFc2aUpjVmZLNzVJUG4yd2xG?=
 =?utf-8?B?QXJCeWltWXJkaEQ2UmhYakozTE1XVU8yb3VheUtSSkIvcldrVjJqM29iRXVw?=
 =?utf-8?B?MVc4d0R1anU0NWsycWtSTitrSVZ2UVorTkdDd2NWc1F3RkxaSTBCOU04NTFu?=
 =?utf-8?B?QkYvcUluSWhQa2JVWTFsVEFtMHczWTV4czRITG5FOVROam1jZzNuc3ZQeUND?=
 =?utf-8?B?UW1qckMzUUxHd0pvcUxxMGNpQysvTHpjUkJKYnliRkhFOFl0K0NDOENCZTBK?=
 =?utf-8?B?TktadDdWWXdGanFvMEJIYjdMQ2FJVGx1enBZUkhrOFBxcHd2S2FPR2QzS1d1?=
 =?utf-8?B?ckJsOHJGYllpaHIzNUlpa0lzc2MvSlpucTFacVpYRWpoK0pPNlZIa0RIZnRv?=
 =?utf-8?B?c2FSRWp0c2ZYSVEzQTEvUnhYa1RiRE9UMWVoTUN5L2drSmFCS2R5VzAvQ0x4?=
 =?utf-8?B?ZjRISTljdk5qTDZNR0ttWFJ3YmVocys4Y0ZDUzRoNVNvUmlsamxleGllTEFk?=
 =?utf-8?B?YXl4dzVpUXU1NmphN1B6cnJUSzlwVGNlQ2ZOU1ZFUi90dDFUU0hxblZBQms0?=
 =?utf-8?B?SjUxaFF3cGdDUDljK0dHdTZqamtlMHNYYW9TSU5aQW1vQ1I0QzJqdEE1SHV3?=
 =?utf-8?B?S2lGeHNrTnJoTkxMcVBHdTJRVFB0MmQrdmlVdnBlMThMVTkrclo3bFBvQnE2?=
 =?utf-8?B?M2YxcEV5S3lodklNWFRmNTlCb2ZJcks3eFFKN1d0bVhpdzRUd0l3NkxMbG1t?=
 =?utf-8?B?MllUbWVEOHp1WTNwTGVkS0twR1dkSEIzay9ZNXM3eUF5VnJFL0hiMG9YanI5?=
 =?utf-8?B?clk3UkZyVE8vZk9FSHVJb3BYekU5d1BwWXcyQVdCRHdFRjJNVklZQTA1Z3Bs?=
 =?utf-8?B?ZHBjYmh2ajRyUTJtOElyMEpNZUw2blBMYUhRU21sNDJiOEJTaWZ4VmxMS1pV?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?czlRNXV4blFMWno5K3N4UXhyQ1VWZncwdEJUL0ZzQ045L2dZZjBGYVhGcmF0?=
 =?utf-8?B?YTVwVkE3QnpWOXZoSGUwLzJwV3RvSUdpNGs5MVJObWZEWEFQMVJocEpHKzE3?=
 =?utf-8?B?MFU4VnZlZXlRUzdMNUdHRFZ0b2lUdkRxdm1QMHV4ejZoZ3FQWVNVWkdZVys0?=
 =?utf-8?B?WDJpS2lmN3h6Z25pQVRzUnpycTBndmxFSUhKNDZ2UlVIdGYralViY1FQckI4?=
 =?utf-8?B?elFjcWNhbFBrWVRDNmNwM3QwdFhwaEV1MUJJZFc5eVYzZjUwdGY0TkJPajQ3?=
 =?utf-8?B?ZHhVYnpqR1FsMFNQdEJuWU5Db3R0aFpGUVpUQm9KcHpwakxseUxIR25mdEVC?=
 =?utf-8?B?NTRSSXZrckdLd0srWkQzWkpsUlQrYVNTQ2Y1eXIxWXhlN3d2ODR4Z1RLeFZQ?=
 =?utf-8?B?YmZWaHo5Y0d4WnRsaFBOVitKWC9jY3RKT1ZLK1M0WnRWUUtjV1dHRVlLS0x4?=
 =?utf-8?B?dUs2RG92ZWphMUwweXlsQWY2OXo2UEpPZVlHMWFqalpWSGo2M2l4R3UxWC9F?=
 =?utf-8?B?RTd6S3dqNUJGL3hiKzhvMmpscVpNdTYrelM1cStqVjFueS9QWmsxMkl5dHhz?=
 =?utf-8?B?NzQvdGtlM1JRZHZyQWdqdHl1NTBTQ0t4OE0xbGtLYThkdkdNS014OUJkZkhF?=
 =?utf-8?B?YVQ4Uzh3a0tLUkFsUTF3cldkSUpSRWZDTDJ3c1hwbG1GNWFSb004SU1MME5t?=
 =?utf-8?B?QlE4Lzh4SHlXYlRrd2I4UU56SXVnZlFTSCszWkxLa21qQXVrcFE4c1BXVkJq?=
 =?utf-8?B?MjA2a0hRSTBmUGF5RjdQY0JpNDc2dWJVNmxpbWNNTm9rUlROR0tCSzViYTFS?=
 =?utf-8?B?bk5vUHl5YUlWYmNlZjE1aXZHcnVuSjVYdFAvU3haQVNzWEtxc2t4QVhyOHBK?=
 =?utf-8?B?WjZtTFNzdHBnYnd3L3ptUzkrZUZiMFNJd3FCQ2ZzQWZZVVZWYzNiR2NhOG9t?=
 =?utf-8?B?YklnWTEwMFNvL05MVUh2VUE0QkxCVUpjbDMvYkF6b3BpSEhodFVGUXNlUXM2?=
 =?utf-8?B?UVduZW9zQlMzYzBwYkRrV1l3V09LaWl1WXZydmlSL1ByQlhnTDR6M3ZlYmhF?=
 =?utf-8?B?Zk8xS0xuQlhFSTlRYmlkQTFIKytMQzM5OVFNaFFzUjVLeE1WejF4aktTbk1N?=
 =?utf-8?B?QTZWcWlZTUVObDZ4eVp4MTFSN1BrYnVQOGRGM2FXQW1TaEV3SnIweWF1VXZp?=
 =?utf-8?B?QkpXYUc0ZjQ1T3k4ZGJFaUo2TGlkdS9mOFpJRTdiblV2NVo3TTlLK2RjOStX?=
 =?utf-8?B?N3l6M1pOc2pURVVQQ1RSR0lsY2YvZWkzaVZNYzVLcTY3azU5ZlFkY1l5MnZQ?=
 =?utf-8?Q?saJINnxoTWioRnp1dXwYRWmr5P/kkTkjR5?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b0b77c-7588-49ef-f5cd-08db992e03aa
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 23:11:51.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GH8vynAEOMcLAgEpkCP+xuTiGFEBi6mgeA0jm8KBiomsj/p2BA2UC8PiKBh6c+e4HgjHYWsKsFafYBZ49bitsbAGW3WNXRs/a37LsXHnOXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB6970
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2023 10:33 pm, Linus Torvalds wrote:
> On Wed, 9 Aug 2023 at 13:24, Andrew Cooper <andrew.cooper3@citrix.com> wrote:
>> DIV writes its results into %eax and %edx, meaning that they need to be output
>> constraints too.  It happens to be benign in this case as the registers don't
>> change value, but the compiler should still know.
>>
>> Fixes: 77245f1c3c64 ("x86/CPU/AMD: Do not leak quotient data after a division by 0")
> As mentioned earlier (html, not on list), I think it was intentional
> and this "fix" doesn't really fix anything.
>
> A comment might be good, of course, if this really bothers somebody.
>
> That said, if the code wanted to be *really* clever, it could have done
>
>         asm volatile(ALTERNATIVE("", "div %0", X86_BUG_DIV0)
>                      :: "a" (1), "d" (0));
>
> instead. One less register used, and the same "no change to register
> state" approach.

Yeah, I spotted that as an option, and it does save one whole zeroing
idiom...

But IMO, the risk of someone copy&pasting this as if it were a good
example, and the debugging thereafter ought to be enough of a reason to
avoid klever tricks to save 1 line of C.

> Of course, who knows what early-out algorithm the divider uses, and
> maybe it's cheaper to do 0/1 than it is to do 1/1. Not that I think we
> should care. The main reason to be cute here would be just to be cute.

AMD said "any non-faulting divide".  Which still isn't as helpful as it
could be, because according to Agner Fogh:

             Uops Latency
DIV  r8/m8    1    13-16
DIV  r16/m16  2    14-21
DIV  r32/m32  2    14-30
DIV  r64/m64  2    14-46
IDIV r8/m8    1    13-16
IDIV r16/m16  2    13-21
IDIV r32/m32  2    14-30
IDIV r64/m64  2    14-47

DIV %al looks to be the firm favourite choice.

Assuming the one extra cycle is just for the double-pumped uop, then the
best latency for a divide is 13 cycles across the board.

It doesn't make sense to optimise this as a fastpath.  After all, what
fool would put a real divide-by-1 in their code...

> That said, if you were to use this pattern in *real* code (as opposed
> to in that function that will never be called in reality because
> nobody divides by zero in real code), the register clobbers might be
> useful just to make sure the compiler doesn't re-use a zero register
> content that is then behind the latency of the dummy divide. But
> again, this particular code really doesn't _matter_ in that sense.

Well - that's a different question.

An attacker skilled in the art can easily hide #DE in the transient
shadow of something else, and plenty of people got very skilled in this
particular art trying to make better Meltdown exploits.

So I don't think putting any scrubbing in the #DE handler is going to
stop a real attack.  But I'm just speculating.

~Andrew

P.S. https://www.amd.com/system/files/documents/security-whitepaper.pdf
currently says

"The divide by zero (#DE) fault is signaled[sic] on the integer divide
instructions. No data is forwarded to younger, dependent operations for
speculative execution on this fault."

which needs to be revisited.  Zen1 was the latest-and-greatest when that
whitepaper was written.
