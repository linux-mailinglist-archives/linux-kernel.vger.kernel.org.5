Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9817781CF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbjHJTuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjHJTuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:50:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AFA2720
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E026460DD7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C7C4C433C8;
        Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691697004;
        bh=m7wsLm6cINbgrJRhcEN1/O+nRC9DUA51asBVUkiq1fY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=IGIRD5mfRrCh2yyyo8qdvkfyF6BBlRCV9c/BpJejsoETuWhr8nZYJwgDKw1sgtrd5
         Ef3w12TxpNpXlyMzT4p802yQy2HAna+ze5YKL0ocIU8U0ooCQAQVwNieO3J4i8SeVk
         yCu1zNZB10Yb11L7UdhIf1op8sSb2HtBivLR/tLc68pR69lgfYS6YKdSjLJXNw+i5y
         fbcOrWZlIegsBrP4G/kjjDriZXEy+w+wpdBXeLN3C7m23lZFnHe1gkTEIJNObYHGfK
         /qSehQYBDe9UkZqB0vBE6UFGw0ZiZ8A85QWA+667GCPcDvlONHHqwUslkytsNwxA2h
         R+m1SA9sETHDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35888C39562;
        Thu, 10 Aug 2023 19:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.5-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230810185922.92197-1-kuba@kernel.org>
References: <20230810185922.92197-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230810185922.92197-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc6
X-PR-Tracked-Commit-Id: 5e3d20617b055e725e785e0058426368269949f3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 25aa0bebba72b318e71fe205bfd1236550cc9534
Message-Id: <169169700420.10464.407068100361851410.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Aug 2023 19:50:04 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Aug 2023 11:59:22 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.5-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/25aa0bebba72b318e71fe205bfd1236550cc9534

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
