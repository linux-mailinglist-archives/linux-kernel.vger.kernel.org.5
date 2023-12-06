Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AC7807358
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442413AbjLFPGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379116AbjLFPGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:06:15 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5529BD59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 07:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1701875172; x=1702134372;
        bh=nWjF/dN7SA0jDm6Fsn/8hZabWMGw+/v/w9ey8CJZtfQ=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=VKO6xFc5aNqCnBgXlwOURRifdGCgCGuFM2YOicSVZQA5ZVsoXddVJou6x7hYmvVQp
         ox2T/P9bgj8mTK+hVOUE/Pq/BhggCWp8HNPDJ7AF4VpD2r6n28voICAvWUQpDN6VEh
         12fLEvptluTjgMlnQXCdgZFobC4hZ9sAspenYvglVcwp9u10jAV3gbupQmxQ3Die/3
         ynn7RQxBBHl0mN44FBXRQHEGw8b9B/4id1273emdHGHPJT4H7wQ8Mdg1i3UNcdIOhb
         1M0IIJeq+6yi2z+Y18bkHnRrbrguoXFa3m8qLtqjeirUV2UQn128V6JhNv0hHRQyyf
         nyjX/2PmXzEDw==
Date:   Wed, 06 Dec 2023 15:06:02 +0000
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Turritopsis Dohrnii Teo En Ming <teo.en.ming@protonmail.com>
Cc:     "ceo@teo-en-ming-corp.com" <ceo@teo-en-ming-corp.com>
Subject: Linux kernel 4.14.302 cannot support and cannot detect Intel Ethernet Controller I225-V 2.5 Gbps network interface cards
Message-ID: <qWDq6DId3kX16C-zBtZDhiQA2k0vcBtQrUN1fktL1exvNj3q9ye6IjHgYErmSy-P1W9hnXdZ0CXcpxzEuNbBBxRFHbBC37I1GODNoJhuTww=@protonmail.com>
Feedback-ID: 39510961:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: Linux kernel 4.14.302 cannot support and cannot detect Intel Ether=
net Controller I225-V 2.5 Gbps network interface cards

Good day from Singapore,

Recently I was trying to install the latest Sophos Firewall SFOS version 20=
.0.0 GA-Build222 on my shiny brand new SGD$222 Intel Celeron J4125 firewall=
 hardware appliance. Sophos Firewall SFOS version 20.0.0 GA-Build222 has Li=
nux kernel 4.14.302. Unfortunately, it cannot support and cannot detect Int=
el Ethernet Controller I225-V 2.5 Gbps network interface cards at all.

May I know what is the minimum Linux kernel version that will support and d=
etect Intel Ethernet Controller I225-V 2.5 Gbps network interface cards?

I need this information so that I can feedback to and request Sophos to upg=
rade their Linux kernel in the next release of Sophos XG Firewall to suppor=
t Intel Ethernet Controller I225-V 2.5 Gbps network interface cards.

Many of the newer generation firewall hardware appliances come with 2.5 Gbp=
s network cards and I need this support in the Linux kernel.

Thank you very much.

Regards,

Mr. Turritopsis Dohrnii Teo En Ming
Targeted Individual in Singapore
Blogs:
https://tdtemcerts.blogspot.com
https://tdtemcerts.wordpress.com
GIMP also stands for Government-Induced Medical Problems.
6 Dec 2023 Wednesday 11.04 PM




Sent with Proton Mail secure email.
