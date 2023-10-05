Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D627BA946
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232287AbjJESjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjJESjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:39:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27BE9F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 11:39:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79EB4C433C7;
        Thu,  5 Oct 2023 18:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696531179;
        bh=b2ke12TwCYvMIsr/GrzmzAs09uRDP9teKxUg5JNSjJs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ollIyy2lrHUfeXD783hruKU6CFTa61MqzwqaBbEwuInu/cA30QzJX3Pd3xw8YFr2f
         45nA1ZMxMxUpwh4buPTuhc5kZUNSd4fT21hObC1B8vt4dmoO12IQ6kWLWVzRL7pswv
         Td15O4KhVFxrhvWpt9OYSHKGBMq5+lUIlslFJoAuWirW+Tx8JCcXSsTQDleCeLXmTU
         h1RganmxcE78p/hXcm4c2Xj37XaLxbq8rQFwy9cFFAmTXQjT4xlsFTNxgxN2Ao7c7E
         IhA9MC1GItdtyeRI/1CT5pgyQZQOYlpnagJ451rbNfk2OXGe0e3yh6o3fiHkVgfAoK
         /W0D8+YoIj9gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67270E632D1;
        Thu,  5 Oct 2023 18:39:39 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231005153026.GB808963@google.com>
References: <20231005153026.GB808963@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231005153026.GB808963@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.6
X-PR-Tracked-Commit-Id: 9dc1664fab2246bc2c3e9bf2cf21518a857f9b5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e90822d7ce017ee11aedf424c8abf38b07c802f0
Message-Id: <169653117941.4044.4129757586860905363.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Oct 2023 18:39:39 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Oct 2023 16:30:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-fixes-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e90822d7ce017ee11aedf424c8abf38b07c802f0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
