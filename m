Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32987B4272
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbjI3RCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjI3RCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:02:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F4DA
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 10:02:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46E6BC433C8;
        Sat, 30 Sep 2023 17:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696093335;
        bh=l/tCLMVlH30Lm5boXOejSIT9/JnuhhtbswpZnPrRvjc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UDI/8Qli5NFcx8NqvuVVPWSLY+K1qQSD3gFJwybRdZbK5fcaH5jwpc5WPOCdvYuA/
         t6mMqFdR4dVrQHHhp2OFLVGFUAUImt//sf9UWYQYTCr+w7zaGW5sWCOn1+QJ1bg/SA
         NnRQEulZxAPz8n2HP8fqE8SI8GxhTYJHo2/NTjXzK5wAnRVqHoaYr2MHA4rcj/w7Wb
         EuOMz0weMFNtmJviKJ/PCwSSSxHwJTQMhOCTKmsl5o0Oa0oSF7c/M9UH262yXiNR7B
         JbQt33WwOo47kb38ojImW07LFy0S50B861SNbnH+F1InVauP76lt9hs05RroKcIjoS
         sdHMlukfwVI+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 32604C395C5;
        Sat, 30 Sep 2023 17:02:15 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.6-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkdjolf1.fsf@mail.lhotse>
References: <87bkdjolf1.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87bkdjolf1.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-3
X-PR-Tracked-Commit-Id: 58b33e78a31782ffe25d404d5eba9a45fe636e27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1c9d83122196ac649dee1da5f48f16462ba5385f
Message-Id: <169609333519.18163.2546822879786600818.pr-tracker-bot@kernel.org>
Date:   Sat, 30 Sep 2023 17:02:15 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 30 Sep 2023 23:11:46 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.6-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1c9d83122196ac649dee1da5f48f16462ba5385f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
