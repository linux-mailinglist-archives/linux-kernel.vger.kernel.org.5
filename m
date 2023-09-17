Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2F47A3724
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239343AbjIQSZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjIQSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE558130
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FDA9C433C7;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694975068;
        bh=hwk97I/sxuEkXUsUAoTXxLxT1T9Oa7U79IDvkw8o31k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ddYPIILMSiY4Bl/UNPJzOTDcb8BspRBv2MOEEdCMy4FTNBRWvUiD3iNWGbIhfZmEI
         9bAm3e5k09M7MltNhUR/ss/NiuF4sH/sbGkwDXPvZI4sSTM0wZr63I/VQIgtCu3I2g
         WnSkQgZURK26KwdSzBq5PtluUcEDNR5gXv9g3KcCSRKKWiSf3xUcfBWXMIkFRCaDxw
         jdbEBuxXEO7NCDswm1hKiyBDL+vgigeQLLsinth0znKZpTmjV6Wq1ZCB8rYtzouhvu
         ye8Waoz3RN9nsON4RMAl5g28RLpiXLow8I94u1TIlug6HDYU7HHTCAVNRXpJHW1A4n
         TwHPSG6LvIupA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5BBCAE26880;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
Subject: Re: [GIT PULL] objtool fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQc4lawqy8NnDzys@gmail.com>
References: <ZQc4lawqy8NnDzys@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQc4lawqy8NnDzys@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2023-09-17
X-PR-Tracked-Commit-Id: 72178d5d1a38dd185d1db15f177f2d122ef10d9b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e54ca3c81f2d81e4de3339873256e568f60ce076
Message-Id: <169497506837.30007.14881152205324733878.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Sep 2023 18:24:28 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

The pull request you sent on Sun, 17 Sep 2023 19:34:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-urgent-2023-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e54ca3c81f2d81e4de3339873256e568f60ce076

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
