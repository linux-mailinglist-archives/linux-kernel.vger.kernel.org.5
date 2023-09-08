Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138BB7990AF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 22:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344433AbjIHUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344302AbjIHUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 16:00:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E4A3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 13:00:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE874C433C7;
        Fri,  8 Sep 2023 20:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694203251;
        bh=1XONItBZwUuD0zGrRicwlcqOUEReNXIA3rWoGlOdq8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ilZsbqtskhhw6ssbyRm0pqHmnm/H0qlws7oSawWNeuxL4n/Sl8qTPLPOeITFmNUhu
         MB5RKG3djINq12CyOTaWNXvvtT0N59oWmqZ6CrJfKIFEFya1wIyOhsRgnjJI1jvrw6
         JEKturbCQvd6rr/dinzpq69ofmECkW3nGlSYdZahAuVuVhWzVPRbYyVRCRfLKJ+EmS
         asFXCJo8rvJp3q9dgkhpl3fwNPnUIz1NJ0H1SUdwYiMNqMKvBUPuCJ3IX3pbMk6Owb
         AS7B/vYAHT3w6+Vw65KkKeKr6brZ4jXY8c0Le+qdJfENpKY6KQLcpBUkOY7Xl5//Bq
         RhbKjDTcUJbUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98324E29F36;
        Fri,  8 Sep 2023 20:00:51 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixup for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPrJrWsAE-u8Lefq@alley>
References: <ZPrJrWsAE-u8Lefq@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPrJrWsAE-u8Lefq@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-fixup
X-PR-Tracked-Commit-Id: 4952801fc6adb5b50b8ec2bcc5aeef92fcce8730
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01a46efcd8f4af44691d7273edf0c5c07dc9b619
Message-Id: <169420325161.9132.6893920469750609035.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Sep 2023 20:00:51 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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

The pull request you sent on Fri, 8 Sep 2023 09:13:49 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.6-fixup

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01a46efcd8f4af44691d7273edf0c5c07dc9b619

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
