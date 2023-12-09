Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA60480B647
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 21:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjLIUeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 15:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjLIUeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 15:34:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654C41A1
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 12:34:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10729C433C8;
        Sat,  9 Dec 2023 20:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702154057;
        bh=gj+XRQZlWwRMenN/19kHl2d4Cx1/cCtddG04ZZs/PZc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kresJePbKD+hIS4yNn9CY4f1y4rCvuvQQlq9zDsXXmadEzH5RneVeNU2iQ41KJ/1u
         CwsYKRfnFazeho6K2Yqin/6kHNwTQI29MLiRrUOnBVrmcCKQ/G8twRsimUORa1jjpK
         uX69adoYnzV5NPxLz7BT+ROP3gSJGWipKEV/EOz4LeTxxD3KlNTYuMyOVpMIEDvAmk
         fldtS38Ds3sub+XlmygqlVZOdp7mq/3Ofv+mDgu833JXuQH65FwRKxPluMOH98jSVJ
         0YBSmAWp7aibgFw2PzWA/d+m7kZk1XjLlj3obq7T5uPCrgC+u4iU6bIoP7ts3oNV9/
         rKNug9ovp16Sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F332DC04DD9;
        Sat,  9 Dec 2023 20:34:16 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXQrKJy+ZW0nF2FF@alpha.franken.de>
References: <ZXQrKJy+ZW0nF2FF@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-mips.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXQrKJy+ZW0nF2FF@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.7_1
X-PR-Tracked-Commit-Id: a58a173444a68412bb08849bd81c679395f20ca0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b8503b215789628d3625ef6aa252f323e32be929
Message-Id: <170215405699.1707.7256622590015108777.pr-tracker-bot@kernel.org>
Date:   Sat, 09 Dec 2023 20:34:16 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 9 Dec 2023 09:54:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.7_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b8503b215789628d3625ef6aa252f323e32be929

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
