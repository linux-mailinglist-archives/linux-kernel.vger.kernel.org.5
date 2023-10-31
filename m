Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8532F7DC509
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 04:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjJaDwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 23:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236367AbjJaDw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 23:52:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B2BDF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 20:52:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D6CC433CD;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698724344;
        bh=IsHx8ZwQnWUwc/DZSRmS7W5pU1Spe/f6FdjmqWW7A6w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fouqOWi4hGFKK01YXNSXnRn2ki4GY9uPie1rgny/dn6A8cd9gz0s/b3aa/KkPWNua
         XoZ6+X0iUlntIsty+XG46VCpaPWOo8rDhVtcvZ0u4XnFdvKzB8jvGkqFo1xPtKMwwE
         qv3e5CbZ5m3aSGNYrvgs4dOBowxdq+0WOFB+qzTCWe1HSfWYBYepxNATjSNg7TuMRY
         03gcFSWgNx3aesvKXjrfhk+M494/QOhlgFpSgIg9sSvh5bAqkr8HpPfnzknLkgZ9xh
         h/gf0zSvqk8nf1CatRcHC78wB47Z5L3FJoSIsscZQGkpxiE5BfmMfJxvHIFFsqfOro
         5xaGGdRHGJARw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D01D2C595D7;
        Tue, 31 Oct 2023 03:52:24 +0000 (UTC)
Subject: Re: [GIT pull] x86/apic for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <169861501334.181063.3078165562616801860.tglx@xen13>
References: <169861500709.181063.7816209662289132093.tglx@xen13> <169861501334.181063.3078165562616801860.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <169861501334.181063.3078165562616801860.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-10-29-v2
X-PR-Tracked-Commit-Id: b56ebe7c896dc78b5865ec2c4b1dae3c93537517
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 943af0e73a370b0c856340fd873c140e42822ec7
Message-Id: <169872434484.24385.8033993256233758828.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 03:52:24 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 29 Oct 2023 22:33:30 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-apic-2023-10-29-v2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/943af0e73a370b0c856340fd873c140e42822ec7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
