Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F1177A0F6
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 18:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjHLQIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 12:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjHLQIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 12:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BD310EB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 09:08:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11B3161AF5
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 16:08:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74ED1C433CA;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691856500;
        bh=EPH8qP69/LMHmccxO9ZzxIcwUdXar3rL1IlhrSKS1w4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ex5jhE/Gl0PX3LtT1PuTBlMak9b/vCjSW6LLWADhUzfG/I7q0H3L/tK9Pd47NVyt7
         7UcUCCGCOBxTbVkvARvozBbGgvxLroKJv4Wns86FKPMrZls/b7qSkKshvVfPG3yA1w
         KPwuwmE7oaQOQ8eTFWiLIJbeKlZBQuhqvus9Jubl4chTvI/U1oXJJeMmVtEqL5mANW
         TvMpX9mXxS64Md4Kz7qxTT0uwyL0RF45CGR0jWHOjM3wHzFsIed7XUZp0Y6GNzo/8m
         EjEqOE8yacuYpCvTAM6rzxVwOWPDaAmD0RidTuevXKinifpKG76ThMsg1bup75Meiw
         EFCAuCjf3qZfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E4D9C3274B;
        Sat, 12 Aug 2023 16:08:20 +0000 (UTC)
Subject: Re: [GIT PULL] Char/Misc driver fixes for 6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZNdcNLteAsSSrH2u@kroah.com>
References: <ZNdcNLteAsSSrH2u@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZNdcNLteAsSSrH2u@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc6
X-PR-Tracked-Commit-Id: 51a26bb02ae58c7db6b4156d7e1e39cd79008757
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3feecb1b848359b152dd66b26c24c2454a64fc15
Message-Id: <169185650038.27778.7970062940094291481.pr-tracker-bot@kernel.org>
Date:   Sat, 12 Aug 2023 16:08:20 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 12 Aug 2023 12:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3feecb1b848359b152dd66b26c24c2454a64fc15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
