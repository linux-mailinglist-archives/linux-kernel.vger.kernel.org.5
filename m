Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B787A3722
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjIQSZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjIQSYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:24:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06B133
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:24:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABC70C433D9;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694975068;
        bh=aR33/4Xq6ojBlt9d3Dy8UUD5PsvyFInsXK0LRbJVg/s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a3PLb2Tx6IQON0aXsdAKeL0i7+XdoNhG6aEG9aha8hH3OcfcDlAdk+kxSV69XnvH9
         INTsBXst8zq2Pvzjw2dPYgbCVVCmuS0v98Z9sgi5D2P6mVyk3MA7aL9vjRVcD+VTBX
         K1vzpGdmayHuC7FFfT438liixWWBEpC4zv8ZPeEj75IM1tGzMS+xPB9VcGFEnl/Pqp
         zgj0gBa32GhIq7Zqc+x+j8siFR8k/F9Mwx7eXsURIRxxHgiOArQV6x14ls+oW6tXag
         5JhspEL8+rhSTqbjKI0FCrtFDY1G0ggsLeV7FT5bWKv2mbGXet5f5P2jFRQzko/NWe
         DX46Gz8jEs3Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 991D5E26888;
        Sun, 17 Sep 2023 18:24:28 +0000 (UTC)
Subject: Re: [GIT PULL] x86 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZQc68JA/nusWELFK@gmail.com>
References: <ZQc68JA/nusWELFK@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZQc68JA/nusWELFK@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-17
X-PR-Tracked-Commit-Id: 75b2f7e4c9e0fd750a5a27ca9736d1daa7a3762a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e789286468a9ea7acb5aae09a11bdfc7d46874ec
Message-Id: <169497506862.30007.9809024283007781897.pr-tracker-bot@kernel.org>
Date:   Sun, 17 Sep 2023 18:24:28 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 17 Sep 2023 19:44:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2023-09-17

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e789286468a9ea7acb5aae09a11bdfc7d46874ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
