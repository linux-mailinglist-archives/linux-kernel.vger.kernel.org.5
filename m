Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B5678BC40
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjH2Aqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjH2AqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:46:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F9DDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AC9617F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9F94FC433C8;
        Tue, 29 Aug 2023 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693269969;
        bh=L2PRBTeOKR+7M/QKw/98wz/qZ1tVlM9fzBUuu6iHO8E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vQJFdNGh2r5F5XgNgEuF9lDi5F5MeaP9Dvof7FBr163nJKoJelF6FxljYjfCj2TfQ
         mAsvGDxBkma5bafkaBmf5srXHfAzhtvkEocPLlIU8LKTlPutPtpKnqzo+DBTaFUhwA
         fG32XUpsp7AsP7/597NYJHzcER64bSgSgJW0tOEdtYT5OqexPhiJWIN4GyDIWdAayZ
         c7SMdukv6zuUEday3M+LhPC60E0Wjnw6OIPg+F6qmAEfDcvjJtltMbPTjgwhejj1XZ
         j+5eoBlsFUk8NUym+3Y6ov87UK04+UF2eIUli36MaMjuxUebm/2a7X2vo4mpLwUdeP
         bKdTuiKeSo4Kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D7C6C3274C;
        Tue, 29 Aug 2023 00:46:09 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230824143626.10100-1-jgross@suse.com>
References: <20230824143626.10100-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230824143626.10100-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6-rc1-tag
X-PR-Tracked-Commit-Id: f8941e6c4c712948663ec5d7bbb546f1a0f4e3f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6383cb42ac01e6fb9ef6a035a2288786e61bdddf
Message-Id: <169326996957.22794.12711316433156812278.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:46:09 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Aug 2023 16:36:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.6-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6383cb42ac01e6fb9ef6a035a2288786e61bdddf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
