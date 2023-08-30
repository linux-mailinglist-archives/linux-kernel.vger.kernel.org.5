Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECE378DD88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244896AbjH3Svg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbjH3SAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 14:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF285193
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CA1160EFE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 17:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F23ADC433C9;
        Wed, 30 Aug 2023 17:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693418396;
        bh=kKfFB2KqhhP+C++Xpm2C79HWqRXggjdb0KE4H8TOm3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JhMH0weErUnMT0dLnVh+6W0CIag0Kf375O2uvwLcVB59+xMRw4DD1PSo26Ad0R28W
         aGsEtWP5sGPMA0lKpyaSkBDySNxH7XJc/IkaCwsKL/Fv19ECVkLu7vjBO8iwwo5NW3
         bt9rrbwcqlSy5DrH9Xg/J9JsmRtx7smTE/jZU5H2WCL0E77yEnfDnXkgCQUJep8BhR
         /JftwwCj0he3YsD8tBKCN56lZLb+wjF0C80/cHXPfltAdUaI4h1RT+AtjyhXp9bZPe
         IaUzq0JkKn7gZlanV4ZhPw9l+O471FPuwAXaftXR3m1ynmHa5DVmKUuc6/ukYa88R3
         Q1On+IzukgFxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E17C64457;
        Wed, 30 Aug 2023 17:59:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mm for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230829202013.2380560-1-dave.hansen@linux.intel.com>
References: <20230829202013.2380560-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230829202013.2380560-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.6-rc1
X-PR-Tracked-Commit-Id: 54e3d9434ef61b97fd3263c141b928dc5635e50d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9855922705630a63a6f27621fab1a248dfb5bfc0
Message-Id: <169341839585.6352.10636606382131440221.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 17:59:55 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 13:20:13 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mm_for_6.6-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9855922705630a63a6f27621fab1a248dfb5bfc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
