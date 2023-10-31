Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A7C7DC6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343543AbjJaHCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343540AbjJaHCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:02:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C6C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:02:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 008ABC433CA;
        Tue, 31 Oct 2023 07:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698735759;
        bh=KXzkegad3kh288pTt/zobLL7oSZxwhaR+dWiFy9NHUQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AVHznTGUcuhTbYao6csR/N+7TJAwwblryYTRh18XyiEITU1YNHDPWMR7Nr+uQ2ag1
         HeOClMsZGv+Bs8hhhDv117Tpyb8YEJPGFO2o73bWwiulFveuiLyZgiXPya7j1Ckr0L
         IvoQcPUGRobhURwNv36Oeo+nNsipP/hd7K6hgafthhKb9sSZwNNGs/q2V3IfeYx+ky
         0n1O3DVLSrmGPrGsB9cA4FumZbp/qukk9Z2mVux2cffWKPECtNfmwRRWhomu7Hly6a
         cgfZgea3p2v0yJkha0PG3RYfwKm7MD+TkpLJWn/5y5769mj64z8wZqtoEBPTc510DI
         l35GfWXo/tM0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB773C4316B;
        Tue, 31 Oct 2023 07:02:38 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue rust bindings for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUBOgm4uS5t0-qV3@slm.duckdns.org>
References: <ZUBOgm4uS5t0-qV3@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUBOgm4uS5t0-qV3@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rust-bindings
X-PR-Tracked-Commit-Id: 15b286d1fd056b0366bc8d211ff2c4ce2449eacb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 639409a4ac8e1578ce34715338c6a4ddf9941294
Message-Id: <169873575889.30696.11225013739546361474.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 07:02:38 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, aliceryhl@google.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 14:46:58 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rust-bindings

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/639409a4ac8e1578ce34715338c6a4ddf9941294

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
