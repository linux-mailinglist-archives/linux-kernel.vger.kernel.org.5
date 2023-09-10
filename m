Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C500799F49
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 20:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbjIJSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbjIJSIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 14:08:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC8918B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 11:08:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAF7CC433C7;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694369326;
        bh=8ud1rp9TKbIkC1AadcgaCgvBVPkeoIM2VsVKbsiWUzk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=n+hB5+8mdLe1rkMgc4IYl/hybGzpm/pXR6pV5BwHfN0/f4x5rrLl2JXgvuiPkIkfo
         AqItfBtWDNO80cWLMxO/8RJj6bIMLxLb9fN4GSIOLSQyLxLqyr7IJwNayziYIJH67X
         6qh3tD8iOVHuWfaAne948tP0kxoc188K1m+t7KPTzkUxrqJ3IrYyv/uNyVmMAz4byt
         6m5bucbl83uUiMkF34qTuXYUHl58iVocCKPNr4EV/bIs03E3rFvH4i3wKqH6W6tq+x
         Sr81wI+4s4ZQxfcsQwU9vsO5t+tsePaPlFdPvN8VGtjZgqY/+VwdxeaPMLq2j+FCnO
         drFKgkAMD9ilw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 93041E505B7;
        Sun, 10 Sep 2023 18:08:46 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZP3uNpupKtWeBh/d@gmail.com>
References: <ZPMNXtbIPMdjdn3o@gmail.com> <ZP3uNpupKtWeBh/d@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZP3uNpupKtWeBh/d@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-10
X-PR-Tracked-Commit-Id: 3d7d72a34e05b23e21bafc8bfb861e73c86b31f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e56b2b6057996c5f48da518c79d6590f8bfaabf3
Message-Id: <169436932659.25650.13293008475194554169.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Sep 2023 18:08:46 +0000
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Sep 2023 18:26:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e56b2b6057996c5f48da518c79d6590f8bfaabf3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
