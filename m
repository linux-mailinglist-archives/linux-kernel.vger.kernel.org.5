Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822597DC455
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjJaCMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjJaCMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D76BE9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86F1FC43397;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=pi5eJSyoSpp/nh3rExfnFVTiiAJt5+vBHN0Iq+p7C1E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YZrs+kf7p0gX5Ra3iiAP31maqmaUXhuNN+CO5hfiiRWpsCdTnUCaWHVtYa4ISmv0N
         qRwIavMbIvC5rsnFCbZq+NdnxvLonFRpEzgLQYfmqmMfRPHlmk+GZmZ9M2vL5idwmN
         B65oJmGslzVyNrVpRZUofvwTqNhJut+95CbNGIuOirP21fkMB+PJfYZlzcTLGtWk3I
         KVns/3LMU9ILvrkY3o/mTmYzFDCx9q/4++LkXzhSGO2ngCiiyfOqcB0DSEmS/YTZJp
         GOe3rmTAXYAbNGCa9JpKD+/zByHdF+ZolfPsVfZojw0NkaMlJr4N3PLiB3V116BNat
         hufUwYqBJFfZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E9C7EAB08C;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/build change for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0MiAYT40md4uIS@gmail.com>
References: <ZT0MiAYT40md4uIS@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0MiAYT40md4uIS@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-10-28
X-PR-Tracked-Commit-Id: 70c8dc9104275037a39ab0b2a4ed6eaacac39e32
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ecb8cd2a9f7af7f99a6d4fa0a5a31822f6cfe255
Message-Id: <169871835144.5591.10777709299641749763.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:31 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 15:28:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ecb8cd2a9f7af7f99a6d4fa0a5a31822f6cfe255

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
