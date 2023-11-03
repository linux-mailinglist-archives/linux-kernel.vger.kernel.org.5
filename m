Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8A17E09AE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 20:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234674AbjKCTxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 15:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377905AbjKCTx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 15:53:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF9AD61
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 12:53:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6CC49C433A9;
        Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699041207;
        bh=U/+YbMSrqIujDkETKUb8cqcPFTIt6s+O2VDhOHf4BMQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LHc6k+08hf/2jTzNT7NdPDaqi4bkP3/BpeQsMUkcWtBqHB1w/hUXwXH3Y76IeF5cD
         EirbPRqFDwE5HRssPugqBxq8VyobwVE6iXingZ77GQjRaCBJYSua5O5BxVKUqIsCah
         z98d4EwjYaIqztXgcbJXOuhHjM28k4wDo8bNhdZl9RBQJxo9/7vrD4r43MGgl/9bFU
         7mERYgnGaF5Dbf/hyIDntTPOerIn1MAgchRgQ/tdH3HG9Q1o7vWY7IPTlfFy/FesVt
         Y8nZILxzQPWdMiHXZtFlrQQFiqNbecQmpOz2UCNr1XEODXz+Su37CAOhmn/Bfc/DQ7
         FnGsGSfPDN4pg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5ACF7EAB08A;
        Fri,  3 Nov 2023 19:53:27 +0000 (UTC)
Subject: Re: [GIT PULL] printk for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUPM1ZD6Q3mNOPaS@alley>
References: <ZUPM1ZD6Q3mNOPaS@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUPM1ZD6Q3mNOPaS@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.7
X-PR-Tracked-Commit-Id: 2966bd3698451a2172a57e7e97eebb4adbfc48a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a80532c0745e140852e6b579bbe8371332bb45d
Message-Id: <169904120736.17286.17323528303325021869.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 19:53:27 +0000
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
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Nov 2023 17:22:45 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a80532c0745e140852e6b579bbe8371332bb45d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
