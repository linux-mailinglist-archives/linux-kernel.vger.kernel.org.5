Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0677DC446
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjJaCMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjJaCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE9EEA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9B919C4339A;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=GudP/eyN7f2sLIkCPna82tEBeLu4b5LeXvv9XHKLNLc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IBseMSybHW4/mKNQ/AItmlmIfHd0W/e7X0w55GhbaAMb8bGv7gJ8hywLJw/L/ACEX
         Np/N9x8GG95MylOa93U5l4u1dUecAnvWVXZr0LcmlwTvEPRE/0JtWBx7gEHCQMpZjd
         4WrI3ZaRSrOSHGje2Cc94E33Yg0SU4zXq+q66tq2Ee2BLEyikiGPX8B0ktaUZprt7z
         rHDYIwnAapqvSKftTWE0qAh2IEZsA9qKuMn+8rFBvUJTH5DtQ0be3otUgXUqhO2vZy
         6oNyA7BEK0df4Yw7mPPLrEoJDB9aJXLtBR0b89ayPwaF5XvBUOzgxDFT98kzjmXqaA
         XJly5+XeVFHJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89245C595D7;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/entry changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0OqhIh/7c9IOYU@gmail.com>
References: <ZT0OqhIh/7c9IOYU@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0OqhIh/7c9IOYU@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2023-10-28
X-PR-Tracked-Commit-Id: 1a09a27153f91cd7676b2d4ca574577572a8c999
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed766c26119c4cf9b1f909f045c2eb987180ace3
Message-Id: <169871835155.5591.4123840542069116518.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:31 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Uros Bizjak <ubizjak@gmail.com>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 15:37:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-entry-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed766c26119c4cf9b1f909f045c2eb987180ace3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
