Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBDB7E7458
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 23:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345280AbjKIW2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 17:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345361AbjKIW2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 17:28:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB80D62;
        Thu,  9 Nov 2023 14:28:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9213AC433C7;
        Thu,  9 Nov 2023 22:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699568892;
        bh=P4tLCsXngk6BlxZ6N36qIRzrXCLMnjegub0TThlbsnU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DmYPI7kV/qMEfqqEOdbD6RC9koaZPh7qN0pSfYBw7bKSKznONGj52bnVdZYU1DOhJ
         T6etuqH4s873oteqFZBAfoDvalzIDmrg+6Ojj37IHTH5cP+KJyIf+qLpi/RgT/OKf9
         AxWt3nDWdLaxSZzTRZgJBUZE8PwWaJpNUdV5K0OW/jr5e6qqz14an0QVxQ7Swh4tnC
         p7XCcOpt7w2yuebqJAENIvtH3kS7hAE0AnpRTIVAAhM8ooYXhdJ25fvk+U5MTvNeOE
         p87ioQ2QtOX+4Ye5o/nIZm2MC1VjsNnCVtRZTxvjjc3x8Yg9+iq/qFpAMYkPcaN9qn
         Ox3rhH/Ef15aA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 800E3C43158;
        Thu,  9 Nov 2023 22:28:12 +0000 (UTC)
Subject: Re: [GIT PULL REQUEST] watchdog - v6.7 release cycle.
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231108194639.GA29922@www.linux-watchdog.org>
References: <20231108194639.GA29922@www.linux-watchdog.org>
X-PR-Tracked-List-Id: <linux-watchdog.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231108194639.GA29922@www.linux-watchdog.org>
X-PR-Tracked-Remote: git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.7-rc1
X-PR-Tracked-Commit-Id: 9d08e5909c81188eb1df26ef9d1c8df58ea5a44d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12418ece0d662ac6e7325eddefed841b25578fa3
Message-Id: <169956889251.16549.10655172732324467879.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Nov 2023 22:28:12 +0000
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Darren Hart <darren@os.amperecomputing.com>,
        George Cherian <george.cherian@marvell.com>,
        Huqiang Qin <huqiang.qin@amlogic.com>,
        Jacky Bai <ping.bai@nxp.com>, Janne Grunau <j@jannau.net>,
        Jinjie Ruan <ruanjinjie@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matti =?iso-8859-1?Q?Lehtim=E4ki?= <matti.lehtimaki@gmail.com>,
        Michael Shych <michaelsh@nvidia.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Werner Fischer <devlists@wefi.net>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Zev Weiss <zev@bewilderbeest.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 8 Nov 2023 20:46:39 +0100:

> git://www.linux-watchdog.org/linux-watchdog.git tags/linux-watchdog-6.7-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12418ece0d662ac6e7325eddefed841b25578fa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
