Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D347F7F90F0
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 03:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjKZC2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 21:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjKZC2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 21:28:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23270133
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 18:28:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0AE2C433C7;
        Sun, 26 Nov 2023 02:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700965705;
        bh=u61T+JQ8kZ7n3lD3cBPLroWyDJeD5T1giCodUv0LMRM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HiyYk3u6J5SinV5bz/CpdXNhuqdaWilzJjhzjf0eXF8WSC7ZPUtDmtwBgtf8RbvBZ
         ViIKuuooSwwtK1gKL1c20JXDp/XAVBlmOgh7MrIOH4vGYkoYGGzfWoSSHMy01yCYQG
         Mw81+lNIHQNX2LDgYVZEl/nGK3S8aquo+5E3OPjk3szJ67T0erIiVqALix/M59EXzw
         Zk5WEc03ENz5VWC2Zh5L99NV7b4u0Ffr2AsBSb0JVpSqXovHvlCIhv9QGAIUKcxnDR
         LIs6HphPl6yAw4j+UtIocg9YTCYL+J1sQK61NPugiombnMP68JlrWXggJ8LsJHfSF9
         SQbZ6U+GshMTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEC2CEAA958;
        Sun, 26 Nov 2023 02:28:25 +0000 (UTC)
Subject: Re: [GIT PULL] USB/PHY/Thunderbolt driver fixes for 6.7-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZWJQOw3VcmTOB62a@kroah.com>
References: <ZWJQOw3VcmTOB62a@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZWJQOw3VcmTOB62a@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc3
X-PR-Tracked-Commit-Id: cb9a830e871779b4f9b8d5f76a2abf24915cd007
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 090472ed9c922e699dc61dd601a9b376a64f4390
Message-Id: <170096570570.17835.11926136154771545086.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Nov 2023 02:28:25 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Nov 2023 19:51:23 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.7-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/090472ed9c922e699dc61dd601a9b376a64f4390

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
