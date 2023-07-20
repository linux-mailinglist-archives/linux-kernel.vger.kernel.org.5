Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EEA75A31D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGTAIE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 20:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGTAIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:08:02 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84C2B172D;
        Wed, 19 Jul 2023 17:07:57 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36K07KW00026645, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36K07KW00026645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 20 Jul 2023 08:07:20 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 20 Jul 2023 08:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 20 Jul 2023 08:07:29 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d]) by
 RTEXMBS04.realtek.com.tw ([fe80::e138:e7f1:4709:ff4d%5]) with mapi id
 15.01.2375.007; Thu, 20 Jul 2023 08:07:29 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     "hanyu001@208suo.com" <hanyu001@208suo.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
CC:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rtlwifi: rtl8192ee: phy Remove unnecessary spaces
Thread-Topic: [PATCH] rtlwifi: rtl8192ee: phy Remove unnecessary spaces
Thread-Index: AQHZul8gP4Mndb0sP0a1wxf12P+jRK/BxozA
Date:   Thu, 20 Jul 2023 00:07:29 +0000
Message-ID: <cc001e3a5cdf4f468c5d032757f09679@realtek.com>
References: <tencent_413C0292C42299E2632862909F6D4407C406@qq.com>
 <1fa527d26c2f9535bca96bc39d3d40d5@208suo.com>
In-Reply-To: <1fa527d26c2f9535bca96bc39d3d40d5@208suo.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: hanyu001@208suo.com <hanyu001@208suo.com>
> Sent: Wednesday, July 19, 2023 5:43 PM
> To: Ping-Ke Shih <pkshih@realtek.com>; kvalo@kernel.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH] rtlwifi: rtl8192ee: phy Remove unnecessary spaces

Subject should be "wifi: rtlwifi: ...".

You can check the subject pattern by git log, like: 

$ git log --oneline drivers/net/wireless/realtek/rtlwifi
fef0f427f7122 wifi: rtlwifi: remove misused flag from HAL data
557123259200b wifi: rtlwifi: remove unused dualmac control leftovers
358b94f0a7cad wifi: rtlwifi: remove unused timer and related code
3e450386e99e6 wifi: rtlwifi: use helper function rtl_get_hdr()
5dbe1f8eb8c5a wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_reg()
905a9241e4e8c wifi: rtlwifi: fix incorrect error codes in rtl_debugfs_set_write_rfreg()
82d6077901c67 wifi: rtlwifi: Replace fake flex-array with flex-array member
ff6f38eb920bd wifi: rtlwifi: rtl8192se: Remove some unused variables
db5e4b3645534 wifi: rtlwifi: rtl8192de: Remove the unused variable bcnfunc_enable

> 
> Fix checkpatch warnings:
> 
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:742: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:766: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:766: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:771: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:771: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:927: ERROR: space
> prohibited before that ',' (ctx:WxW)
> ./drivers/net/wireless/realtek/rtlwifi/rtl8192ee/phy.c:974: ERROR: space
> prohibited before that ',' (ctx:WxW)
> 
> Signed-off-by:  Yu Han <hanyu001@208suo.com>

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

[...]


