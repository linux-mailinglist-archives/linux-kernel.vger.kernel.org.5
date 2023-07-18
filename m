Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DB7570F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjGRAar convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGRAam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:30:42 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C193F1A8;
        Mon, 17 Jul 2023 17:30:36 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36I0Toy96005743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36I0Toy96005743
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 18 Jul 2023 08:29:50 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 18 Jul 2023 08:29:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 18 Jul 2023 08:29:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Tue, 18 Jul 2023 08:29:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "hanyu001@208suo.com" <hanyu001@208suo.com>,
        "toke@toke.dk" <toke@toke.dk>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] taging: fbtft: Add space around '='
Thread-Topic: [PATCH] taging: fbtft: Add space around '='
Thread-Index: AQHZuIbt0EenICfU5kC7z+o3op+9Qq++rB5w
Date:   Tue, 18 Jul 2023 00:29:58 +0000
Message-ID: <ca3fb1d8442c4de4949ecfd71c23b058@realtek.com>
References: <tencent_1D773A0CE6639082173515B942C9821A6D09@qq.com>
 <a8b204f8562cb5d4ad837f6df0c14b74@208suo.com>
In-Reply-To: <a8b204f8562cb5d4ad837f6df0c14b74@208suo.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.69.188]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: hanyu001@208suo.com <hanyu001@208suo.com>
> Sent: Monday, July 17, 2023 4:16 PM
> To: toke@toke.dk; kvalo@kernel.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] taging: fbtft: Add space around '='
> 
> Fix checkpatch warnings:
> 
> ./drivers/staging/media/av7110/dvb_filter.c:105: ERROR: spaces required
> around that '=' (ctx:VxV)
> ./drivers/staging/media/av7110/dvb_filter.c:106: ERROR: spaces required
> around that '=' (ctx:VxV)
> ./drivers/staging/media/av7110/dvb_filter.c:108: ERROR: spaces required
> around that '=' (ctx:VxV)
> ./drivers/staging/media/av7110/dvb_filter.c:112: ERROR: spaces required
> around that '=' (ctx:VxV)
> 
> Signed-off-by: maqimei <2433033762@qq.com>
> ---
>   drivers/staging/media/av7110/dvb_filter.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/av7110/dvb_filter.c
> b/drivers/staging/media/av7110/dvb_filter.c
> index 8c2eca5..014fa1f 100644
> --- a/drivers/staging/media/av7110/dvb_filter.c
> +++ b/drivers/staging/media/av7110/dvb_filter.c
> @@ -102,14 +102,14 @@ int dvb_filter_pes2ts(struct dvb_filter_pes2ts
> *p2ts, unsigned char *pes,
>       }
>       if (!len)
>           return 0;
> -    buf[3]=0x30|((p2ts->cc++)&0x0f);
> -    rest=183-len;
> +    buf[3] = 0x30|((p2ts->cc++)&0x0f);
> +    rest = 183-len;

Adding spaces around operators | and & would look better:
  buf[3] = 0x30 | ((p2ts->cc++) & 0x0f);
  rest = 183 - len;


