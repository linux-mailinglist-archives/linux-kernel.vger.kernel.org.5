Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A721A752C53
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjGMVlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 17:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbjGMVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 17:41:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F199B1FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 14:41:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8562561B83
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 21:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBBB3C433CC;
        Thu, 13 Jul 2023 21:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689284494;
        bh=/F+dionR7vdp3SyJcv0WxofuWRapRmFADCuIWFBlP9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e243fUPTvPX3TRajQn9ZcybPZJeKiZe/onIWGrmYh1mv+apXg6v9M7/+Cn7yACnch
         18Wis2rSvTPSLBIgXbOikfZEVNUU/AzYpuIh6b3AbFXXuComfJpRiIbFGRQN1Dr93a
         cQfaMbxTLyNiMoB3c6eWZJsro7S171/huc4+vFWSPP52G5X+OI0ZLNFDG2smjve88g
         0OJWqf/CFAIlpFpRdpnXvVHlrKFEmlkSKy9/UxHp/eZXgFmAMsaYbVrA8twvFgbEIu
         HNDiWZhfKYNcycdtLfG9yw91M2yjcN2Vz1Luz1PGmCJtPoq3by+s88L39TB/EU8frF
         FRUM4rANQYsIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7B58E29F42;
        Thu, 13 Jul 2023 21:41:33 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.5-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230713121542.4854-1-jgross@suse.com>
References: <20230713121542.4854-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230713121542.4854-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc2-tag
X-PR-Tracked-Commit-Id: 21a235bce12361e64adfc2ef97e4ae2e51ad63d4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 15999328946bd778b7bbf57179ee871dd5279b04
Message-Id: <168928449387.12038.12724884070520325293.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Jul 2023 21:41:33 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 13 Jul 2023 14:15:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc2-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/15999328946bd778b7bbf57179ee871dd5279b04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
