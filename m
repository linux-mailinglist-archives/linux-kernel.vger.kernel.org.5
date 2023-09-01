Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0179013A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350553AbjIARKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350330AbjIARKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED43A10FC
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12C58630A0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 17:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9457C433C9;
        Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693588220;
        bh=rT06WtK624W50TTByTPx56Hs2iQICdrNCbQuSnzdC7s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lfAkhDscwPK1j9nu/xNz8PGZc49k91hhnhkWPCb2S8qroMWhD8h4KGqzzZx8jsVr5
         uL+4oyD7CWUnvlDy2OHbMNHi3ljmBmHc4rTyFg7MZX1JreQtECUR4R/UbKctv8cYw2
         T2YDP6iz7s72M5g4pR4HskDmvAIagezT3MEWbCiag2F/29IgZaltvERtcqPaWCnkPY
         gAW8DZmVZarmDRHKS+YikUTZJpRy7K7SwFD0lwKF1uLW45RVvrODTFludQLc4AHEN3
         LTF50T3DyWHuvxHLwYgF9RoPbCmMjR5gSXoG5oWKW9+AmYZ4PrnpFWyly+3FI87mK1
         npdyl3aj28zEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46E4E29F32;
        Fri,  1 Sep 2023 17:10:20 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver changes for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPIBYsxu-MeeQCiK@kroah.com>
References: <ZPIBYsxu-MeeQCiK@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPIBYsxu-MeeQCiK@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc1
X-PR-Tracked-Commit-Id: 704e2c6107f1a5353a1038bac137dda0df2a6dd0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c9f8dff62d85ce00b0e99f774a84bd783af7cac
Message-Id: <169358822079.1073.17924378665622139652.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Sep 2023 17:10:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Sep 2023 17:21:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c9f8dff62d85ce00b0e99f774a84bd783af7cac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
