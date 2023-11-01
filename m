Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5347DDC26
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345172AbjKAEXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345136AbjKAEXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:23:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B827B7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:22:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3F4CC433C8;
        Wed,  1 Nov 2023 04:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698812577;
        bh=2MuD9zhZoCqjfIxWqE+olsLCB83ELKKHot1JvxWFEDA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l2vcVUlVaCDfc2CxsICmeswXtu7gnZueMGYwTG3/o3AAb0/vG1XypJ/rtt0SsCoDO
         KBHSPBotyI/iAvnGT8xJSNbdlakAw7UJIUFWo9gnMJ8jro4GNeya7S0m+VebOq/Uvx
         zheG8hB/H1ycTEg4Zr8Yc5q4dIq2n4SaQ4Ymo9yfmOdfKntE95WKuuR2sBgGXExr22
         qlEzmyiC6BBzqKmta3lva1DGefI8acBdH+DxsD5j0tLXZsMIMxSqQ5kQes+65xjIPc
         clFgEnjrQMlZDbd0sS5ZoP2Cd4MvB2jmTbsCnKznPKCP+pNzyE+Ky0VxWV7PMnAgyn
         UMFVXhHqzAQPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0B2BC4166F;
        Wed,  1 Nov 2023 04:22:56 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for v6.7-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b7cfad$q4fr49@fmsmga002-auth.fm.intel.com>
References: <b7cfad$q4fr49@fmsmga002-auth.fm.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b7cfad$q4fr49@fmsmga002-auth.fm.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-1
X-PR-Tracked-Commit-Id: 94ace9eda88229c73698b8dd8d3c06dd0831319c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 59fff63cc2b75dcfe08f9eeb4b2187d73e53843d
Message-Id: <169881257691.5224.2392176109310897040.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Nov 2023 04:22:56 +0000
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@kernel.org>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 14:43:48 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v6.7-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/59fff63cc2b75dcfe08f9eeb4b2187d73e53843d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
