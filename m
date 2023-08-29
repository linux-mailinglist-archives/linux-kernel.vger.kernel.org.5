Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1378CF7C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjH2WXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239530AbjH2WWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:22:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA801B1;
        Tue, 29 Aug 2023 15:22:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60FBF61C3C;
        Tue, 29 Aug 2023 22:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8869C433C7;
        Tue, 29 Aug 2023 22:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693347748;
        bh=Bc1EImhtsKbksYEvB9mjm+Pyi/9V1Z3NTf6HT83qGOA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pHScyV4oNl+0s2NL8SEzbbHpbe+ZmsFOQdFGdD80+QZ2ueIg32b6r7G5tpPYB7CWn
         hQHgT8IZfcYlDkS0EyLSDnSOvvidLm4R21Ue9Vm07JfWfc3qlaJntk5/FXqcmsDk61
         ormPXN277E+ckhzqUAzrsRd+M5THuN1eoNsGnWTAGdc32O4oEehJH6qNDKmyW0elfD
         f7/PmdmTdFuJgSMcyEK54PAVVetxpSZGknGh+fmGPMzWHsLPupB2lyM49wp/qAcuqA
         6k2NHDc1Y5xhtg3mG0t+NCXO4kGczsvKzDvp/dlwzjYUkd0/V4849HSAK86pcz+NH6
         EGjX0F/UKnxGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6681C3959E;
        Tue, 29 Aug 2023 22:22:28 +0000 (UTC)
Subject: Re: [GIT PULL] non-MM updates for 6.6-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
References: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230828225431.354d3d2d3b80ee5b88e65eb5@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-08-28-22-48
X-PR-Tracked-Commit-Id: dce8f8ed1de1d9d6d27c5ccd202ce4ec163b100c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d68b4b6f307d155475cce541f2aee938032ed22e
Message-Id: <169334774873.2777.6931429632954735806.pr-tracker-bot@kernel.org>
Date:   Tue, 29 Aug 2023 22:22:28 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 28 Aug 2023 22:54:31 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-nonmm-stable-2023-08-28-22-48

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d68b4b6f307d155475cce541f2aee938032ed22e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
