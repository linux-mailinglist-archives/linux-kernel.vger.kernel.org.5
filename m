Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20D790138
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350560AbjIARKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350520AbjIARK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1710F2
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D842623C1
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ED31C433CA;
        Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693588220;
        bh=NM88ayIxXOtwjmEUTuTXU612gf6LqTOyZSNR0xeGJBw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FzUpnEnYauW/GqukBlflLS/PCqx2c8gxWovdHJP+UUGpaJAkpE0Rb6ruA4iFil1AR
         lfjUN1DlnmH0ojKnr3ZfA9gr92g4j8R7BgODnOfcJx78Mz7J8HB8oER/jibEuwyTyp
         KdzT7FGPV5coJeddnL8tV+AthcxxuUBWZPzQtj//fuuekpMlp9rTzfW/bD7gqInHUe
         u1GqW/c2ei+2BZYsanfqjXXKF/y+QsI00WeGnpH9e2fwYzy2V5XV8930+pB52R+wjK
         56gK+Ufeyu1PD8dN2fsdZvJkob/xEz4+8QE2cfeGInDZ05bdnc+Sp2Gj2i2Km3mTVh
         D9BRz/WiuDTCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B9B1C64457;
        Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core update for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPIBTz-bppDBfgDi@kroah.com>
References: <ZPIBTz-bppDBfgDi@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPIBTz-bppDBfgDi@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1
X-PR-Tracked-Commit-Id: 29c8ab79e91d35b93cfab87bf67a11516f7b2051
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 28a4f91f5f251689c69155bc6a0b1afc9916c874
Message-Id: <169358822030.1073.4607966834060622587.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 17:10:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 17:20:47 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/28a4f91f5f251689c69155bc6a0b1afc9916c874

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
