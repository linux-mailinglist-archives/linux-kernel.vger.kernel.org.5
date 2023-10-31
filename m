Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E26F7DC442
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjJaCMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234751AbjJaCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E09E6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71621C433CC;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=pAgFcTJCAwGa7v7Ox1TqLWj5CRXxSDoVROufSu1kUy4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NmqRfR2Fd8iC7Ni0RE6JNcIePFyNcaoZ7Hha4qRCplD7dRcKLV0YhW+eGSJ5T+uzT
         OtNDP7o3BNrkPF/mDwjeDQ6ALDotsUJcVTSW01kQKSHD68Q28TjCbidvL59sy6okHI
         W1C9SwFhFAF9b1Q8bkS1NVp7WWrmETnkw1Db1v66vKTPmshJ79B9NjECYCl8jTpgZD
         VpmYvvqlOacREf4yz5j7oipLo3kTKzp4J7eF7MK55sSh3b80IkwrwboVv0J0sUtQr2
         wvtUdMIGrSMteYO7y1DbQ2YyZd+dDlq9oq2mI2VS1DUYOmAAMQgVammeMf/GqM0M4f
         CfrepM3Kxd9LQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B417C595D7;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/boot changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0IY1INe8Jls7EC@gmail.com>
References: <ZT0IY1INe8Jls7EC@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0IY1INe8Jls7EC@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-10-28
X-PR-Tracked-Commit-Id: 50dcc2e0d62e3c4a54f39673c4dc3dcde7c74d52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2b95bb052656d46c2073b87f9487a53ef5e79732
Message-Id: <169871835136.5591.17011002504925959411.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:31 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 28 Oct 2023 15:10:59 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2b95bb052656d46c2073b87f9487a53ef5e79732

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
