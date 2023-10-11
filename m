Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531BA7C5ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 22:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbjJKU6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 16:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbjJKU6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 16:58:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4255EB6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 13:58:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE187C433C9;
        Wed, 11 Oct 2023 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697057924;
        bh=H4yUqBy97o8qewFD+SoQiGV8n7a4xlyL44Gyvh2sLJE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=j4DVDAWT6++c0HzZoGLeJ2VlTz3KvC3kiuJRxH1efjnQdXKlU3y/UR5sMvgflPiXl
         Lw1eqqTxB2cgZreBYVHB6vXWoWDS47jQ3B4THiRj8DCG1pWDXbU8HN7x11cy2R0VI1
         yQiFs2L1wnl1O12yCmK0KmiyI/BW1pVPbMRE5KeMjOv+qLC5uY6wGoDVQf9SUqhsiV
         0Ob6r1hRYu3BATKcxPLVb74Y0lNdIQi/DVFKBVh+g3luEapf2/PCym7THwMtpQAY9j
         DBlDdwi2F3nGuvYMQfePVlmBYLlC+e7aZ9u0ofpjaCJBpDePzIAFuqWu0Tl7q6489q
         onbuxxy3wDqWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C76E4C595C5;
        Wed, 11 Oct 2023 20:58:44 +0000 (UTC)
Subject: Re: [GIT PULL] printk regression fix for 6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSaPGo13Fz9TLUc6@alley>
References: <ZSaPGo13Fz9TLUc6@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSaPGo13Fz9TLUc6@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-rc6
X-PR-Tracked-Commit-Id: 9277abd2c17272ed8fc1b842d9efa45797435b77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4524565e3a3821a40eea029d05846f7de6588857
Message-Id: <169705792480.2785.3561657914203671048.pr-tracker-bot@kernel.org>
Date:   Wed, 11 Oct 2023 20:58:44 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Todd Brandt <todd.e.brandt@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Oct 2023 14:03:38 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4524565e3a3821a40eea029d05846f7de6588857

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
