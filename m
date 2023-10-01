Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274147B48C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 19:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235260AbjJARI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 13:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjJARIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 13:08:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7801CD9
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 10:08:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B593C433CC;
        Sun,  1 Oct 2023 17:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696180100;
        bh=AsUrGvTigNtiBdaq6dBZ/3Z+euzkgYTZDBykESpQd2w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ig5BM3kkeN/4e4Q0a9E69vh/RFt9VcGeDtyCLMEUqFevng1nmGYuCtBG06bS3LzLJ
         6VHeJc+B0BWpk5guMh81Cq4OOvXZ1jjyCWoZNQ/a/tC9Uz2UWCNkcrvbC7NJxKGUIv
         op1FrIG/h0tCPCg2IdVDUfofRyjhv9f23d8ZyoX7aDs8g4BZc9vtJip1lmZSYt6nSS
         XGq0wy28kjUN+KZgi0SZVNi0rLbfxFkma++2wwkpj/45sSgObO2JEO6Lwbh5P6LKYr
         bpvyYl8dTiGPQbABZqvqBSollFaHUlrHzqlxKVe0QReX8wc3lH9084aLdEsJfEoa++
         KO7Fx6oillWtw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00EA5C73FE1;
        Sun,  1 Oct 2023 17:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZRk2K2cwKUP0VcQr@gmail.com>
References: <ZRk2K2cwKUP0VcQr@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZRk2K2cwKUP0VcQr@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-01
X-PR-Tracked-Commit-Id: c6c2adcba50c2622ed25ba5d5e7f05f584711358
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ec8c298121e3616f8013d3cf1db9c7169c9b0b2d
Message-Id: <169618009999.11241.16601847736963540881.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 17:08:19 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 11:04:43 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ec8c298121e3616f8013d3cf1db9c7169c9b0b2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
