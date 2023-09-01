Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76639790137
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350540AbjIARKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350501AbjIARK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:10:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375E010FB
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D96C9B82488
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85353C433CA;
        Fri,  1 Sep 2023 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693588218;
        bh=TF4PpABVSIgbGMfXPo3AE1SQTph+9NkpbsNbii82uyw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=anhbX746roliUWta/jNez+XZX7ZobpJrFgCZs1Rny/85whiNcBowqd1UFSHxrntyh
         exE/LW5Vt7WshJ8gbBhc8uZoPoRjjayorwYVWjUZkTzQSoueM+cNRsN3xXXKL85UJG
         peNXrQ7v2htfPS56RVo91VFSRpRlHpyfoYdVlnQ5H+YRWZ5yj/uFKBZpucMmYWo9LU
         Zwe9MdhQP1FKbuZ428rAW/VE5BhdVHLWpZf8J/FISE5NGJLX0X625V+e2mTb5177/X
         3iHoO4gp14emWXb4Zk5of7wovH00Blwq05I5Z1zhCOBxvi7/PvWfJHoYXwfUm+eL/V
         IgqbDGu76tEug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A1B7C595D2;
        Fri,  1 Sep 2023 17:10:18 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 6.6-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <81a2b354-1967-d647-34b2-9721af85bde6@redhat.com>
References: <81a2b354-1967-d647-34b2-9721af85bde6@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <81a2b354-1967-d647-34b2-9721af85bde6@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-1
X-PR-Tracked-Commit-Id: acce85a7dd28eac3858d44230f4c65985d0f271c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2c874f999f079e3ec9b8071e92c87d57aded3b6
Message-Id: <169358821840.1073.16874303348362966420.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 17:10:18 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 16:11:28 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.6-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2c874f999f079e3ec9b8071e92c87d57aded3b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
