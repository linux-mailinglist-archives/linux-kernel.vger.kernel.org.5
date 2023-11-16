Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0EC7EE29B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbjKPOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKPOUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:20:14 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCBCB7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1700144408; x=1700403608;
        bh=bSL54XFujjnUItB0IP0F0Ve8hGbtWrDI2x0X5lvbQDg=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=Q5No42BeVUiWbvsKL/m6oRlEhKus2mqdGToqc5Pcv9BaUWk/CbWRpLNXmEjAMoC7v
         uo5ShRZRHnSE2B7+oeuv7p1TNhkYkOj7/m/WXhsn1LsoWapb3OyoXAdjGpPj7c0CZw
         5sAmWV/On53WhbKL1fNB9tSo991xzjZFanKHy8Jy3lM4wZLIpiP/XPi4E1h48hnxFH
         ShAD89oXZ+paeREyh21Idq2dk6/AeKZNJ678HDTsGFkPpMtCIX94yzjpMAiBHwETAr
         BXr1FvYkrx1Pm6dtx1K/NRBLhWGOKxmPtzONFfwxyMlQZ3/wb5WUUN4PDWcmvqING4
         m3K8MbhlxrXVQ==
Date:   Thu, 16 Nov 2023 14:19:47 +0000
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Teo En Ming has just discovered that the latest Sophos Firewall SFOS version 20.0.0 GA-Build222 is running on Linux kernel 4.14.302
Message-ID: <rjsYjj5lRT_rd91lLJ0DutYwgag5By6ghI92s1AFP5asT4IDtTlKhkt56KrcNBGKEKMWQYn430H-bs3-IS4GjEFQjKd79ZHv9iRDd1EVQiU=@protonmail.com>
Feedback-ID: 39510961:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Teo En Ming has just discovered that the latest Sophos Firewall SF=
OS version 20.0.0 GA-Build222 is running on Linux kernel 4.14.302

Good day from Singapore,

I have just discovered that the latest Sophos Firewall SFOS version 20.0.0 =
GA-Build222 is running on Linux kernel 4.14.302.

# uname -a
Linux localhost 4.14.302 #2 SMP Wed Nov 1 07:16:58 UTC 2023 x86_64 GNU/Linu=
x

However, I do not know which Linux distro Sophos Firewall is based on. When=
 I run the Linux command "cat /etc/lsb-release", the output is
DISTRIB_ID=3DSophos Firewall

Hence I do not know which Linux distro the Sophos Firewall is based on.

Additionally, Sophos Firewall is also using the open source Snort Intrusion=
 Prevention System (IPS) by Cisco. I saw the directory snort inside /etc/ w=
hen I am inside the terminal.

I simply love Linux and open source! Billions of network security appliance=
s and networking devices are based on Linux.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.
16 Nov 2023 Thursday Singapore Time




Sent with Proton Mail secure email.
