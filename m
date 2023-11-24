Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109DE7F6A48
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 02:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjKXBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 20:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjKXBvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 20:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DE910C7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 17:51:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 298E6C433C8;
        Fri, 24 Nov 2023 01:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700790687;
        bh=K6h6ouVtV5KQ6YOqOJAwHDKNY/zjfcuApMQ6ZJd3oy0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DaILWAiVQRRxe6Yh0EvdEJFKTJcZFsDIKJfgU81tvY7mtkfPoSkJI0UA/RW+d46QH
         dj4onx6Z5m1Lay6laAaxs/ydQaE6zpCVX51+vcMKpv2zjmw/BebJLbuTMZF8rJ4895
         /YDU+PHhw8c7S4hGXegBl3f+u65IBT8kvpBVWS+3Tikiu/uLXA6iU3diIS9tfUNvXn
         IcnVLEuk8bld9OGb0ko/GX6feCuiUl80GurSYGAy8b7kDzKHkwx1QuivXjSe6AETUh
         CzEmySAxQfNNe8BXfQ89BnCH4wW1rAtnTcDNxNj54YB7WhFz7mqNiTTnwQIGZYMxaY
         FKo7bbV54oj4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C82EAA95A;
        Fri, 24 Nov 2023 01:51:27 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2311231302250.29220@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2311231302250.29220@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2311231302250.29220@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023112301
X-PR-Tracked-Commit-Id: 9ffccb691adb854e7b7f3ee57fbbda12ff70533f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f342790ad3c2456e15351829ad5d8919cccc03f
Message-Id: <170079068706.3340.12379597028426578869.pr-tracker-bot@kernel.org>
Date:   Fri, 24 Nov 2023 01:51:27 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Nov 2023 20:22:39 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023112301

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f342790ad3c2456e15351829ad5d8919cccc03f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
