Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C38D78BC37
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbjH2AqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234703AbjH2AqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:46:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D37CDF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12BD160F9B
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 731E9C433C9;
        Tue, 29 Aug 2023 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693269958;
        bh=0vGQSnrFQJ8tul97xo22ndGOUAnX/nRTnbzSDZHd/t8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Fdp5q0GVFS6yDzmDJRbgkUZWWOXLDNzIUQcTv8QwxsSayPOW01rkCd1U+w6MFNR0V
         30jvFxYFMUPGkjllHLkbul09PrVOkcFI+8NIJMaHlaRQsG9nAtMuSozzsa6NUnML8o
         WfAoRqX2ysoleB8fniIIN7HxtMhUrBXkmjCLbBkwUhJk8K1FR+ZaZr0VQufaFEQi3Y
         yyc+TfvwsZsi/Ng74qe/BrUwWgi6iCvEQzP3/lFUGfNQdFASziozMliDAqShNC7iU4
         j0mIGNts1oMQR/Xt1k82wXRoRMYRzyzjbJwIh++zK4SFnIrgJFcYzESurR46TFfYSe
         cssDDo04QJmdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FA62C3959E;
        Tue, 29 Aug 2023 00:45:58 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828163723.GB27321@willie-the-truck>
References: <20230828163723.GB27321@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230828163723.GB27321@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream
X-PR-Tracked-Commit-Id: e1df27213941725962f68c64349bbcc60ece0314
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 542034175ca715d28522a59c1f88a58349f2765c
Message-Id: <169326995838.22794.14416400055663721551.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 00:45:58 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 17:37:24 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/542034175ca715d28522a59c1f88a58349f2765c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
