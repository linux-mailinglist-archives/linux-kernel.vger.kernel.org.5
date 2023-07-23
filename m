Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D475DFD0
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 06:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjGWEAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 00:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGWEAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 00:00:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0D171A
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 21:00:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 008B160C2D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 04:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56E72C433C7;
        Sun, 23 Jul 2023 04:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690084835;
        bh=aOAhlx9e9NI1x1a3K57OexMdndgB8jGcH2RhMZmcONE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KVslx0STV7bc9HQt5vqJowF7FZdZo69To2IcolmYMKiA1UPlnCLv08IfoL7ZNkmot
         3vb9ADvEVQ9OHkbFdBzHVCfxpZFY1Xuqs7QTuSPALONGHR7/AE+1D5e4jc1/oVKSUV
         nAW//GlbADTYvtJP8Sp7E3fJxdkyMFo9YPLpBShlYwelxBtT1l7bU6KJXSB5etE6xV
         5xX3pq6L0zsOiHAfS3zlKG0d0japqvoiyhHcTx62sDTgWiH+8KaQ87Q6a6fbMZG8W9
         tJfl65O0BFD1wqXxuVmyTupGMuQZ6/PhXBCkLqYiaHT64dXT/xU1gl4JqtIHIxFXKY
         tlXdFeVqyJoFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3F73DC595C2;
        Sun, 23 Jul 2023 04:00:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sf9fpg07.fsf@mail.lhotse>
References: <87sf9fpg07.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sf9fpg07.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-4
X-PR-Tracked-Commit-Id: 106ea7ffd56b0f9454cd4f625474967f12ac4dbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c2782531397f5cb19ca3f8f9c17727f1cdf5bee8
Message-Id: <169008483525.25429.3303454837491361344.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Jul 2023 04:00:35 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ajd@linux.ibm.com,
        bgray@linux.ibm.com, christophe.leroy@csgroup.eu,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, naveen@kernel.org,
        ruscur@russell.cc, u.kleine-koenig@pengutronix.de
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Jul 2023 11:34:48 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c2782531397f5cb19ca3f8f9c17727f1cdf5bee8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
