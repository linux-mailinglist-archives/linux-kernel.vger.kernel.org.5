Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC775D0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjGUR3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGUR3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:29:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E5BE47
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 10:28:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F189761D6A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 17:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 65A04C433C8;
        Fri, 21 Jul 2023 17:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689960537;
        bh=Hsgy7BdFZt6WHyWV3QeNYyI2OFt5hdDGqulMn9nY1Kg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mySnFCMod8s+RxOeI01JiSQ3FjstASb+XiuNOCAC/TK0HNZjytMXemk2LDTw618Xw
         uzdLtHahIAxYGLPkTktOPhhiYFYiNiL29EYoKhMRzSK4z4DhI6V2WWarWyeCKi1YpN
         sdGSkJ8eiVdtxuTkviTCHpd9hGQAnul6AyVjuuJCzMSZj0aCXJYpSxkVASH7MBGzVk
         FBXFQTl4kyoL1d7ra+GEH4AFgnZzZXa3qXDiXH2V9JflGKNcGuvE/2pvFIBHYTjfNX
         ocicmeobBmTHYlvHo7Vza7hKi60im2LIpto0U/Z9sb/t+vcGRix17JnVAW4tx3rotM
         HLD+JoIXt0bMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5300AC595C0;
        Fri, 21 Jul 2023 17:28:57 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.5-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <871qh1ivam.wl-tiwai@suse.de>
References: <871qh1ivam.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <871qh1ivam.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc3
X-PR-Tracked-Commit-Id: 5f69c65e07b99ceb113d304fe31e0c653eb1c4bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3c05547a5fab4ca2777afcb61a69ce68f5ef8a6a
Message-Id: <168996053732.13720.15730676791130076297.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Jul 2023 17:28:57 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Jul 2023 09:21:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3c05547a5fab4ca2777afcb61a69ce68f5ef8a6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
