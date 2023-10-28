Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA05D7DA876
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 20:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjJ1SRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 14:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJ1SRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 14:17:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321F9CE
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 11:17:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACE19C433C9;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698517064;
        bh=BXe9SuGTYgkSA6II6l4GDrwHhtEzV60K44BSNlbwY7g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G5KwvwjCntMFBCpfyyUzyUjvX8oQ7SxxLxGe+sFKCzARDcM3uS7Bd2rR27qv8WwAr
         XAAxnMCF/Yv4lXMU39sK8HCQjtnx7f8DmDtDYqA4zWvS4vRo77I3Y1JqFSLeQCqAKS
         0CXbAzxJJe3Pk/fS0sBN9xcCiL+6A+KEudhPtqfWoYvbicA8I2VU4xGWuPOTwbhlsR
         4gw2ahtfh7Pvw3s/U2/5bEhmffIo12LEvZ2fvVss/p1QibEAVQpBh1wGQlHV/GDffd
         +44OKhpLuq3BNL9g5Lz5YmY6zHM46sKAREaZCHJ3DF081Gobix3GtgbclIM3+iIrzK
         iePux8NFeKl8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94A31C00446;
        Sat, 28 Oct 2023 18:17:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTznjz/o5IvAvPOY@gmail.com>
References: <ZTznjz/o5IvAvPOY@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTznjz/o5IvAvPOY@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-28
X-PR-Tracked-Commit-Id: bd94d86f490b70c58b3fc5739328a53ad4b18d86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2af9b20dbb39f6ebf9b9b6c090271594627d818e
Message-Id: <169851706460.30729.7520320690010756777.pr-tracker-bot@kernel.org>
Date:   Sat, 28 Oct 2023 18:17:44 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 12:50:55 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2af9b20dbb39f6ebf9b9b6c090271594627d818e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
