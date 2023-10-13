Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E357C8BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJMQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjJMQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9684DBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 416B9C433CB;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215196;
        bh=9HQ4VQprAjSSv7dfyxg1rYfMiJzuYlLnBqm37mh41k4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q0tWX/vap1AjI9zfXiLnsszWRfWZM5U1xUkowkTVIgM+tNqdUOa5FX98zcOxyu82s
         FNNEqu20wDRliJuqQByc+62U68usIAiaf7+fqYjaM25ZDIuIXCbcz0JXu0Erd+iMBa
         hznEQg69o0W3RnlK3yKAFsfAmuKGoyMp1nH/4vcnbunyqpHI6bP/mCRK6yW8EBG1+r
         Wb+sMQMqigxcbIGsPg/0cbzox5IbaS+pIZ5cy2wOv52+G9lH0nuRaCcE72udKABp+f
         hnSG/AcMUsrsvEoAazbZ2vRKmmreZDvGE2YWunwHoe4JEaufPl0SEleERhchhq7SkF
         RNW6F5gZlA5qQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 261E2C691EF;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
Subject: Re: [GIT PULL]: soundwire subsystem fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZSlLpvkzvDUEzR1M@matsya>
References: <ZSlLpvkzvDUEzR1M@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZSlLpvkzvDUEzR1M@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-fixes
X-PR-Tracked-Commit-Id: 3b6c4a11bf2b810f772f5c2c1ef6eef3fc268246
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17325a2137ebf015fbb988a6db1a3513ef446d54
Message-Id: <169721519615.5219.8204974114510160573.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:56 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 19:22:38 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.6-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17325a2137ebf015fbb988a6db1a3513ef446d54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
