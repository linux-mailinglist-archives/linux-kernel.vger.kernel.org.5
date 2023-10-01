Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EED97B49AB
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 23:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjJAVPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 17:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbjJAVPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 17:15:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4892C9B;
        Sun,  1 Oct 2023 14:15:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E0646C433C7;
        Sun,  1 Oct 2023 21:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696194917;
        bh=e923OdFXLWDPy5SyXCEQvZixtu5MHewlxAd2FFJoXSU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GcmuQtmEERTCwsMjNaAmgCuj+uAPFOOU8996UidfLlrUiJ1DHtiGmlVjP6tRfraKq
         m9FSjaWK/DTNf6xnnyX+ot1/TUMW8Q3dPzB+S8agnT0qCIFuUYRjSuoe5JFZV29WOi
         zwcxps/xT/0J12ceAhCLUxKE0nQbrHcJpgMVffKyIHDujgCJ3841mpX9hezJkI0Uvo
         zBKOeFjR33+v8FFSFMFcTE4sfeud1YslyFAptXE9/3K2cENgrtH5obmU06/LkkmYxm
         xk8TBJi+I5t6Qy6BjaUGqAE7vZoLk1+Ed0Y2MPZnFu2W8HwbFqroO1y32kJNzxZkkn
         fyQUGuUUTk9ng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CC441C43170;
        Sun,  1 Oct 2023 21:15:17 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.6-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231001083937.5f401972d99dc3168e6d4218@linux-foundation.org>
References: <20231001083937.5f401972d99dc3168e6d4218@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231001083937.5f401972d99dc3168e6d4218@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-01-08-34
X-PR-Tracked-Commit-Id: e2a8f20dd8e9df695f736e51cd9115ae55be92d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d2c5231581d636af8d5af888ee13048dfbb438c7
Message-Id: <169619491782.22414.10510049330176555849.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Oct 2023 21:15:17 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Oct 2023 08:39:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-10-01-08-34

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d2c5231581d636af8d5af888ee13048dfbb438c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
