Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C4678180A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 09:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344214AbjHSHWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 03:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237395AbjHSHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 03:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E153C23
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 00:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 764C8611D4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5476C433C8;
        Sat, 19 Aug 2023 07:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692429695;
        bh=fO6Awv0XAKWVmavwgQYcmNUqSvzEtzxh1upBIq6bKj0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ceM4/cnYYzk1q/Eysp0fZMKrbgaKk43MnXbTktKwEDstbInqs9ggCDF5WrVUl0Vxw
         Z02fqPGz54CKKmEbOPX8RVU1QKlRidt9V+WKAiRULBbW7PnBSQsjuVsXG7Kf+lIpts
         epK8ZaWtgnKmwDZVqjs5UtGRrXVs/JnGyJCeHb4/Us9Dx930RlIOg1nUJ8C5PLz7ix
         6b8+ULjXICIjcCU/o37nKf6EWNidH8qt2m/XsMTqPeu0Mbx7WGBdqJztSzm0ipVG+K
         Nyu/5CjICiWSOXK2qiNrXqvDEoa1IWon6PGBnwk60Hl0eJI7Y1r4qCrWLUCbC1wMq7
         DEQEasjA9/JSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C08C9C395DC;
        Sat, 19 Aug 2023 07:21:35 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.5-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87350fwnlc.fsf@mail.lhotse>
References: <87350fwnlc.fsf@mail.lhotse>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87350fwnlc.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-6
X-PR-Tracked-Commit-Id: 4f3175979e62de3b929bfa54a0db4b87d36257a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e7ffde6984a7fa842489be7055570e5f5a4f0b5
Message-Id: <169242969577.22117.12041012940890249874.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Aug 2023 07:21:35 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        nathanl@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Aug 2023 16:30:39 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.5-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e7ffde6984a7fa842489be7055570e5f5a4f0b5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
