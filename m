Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F5D78BB5E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbjH1XK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234378AbjH1XKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA27B189
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:10:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A73E649F9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2179C433C9;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693264233;
        bh=vVfwSwiERLt9fXpcmpHcDazMq/1bOzn9cOOUUTZdx2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TxIc2sA7Lw8fex4oR6M42E64ISAnzOgrGJr+Q7GIXVvxwo9KbZ75DNZBr4DtCh+3s
         Q8jACTo/RQDTUKp8eTU8i2Bsoa4vCybLsYC4d5DFuS7sP/HCyO/WRU2qpNs/9Ij1m5
         mqjFrpGvgH1qT6BA+oUEfpDnhQj1urXJ1R0mIwk2kVLr+AdO58bhgEqlvgHWDD2C8L
         aUjYUvTSBpsmO8ghjennkQZoevwGUi69fOXOcBB73uizQtUWGsMQFTfYBblkIeQjkF
         QwvhSsddhjtfmKiKpP0TzL96dfdQSjgfQYmdi4ilMVVXbQNIp1yAFESp1Hxwdfioct
         C0qHimIkjr57Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF1A9C3274C;
        Mon, 28 Aug 2023 23:10:33 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
References: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.6_rc1
X-PR-Tracked-Commit-Id: 4d2b748305e96fb76202a0d1072a285b1500bff3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 42a7f6e3ffe06308c1ec43a7dac39a27de101574
Message-Id: <169326423377.4748.4854990872107063711.pr-tracker-bot@kernel.org>
Date:   Mon, 28 Aug 2023 23:10:33 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 14:25:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.6_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/42a7f6e3ffe06308c1ec43a7dac39a27de101574

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
