Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B529E7DC445
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbjJaCMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234752AbjJaCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5835B3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 491EAC433C9;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=MEMqsxD/4tixMBnFHBMnii6Y9dYTito/heVRrxZkFSI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YxwxrmDMGKLWFHv+KmYkrmMvvLfUrMeWXtd8REWjILQnLnZRNtvH6QJ26f3omkOm0
         8gi3HeRpmHqnL1d8XmAeE+f5l1iEujUKGv1bdaLZrblO+EqMFIH8EbCrwv4AgVnKOm
         NBOCkN82/9Nm20etGXX08kK5UHSphl22DjMJlaMD3jeak0zsEeGphozmzhKj2nyM2i
         qizk8KJQAQ8JrWNPLNLLurUpp6AKtriV3ATDCdOffnAcAV3S3qm1EkZpjVdhDB1m7n
         EBmd/6X7thXMFTKYWiGruS7SIgwUSw1b+6BXYuHxvQaLjpcAv2l9i4VMwz0VNoHRT4
         Zg36Z2/FQ5nMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35BC5EAB08B;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0FwZYk4Dm/Lqix@gmail.com>
References: <ZT0FwZYk4Dm/Lqix@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0FwZYk4Dm/Lqix@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-10-28
X-PR-Tracked-Commit-Id: 8ae292c66dcb160b3e1e16b66c3076d5a2c63873
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5780e39edbb49bb441f1c8eb9e6cb8be92dee31d
Message-Id: <169871835121.5591.15249852785802888414.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sat, 28 Oct 2023 14:59:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5780e39edbb49bb441f1c8eb9e6cb8be92dee31d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
