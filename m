Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37D078CBCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 20:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238223AbjH2SIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 14:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238329AbjH2SIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 14:08:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D920BE;
        Tue, 29 Aug 2023 11:08:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A684637D9;
        Tue, 29 Aug 2023 18:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9274DC433CA;
        Tue, 29 Aug 2023 18:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693332484;
        bh=ZyPsmIS2Cm+wi5YcM+gke2+Ai5X4XjkmHCVmzkwmQIw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ns1TH7qM3eXyfok43NRdgawLxGEOaHGtNlYBD2mpNTVgWZ23/4tBS6Io8VODWm9qS
         aG7L3UJNEOYApSY5hmbo4xVVADgapbGmVAAQqPdpA7hCac9yuK/QQs/YLHy241VpTm
         eDR9WxohhZUr+BcVoEv+Eht4o6jZGHrTsscdOpTSxTAwHD9hgejBegdDVNzKnz/csL
         7yJ37t8Es9gOu9vtF/C16rLG2fQSq74tExDqF6fKln5FzGKA+Ux/cJx3A2uxeC6a2c
         9mCb7YWm8jTI9aTyszPfCrumXGm89g3E1Svoeo3hk/ITYK1AA6+8eglJWzggdvTwae
         qATwSR+x2DLRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80CFBC595D2;
        Tue, 29 Aug 2023 18:08:04 +0000 (UTC)
Subject: Re: [GIT PULL] power-supply changes for 6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230822231742.nccvz5kkvono4fvt@mercury.elektranox.org>
References: <20230822231742.nccvz5kkvono4fvt@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230822231742.nccvz5kkvono4fvt@mercury.elektranox.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6
X-PR-Tracked-Commit-Id: 7e6311f04b41174ccc738d37dcb4b93cd4de98b0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b547f9b30091bbd91f8ad2c89db277425db812f9
Message-Id: <169333248452.16601.9152495590923132280.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 18:08:04 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Aug 2023 01:17:42 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b547f9b30091bbd91f8ad2c89db277425db812f9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
