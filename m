Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473217F039E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 00:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjKRXfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 18:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjKRXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 18:35:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A5E196;
        Sat, 18 Nov 2023 15:35:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B76FC433C7;
        Sat, 18 Nov 2023 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700350506;
        bh=AZfCRCaow+SPQn7Dtt/WeEK+Grrpc7zf6AfQwaZBp2U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OVako+JnvVRXIaTaUvQrFt1ELQYV8xx1Muf571+lD3+xcBfMCJadUwrRQWP5EHZ3k
         TO54pbAvu3KIfx974iIvnhVzU6TYX7GSGX5t60syqJXAIeUQtkGIMDpbht2/23i0oZ
         pMBN1esELoMg1LZT7dtJMAnncMV3PSlxDvCEvVhi5l2gHu/pI+4AVLSkAzSaKbEVlS
         w2QPVYwx9faQsnYtJIDm2HeviV4nTCx2T/fqubb1yOx52lR85/5JDAkBtWlLHy0ekc
         sg1ZfM/ltc5XKxlmdR5N5KW1DOJX+r2zqjvpu1kjOtycPUuKekDkiGtWvsv81xdRAJ
         AgH0uCL5BJnOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06A1BEA6300;
        Sat, 18 Nov 2023 23:35:06 +0000 (UTC)
Subject: Re: [GIT PULL v2] parisc architecture fixes for v6.7-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZVkJHUynkuBxVb7S@p100>
References: <ZVkJHUynkuBxVb7S@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZVkJHUynkuBxVb7S@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc2
X-PR-Tracked-Commit-Id: 793838138c157d4c49f4fb744b170747e3dabf58
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2254005ef1474d59b706f2ea574d8552071631b1
Message-Id: <170035050601.24051.3686800477638425309.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Nov 2023 23:35:06 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>,
        Kees Cook <keescook@chromium.org>, Sam James <sam@gentoo.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Nov 2023 19:57:33 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2254005ef1474d59b706f2ea574d8552071631b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
