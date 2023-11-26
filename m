Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5AA7F9480
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjKZRQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjKZRQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:16:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C90107
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:16:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDE1EC433CA;
        Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701018979;
        bh=Cxn3Q0JlrJh/kyq5+xNXvV1qqi+HDvRsSxLiYNFjALg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JXdWME6aN8SlbJvZXaEi+3yn3+ej+v6sO9+bncw8RFfjyZh/zbyTcORPXYZNXxzYp
         PkPse/dLv/TsLkW1h+x7bVY83+uYnnw3++jQfGsI5yNyC1pU9a7nEADvEicZ9KCK3m
         J1iHthtF+Y2yb3DdmpYbYQ4Fv5aAc5DU/QyFH2aijxHwui5xe1pUy+IryiU44g+0Um
         tSgwtg4WseTB1T1F4LoqgLV8wFR6d1XW3soo182cA0GVbLXRczTWGejaG3qOXqgKno
         VlBnUt10oHiA6GR2HL1DmmFBd0Q2wBF0azhAQ+G3RCwTnUG2sxROI4Mjx/kCs2q6JN
         qq5gxFslgp88w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7565E29F40;
        Sun, 26 Nov 2023 17:16:19 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWMVJCJdugia9YIL@gmail.com>
References: <ZWMVJCJdugia9YIL@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWMVJCJdugia9YIL@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-11-26
X-PR-Tracked-Commit-Id: 080990aa3344123673f686cda2df0d1b0deee046
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4892711acee0915a8a4ae02e1af3dc70ce000024
Message-Id: <170101897974.23229.18306333190052899797.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Nov 2023 17:16:19 +0000
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Nov 2023 10:51:32 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-11-26

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4892711acee0915a8a4ae02e1af3dc70ce000024

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
