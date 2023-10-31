Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB01E7DC441
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 03:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbjJaCMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 22:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234774AbjJaCMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 22:12:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8982F3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 19:12:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A467C433CB;
        Tue, 31 Oct 2023 02:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698718352;
        bh=84gtmTpwXtmDmgtsL//fMKnAE3qdxVk60jVh7oulkJ8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HcCqitvtP9BcFFNbG34fShGMzsMIIytpI6jK4+Xupa8SbRXV9OIdeK36NgUAgUcvB
         TLAx3s76b/HVl1ccONnDVcRG+lQgaTPDuJKxoky/Y2TnYAqlTMIOwk8PXLC1pM09AO
         KlclqVLiLjsuzSq1xc5LtdLplqQXseIxiByWdtU9Gnq3M/XWWqvUHPXcLzPTqyvFh+
         mtWWTsDe9F7tuwC5EsSFUCRCE+nCac/TJd2T5wpEYjncid9Whpud6aLxZAVi5NMwyj
         T/QSfh+VdESkjHlEOyQJn0v0WlBQgoKkWMTEhhtOTuoqeKaDQg8V1VswL3hhFUb9Y8
         fbRUceUJHxLIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08BF6EAB08C;
        Tue, 31 Oct 2023 02:12:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZT0SuFRzTlb0Q769@gmail.com>
References: <ZT0SuFRzTlb0Q769@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZT0SuFRzTlb0Q769@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-10-28
X-PR-Tracked-Commit-Id: a1e2b8b36820d8c91275f207e77e91645b7c6836
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f0d25b5d0f8ef0ad35f1beff17da5843279d47a1
Message-Id: <169871835203.5591.7394985469788287236.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 02:12:32 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
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

The pull request you sent on Sat, 28 Oct 2023 15:55:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mm-2023-10-28

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f0d25b5d0f8ef0ad35f1beff17da5843279d47a1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
