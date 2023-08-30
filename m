Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96E578DF80
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242292AbjH3TLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343696AbjH3Qeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:34:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0458F1A1;
        Wed, 30 Aug 2023 09:34:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9768762344;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B463C433C9;
        Wed, 30 Aug 2023 16:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693413268;
        bh=4EkbyiQqZCQSgvNA9++cFsaH9/JdKRkPKkSwB36Fodk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TuiBTiYRYcrRs+KkjVnDQ2ufS8Wug/i+0Ly4GN45tg8M59cwfVF1eDtmgrBUi+fAo
         gJHW+9RBnyXelSGWIAaMKuzurRaR41xBbkvrw7y4cbHxwyrYdsCI79db+WtWphmwJy
         w72nf9iwDSno5UDj+FuLMzjIE/jHeA9j7aDL9tMTLI+tpAQoY9Us1gExAQqmE4HRUV
         XLmbV91T+YVqioOk8Jyrzm3fgAiILCnVMkSUs7dr/1ku27OC4i9knAED7rL/OU+gt4
         pOarTmVMCQ+LKQJgu7nV/9H0UKkSNJi6TWHwEG0QH6WEu7EB15aeGlDP9xv8WdHonc
         AjwUrS76ANxZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE1BEC64457;
        Wed, 30 Aug 2023 16:34:27 +0000 (UTC)
Subject: Re: [GIT PULL] LSM patches for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
References: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHC9VhQQqQCdcSdb7G8v1ZHU8zn0XJZ6hS0rbGufAuZyPSCDCA@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230829
X-PR-Tracked-Commit-Id: 8e4672d6f902d5c4db1e87e8aa9f530149d85bc6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1086eeac9c333b6db6c98594f02996c8261c60c5
Message-Id: <169341326797.28213.17744891790601094390.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Aug 2023 16:34:27 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Aug 2023 19:37:26 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git tags/lsm-pr-20230829

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1086eeac9c333b6db6c98594f02996c8261c60c5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
