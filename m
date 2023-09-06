Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E190794185
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243275AbjIFQ3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbjIFQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:29:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6A1BD1;
        Wed,  6 Sep 2023 09:28:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55EA0C433BA;
        Wed,  6 Sep 2023 16:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694017667;
        bh=NyPX85OIByWTaXLBBp2pEqZ5jaMk2qVgHLV8Qt23pzw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Dktcs5AVwcbFCCiqPXl9/W8P63SiYnoaKxoPg5VdlYO3FO3+PInPhsk2CUrEGPwSs
         wb4gvObsddfGs3p/tsLhHyAWrdOx8cOaBXKLPZdCgFtXJZlyTYm0NIR6x+wRaRBjK6
         kKth5oeNQqjhb+jkINXWZX0DhdxwYQ5cZNmz/VUA05k6HY+IwVGsmXH14G3baYuQl1
         WPRd5xSov/FfK3bztAlUheE15GOtPo89RbA0fiys+6oO68o+GEecRUGdOlc5ygbdXI
         RZPUTWtYCtyWqhYUs7DGoD4gQhCe52pqRJO9ElAKuA0M8whehhgLAY82qRX9Ip2ZNn
         k+fnZ15ITX7JQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45329C04E28;
        Wed,  6 Sep 2023 16:27:47 +0000 (UTC)
Subject: Re: [git pull] Input updates for v6.6-rc0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZPeTYcsVQ7/M4Bue@google.com>
References: <ZPeTYcsVQ7/M4Bue@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZPeTYcsVQ7/M4Bue@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc0
X-PR-Tracked-Commit-Id: 1ac731c529cd4d6adbce134754b51ff7d822b145
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 744a759492b5c57ff24a6e8aabe47b17ad8ee964
Message-Id: <169401766727.7147.14910356339732057460.pr-tracker-bot@kernel.org>
Date:   Wed, 06 Sep 2023 16:27:47 +0000
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 5 Sep 2023 13:47:54 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.6-rc0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/744a759492b5c57ff24a6e8aabe47b17ad8ee964

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
