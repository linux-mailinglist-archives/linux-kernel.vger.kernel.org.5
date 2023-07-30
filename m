Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EA676878D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjG3TnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjG3TnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB8C11B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 12:43:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9976B60CFB
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 19:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0ECE2C433C8;
        Sun, 30 Jul 2023 19:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690746202;
        bh=TILF9ej47mqRp4rGw2g6VV1kTHmlhHa+sMf2UgGEFOk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pw8OrE4ycgE4srerTVJF4Fgps2pBO7pQ4OOEsdyjU91p7+tWpUZwXyM57gHvadtXd
         wAhBEtzTq7uXfiYZJ96jD1zH6z3g2x8+vP8Gc8PTqy+SfOq3Y/ah3StX43v6K59GBr
         sg9HysSjkgye9QSrdxOsooKXxf4r+ot9122J5TiH8AhrxbGkhbMHDq4a5Q+R7LvMoR
         ep2U7QUf7h2Dr63XVCYz2LZppVJ+iqzInBQ9LLP3hINk4vVDM3v54o9k79Vg8xf/B7
         KhtmGcnwwBRqhwcliRHwBb6oDQkdrUKtfaIxLyVZ4qAnJuQkZy/4VIYiQgZ6MMUspU
         jFZNobkI5A0aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0D05C43169;
        Sun, 30 Jul 2023 19:43:21 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver fixes for 6.5-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZMZEZev25nzJoNaM@kroah.com>
References: <ZMZEZev25nzJoNaM@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZMZEZev25nzJoNaM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.5-rc4
X-PR-Tracked-Commit-Id: 5f1c7031e044cb2fba82836d55cc235e2ad619dc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3d6b77a8d4b4603c243ab2ee0f04f74f122d576a
Message-Id: <169074620197.25913.5628028497946296547.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Jul 2023 19:43:21 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Jul 2023 13:07:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.5-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3d6b77a8d4b4603c243ab2ee0f04f74f122d576a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
