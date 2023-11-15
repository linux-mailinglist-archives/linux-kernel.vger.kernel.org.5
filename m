Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79DB07EBCA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 05:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjKOEjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 23:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjKOEjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 23:39:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5027D9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:39:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FCF3C433C7;
        Wed, 15 Nov 2023 04:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700023180;
        bh=vD8xd48fGSj0VLvs/CR3rwhwJT17H2fs7skFX0I4B0U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RDKWzbZnRxl7u0bM6sdrF+nL4OZnzJrZXiIDerM8aI1nVPHR8SP6iY5OVdOO4eHUB
         TGLppqgym8dGRIVB3DJ0UjcGxAFdY1zqrwxTyEU/E9/qUS3Xh/VpRQ8CSExIvfSZNX
         IkC4rR4RgQq3kk4xr3O+CalWeJq2XU2/nIyxym1Sfcc2tGtBE7HrU4SvMm8/18JEWb
         VpNM92HuY4CNs6pHCBIShUnlv2pSnRcLi88ma1CLmVfdCzFTmVEj9yodQK1Gy1ZR07
         XGjs5JZ/suHTasRYsVkVup5Gt90nRAyhbmBncnmdB4TC1zvxoik8T1vNxk/MjnYoYM
         QpvR9RjYSHaVg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A3C0E1F670;
        Wed, 15 Nov 2023 04:39:40 +0000 (UTC)
Subject: Re: [GIT PULL] Zstd fixes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
References: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <11692A57-6A65-4ADE-BAE3-169D50A1FC16@meta.com>
X-PR-Tracked-Remote: https://github.com/terrelln/linux.git tags/zstd-linus-v6.7-rc2
X-PR-Tracked-Commit-Id: 77618db346455129424fadbbaec596a09feaf3bb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 86d11b0e20c09e0a91cd2aa57b115000274e2ac5
Message-Id: <170002318029.2906.18018730633430949680.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Nov 2023 04:39:40 +0000
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <terrelln@meta.com>,
        Nick Terrell <nickrterrell@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 15 Nov 2023 01:17:19 +0000:

> https://github.com/terrelln/linux.git tags/zstd-linus-v6.7-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/86d11b0e20c09e0a91cd2aa57b115000274e2ac5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
