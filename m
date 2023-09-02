Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41F57908A4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjIBQN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 12:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbjIBQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 12:13:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A923E42
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 09:13:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 715F3CE2611
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 16:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3F24C433CC;
        Sat,  2 Sep 2023 16:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693671200;
        bh=tz1HDgpilQUqS5+7eKaFzLaL3hwf97uY3+lx5oZOjCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=X4M+q3sDdUWimmW8i2X7SK1XfNm3URjYkypECkiN14Hda7dlgqoBZPZOHlcXNs236
         SJ5wRwC3Kek/JwKzfRmXyL1vhzy7PmbXN3wbl0bIREXK7YgZ8yIpF6UcE3PxRpdhcz
         Pv7RuXk+COj6XRVoO/CN+NZ/gsTGRGVZwen/SLhYopyoiyoi1Tu/PSSMPMyAm75jkL
         7wtzuuaJcI7d98AAq1srkbi7Yzb34irZhqsrFVv6bjsgLayYBTj7EqljsHYeggTBXh
         i0IBwyhn9oPXAavh/kluKswyjG7vzMEdA/OsQifNmIt1p2YbAM4CWNvOYccfbfOqrM
         LEqW0AAbyOWSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1010E26D49;
        Sat,  2 Sep 2023 16:13:20 +0000 (UTC)
Subject: Re: [GIT PULL] timers fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPML+/Q7TpgLCQfB@gmail.com>
References: <ZPML+/Q7TpgLCQfB@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPML+/Q7TpgLCQfB@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-09-02
X-PR-Tracked-Commit-Id: 96c1fa04f089a7e977a44e4e8fdc92e81be20bef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a6216978de56138404e7fd61563f0f199eebf22a
Message-Id: <169367120065.31473.10129720607859603057.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Sep 2023 16:13:20 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 2 Sep 2023 12:18:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2023-09-02

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a6216978de56138404e7fd61563f0f199eebf22a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
