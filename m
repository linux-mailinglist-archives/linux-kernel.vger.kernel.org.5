Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F5754670
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 05:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGODIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 23:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjGODIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 23:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEE35BD;
        Fri, 14 Jul 2023 20:08:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B48C61DEF;
        Sat, 15 Jul 2023 03:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FC51C433C7;
        Sat, 15 Jul 2023 03:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689390497;
        bh=66oHfPnq8yInzPZAL0kUCTKqrxQ0Kuzph8s4Mcxulis=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JogOq51PhYUD867NQO7KArb86pEf9zn7lqDfMcJbT8eAemZiFEo8wnBVDKEC+c7YA
         fP2QUmcxkFMYvtivC7vtPLYhkCPaIgb2WjbBJ2k6dgY2sYDadD5svF+HtUbkEK2KuP
         HtqtBIfSMcP5FmtAL1SwYerzAhVmCrxsDwWYq3s1XdinisioXrpa5X6MfjlHM8Jy5j
         L4uqv2xbmIaJmCexMiwicLICE0kVC4T6Jhuo4mSVawe6xtyHoTAo2+Nw1JB2hw+A0c
         BHwdkpekJMyw0hZbWstp7NSibSncFGuq1pRNaYHczajWRfeweGf0osjf7QD2aCXt4d
         Fxpsu52QlExnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5C0D3E4508D;
        Sat, 15 Jul 2023 03:08:17 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <256ab3441824d3c22930c3341492119ccfc1b701.camel@HansenPartnership.com>
References: <256ab3441824d3c22930c3341492119ccfc1b701.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <256ab3441824d3c22930c3341492119ccfc1b701.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: f4d1a8e011909fee24643f84bd1196e1366c26f2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: be522ac7cdcc1b7dd19fa348205363041ab65a98
Message-Id: <168939049736.3346.1353349838971150134.pr-tracker-bot@kernel.org>
Date:   Sat, 15 Jul 2023 03:08:17 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Jul 2023 14:24:20 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/be522ac7cdcc1b7dd19fa348205363041ab65a98

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
