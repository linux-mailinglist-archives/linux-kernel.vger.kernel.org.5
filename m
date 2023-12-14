Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27915813094
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573161AbjLNMvp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 07:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573157AbjLNMvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:51:43 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9291D118;
        Thu, 14 Dec 2023 04:51:49 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BECpVzzD840239, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BECpVzzD840239
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 20:51:31 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 14 Dec 2023 20:51:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 14 Dec 2023 20:51:31 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Thu, 14 Dec 2023 20:51:31 +0800
From:   JustinLai0215 <justinlai0215@realtek.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: RE: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet driver entry
Thread-Topic: [PATCH net-next v14 13/13] MAINTAINERS: Add the rtase ethernet
 driver entry
Thread-Index: AQHaKbugZ5rp16i0b0iO+dnZO+m417Clh6iAgAM8spA=
Date:   Thu, 14 Dec 2023 12:51:31 +0000
Message-ID: <34d0ca23a5c44dd8853c01379f4848e2@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-14-justinlai0215@realtek.com>
 <20231212112259.658d3a79@kernel.org>
In-Reply-To: <20231212112259.658d3a79@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
x-originating-ip: [172.21.210.185]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Fri, 8 Dec 2023 17:47:33 +0800 Justin Lai wrote:
> > Add myself and Larry Chiu as the maintainer for the rtase ethernet driver.
> 
> Sorry if I already said this but please familiarize yourself with the
> responsibilities per:
> https://docs.kernel.org/next/maintainer/feature-and-driver-maintainers.html

Larry Chiu is also one of the authors of this driver, so he is added as maintainer.
I would like to ask if you have any questions about this part?
