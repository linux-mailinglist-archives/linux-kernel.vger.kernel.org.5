Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D97DC444
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbjJaCMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjJaCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302EDED
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B86D1C433AB;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718351;
        bh=wlXqH4dZgDJ5ZHovbxK2jYHxm4BmotChY0R5OO6ZmVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GqjAgJpfw05WWUzUNH9kx2BA35KSnv7eNI32FoIP5n8MgnzRzQBi87nT9szLciDT8
         HTRmt5STaYjF9J9J7AY8pDU+eZzKUgyuetF1MOBI3u1cRB2nxR6teNevvYRVjDgLOQ
         4iIe6J2nMZtEjZMddtOeQuES1KUPqKlI4hfaK9ACK+8e9qhIfIqM1jii0qbMM+LnAQ
         YL/6aU2sk5wCCwsI0SblB0z7WnbHq98169xEgJFg9puXyF8gXnb5H2TLUgGX6Ugatt
         x4YG2wJ42emU8bxVopnTj7JKkFVdYythJaE6E4HjDXpi8iXZiLlUnHGSfDttM/GA5h
         2N74u8AnmDRwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A2E7BEAB08B;
        Tue, 31 Oct 2023 02:12:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/headers changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0Pi/4pMwg9zm8u@gmail.com>
References: <ZT0Pi/4pMwg9zm8u@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0Pi/4pMwg9zm8u@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-headers-2023-10-28
X-PR-Tracked-Commit-Id: 8b01de80306cbd914be9c45bce30206a49699141
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b8b4b4fc4135160f295cf308dfe43c721990356
Message-Id: <169871835166.5591.6511395051882983486.pr-tracker-bot@kernel.org>
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

The pull request you sent on Sat, 28 Oct 2023 15:41:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-headers-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b8b4b4fc4135160f295cf308dfe43c721990356

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
