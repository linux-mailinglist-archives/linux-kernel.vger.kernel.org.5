Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEEC7A3720
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239073AbjIQSY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbjIQSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0BA129
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:24:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ECE5C433C9;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694975068;
        bh=R3X0lvoD2c+IbS3uH4Abrdd+A7imlos6QY2eUrLGd0M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GE9lYFQnhVxqZaeN6hOCSa9MIEH1ecD0dRwjPdd0pCU76HnIu7kuzeItCxWtZSD7I
         1O5gL2q37KGOYR4HTj7Zmqr2F0BHrTdSDKTotf3Y90aDWV0kZlw25UNn1Ah8tL3Byt
         iQRBn9cfmpXjCPnktHpDiJ8soPPT5+HYsZ4x5OIfBV0mNM8W6ESldSyJONndkX2R7g
         kkyQozsPApeyvNfKIkDHqpTm0WdFAxgRK2ld1V9bksmEWkh2WPxIGY3jxzlDjbOlLP
         +W/4z7WPe42HxAWE/v5/1a7mxHRxSlijBwhA8vZ/LT2roq/a8yPqGMPJp98vs+hP/9
         0JsOR8AzTl0MQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C9C1E26888;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
Subject: Re: [GIT PULL] WARN() fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQc4EdCAFDOHpVM+@gmail.com>
References: <ZQc4EdCAFDOHpVM+@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQc4EdCAFDOHpVM+@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-09-17
X-PR-Tracked-Commit-Id: cccd32816506cbac3a4c65d9dff51b3125ef1a03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 99a73f9e8d65600fda224647c8520e184db8506c
Message-Id: <169497506830.30007.6115570492129144762.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Sep 2023 18:24:28 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Sep 2023 19:32:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2023-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/99a73f9e8d65600fda224647c8520e184db8506c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
