Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD807DE708
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjKAUuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjKAUuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:50:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137B310E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:50:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB4F7C433C8;
        Wed,  1 Nov 2023 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698871813;
        bh=8QH+7VPPsFbTsdsKuK8k6K0Cpsk0u9xZbDsgrrDR49E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g0nPZLVjcfXkK1pJCUsk5K7L9L8pmDJD8U7EIpQQNee1lDUnYr6plH0MW3ko8ZMg4
         igKuCbZaAHjT8UXqwA1aa3NnVgEGHQ+PL+WiQLHHfVQ1bQgyNVGZXiNi7H2YM/7KXe
         VyMBRoy0QZujQoiW3wOLcveOB6c2xlZhrfpl5NIr3/1ZX5gDN+sJd45kgMTvxsQqE0
         mT68lGB7ri7R6+FLeUFCXceA8WlKUUIaC8hklySKzpb8rzlJwC5Unx60MfhXQko2b9
         u/vas4VgY60kRV5fGerDn3Z6UIW2dh3jDWKtO4lpL4NUfxoLMCRv8Ap23Dew1Ddhl5
         IvSf8lJ2+ybSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0AECC4316B;
        Wed,  1 Nov 2023 20:50:13 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZTv_N8NKLb0ifLAj@arm.com>
References: <ZTv_N8NKLb0ifLAj@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZTv_N8NKLb0ifLAj@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: 14dcf78a6c042dd9421b11485b394c6273568bca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 56ec8e4cd8cbff3c96c53cd8303bba924613b5ce
Message-Id: <169887181378.2957.8035749981527699297.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 20:50:13 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 19:19:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/56ec8e4cd8cbff3c96c53cd8303bba924613b5ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
