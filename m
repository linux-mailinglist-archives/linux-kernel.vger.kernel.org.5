Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F32E80B895
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 04:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbjLJDjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 22:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLJDjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 22:39:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB88FE
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 19:39:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D852C433C8;
        Sun, 10 Dec 2023 03:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702179553;
        bh=wrRfiJWMsLbF8VsfJ8VHxgmbslN/LBSjb08315byVMw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W5M9+pslJeDXje9aa0egifk+eSuIurft14HF2S4jJwGEcH552uajiQf4lXT5DbbfR
         pUJD2oLEV2Fjpg2HEJUoiZ/JEpNzi1S1WEGsCVBFRXwWfEu+jc6nmJSANtr0ZyPQzA
         Mw2R1Sy6IllQLgqDK7LktKv/K0uEbOg/dr5wTZ34dRYnTtqq6J2G/+FHEgedUnpdJC
         5Gcwwx1fzFz/wmURGVefEP4sutTBd1OqinxOPMXN+hpX/GWLQa3wZy2Bo1FjM3cTEj
         LIayXXCjb7brgyHK4DY4EeCXHa/Z+iR1jAvdbDpzLkwRjy6teeJj0U14iFA0/vmbDT
         3hl3Dtial9Rng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46604C04DD9;
        Sun, 10 Dec 2023 03:39:13 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.7-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sf4aew7x.fsf@mail.lhotse>
References: <87sf4aew7x.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87sf4aew7x.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-4
X-PR-Tracked-Commit-Id: 4b3338aaa74d7d4ec5b6734dc298f0db94ec83d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c527f5606aa545233a4d2c6d5c636ed82b8633ef
Message-Id: <170217955328.29712.5294828346710720884.pr-tracker-bot@kernel.org>
Date:   Sun, 10 Dec 2023 03:39:13 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        naveen@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 10 Dec 2023 11:29:22 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.7-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c527f5606aa545233a4d2c6d5c636ed82b8633ef

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
