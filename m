Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B34D7550FC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 21:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGPTaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 15:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjGPTaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 15:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF4E4C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 12:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2F8960E26
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 506A0C433CB;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689535804;
        bh=HOmz9cn80Wyt/tC2Jy+EceltYti2DVn9qn5m4K0VDlo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QLdnVptvAu9B/KFVgApdLJyiKTcCB6xFAlx79lgRMikeq+QwNBDgDvymGr+c50873
         n22iiSd1IuQDYspfaz/1SIv0isheruSVbLKpLLY25X8n9thZi/6A5//wjczioyE3DB
         iTRhuJpaa7REheE3Pfukfa6rK26bZ7A39ElfNkMgsGt0rAgvh5/OVz7s6IOVyNJbyb
         +i/UiMm0SZrhkVsxDKvG3RxekXswTxE2R1XaAW+FjhAIbYYwT6I1rVWidonu3fIJ8b
         RyJjmkWH2F60mPhjodyWhuJJxtVczCXtCzC36e/CuuYI/PlHHb+SMfwh7d4ifQIa2K
         HnmwkXKCpZVmg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 38DB0C561EE;
        Sun, 16 Jul 2023 19:30:04 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87cz0sjwai.fsf@mail.lhotse>
References: <87cz0sjwai.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cz0sjwai.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-3
X-PR-Tracked-Commit-Id: cf53564b11cef5cdfafc548b172345c9aa753f89
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 20edcec23f92db47ca1ab33b4c6025bb8b3db7d7
Message-Id: <168953580422.22660.214369271793832266.pr-tracker-bot@kernel.org>
Date:   Sun, 16 Jul 2023 19:30:04 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        aneesh.kumar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 16 Jul 2023 14:49:09 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/20edcec23f92db47ca1ab33b4c6025bb8b3db7d7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
