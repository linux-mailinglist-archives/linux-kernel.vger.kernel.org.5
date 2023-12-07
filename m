Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2178092B6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 21:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjLGUrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 15:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjLGUqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 15:46:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77476172E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 12:47:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13EA9C433CA;
        Thu,  7 Dec 2023 20:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701982021;
        bh=X0PvhlJ9Zpv509l+FBtouy25Q8cF3X3e67x58a3iWI0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f3+6xF7QPRplZkvGHWY7KHOw87S9wFRz9peGwAOBctbIHZKLHTuRxQ8wzyC+XQpeb
         eokoH+EvE8XNKMeoVuBeZBV0jE4gFdOaFBppyHRij31c1iSI0IhL69H2H/Pph1B93L
         qaEh25dBkitj84gBK3+U757YKMXE2O3cTQ8bRZFnZJnJtmGDu0e3V+BJCqIoFHSpkh
         GJvP/v3brdfS3LbY72hTWVVnwl/W1iqIaUW4jYwdppaEaTo9zdCANQ4vYaT/jUzhuy
         nh9ABjJC5bPxYYDWgEeE9rmsuaUMFdTEows3i5Kz520pGMbwHx7e45CYq23yByi1iY
         C1drfGMQASsZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F3828DD4F1D;
        Thu,  7 Dec 2023 20:47:00 +0000 (UTC)
Subject: Re: [GIT PULL] workqueue fixes for v6.7-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZXDLJZ42TGL9LlM9@slm.duckdns.org>
References: <ZXDLJZ42TGL9LlM9@slm.duckdns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZXDLJZ42TGL9LlM9@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rc4-fixes
X-PR-Tracked-Commit-Id: 4a6c5607d4502ccd1b15b57d57f17d12b6f257a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e0348c1f686a939222a2cbe7f3861e356b60d9b6
Message-Id: <170198202099.1554.11669541048383039509.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Dec 2023 20:47:00 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 6 Dec 2023 09:27:33 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git/ tags/wq-for-6.7-rc4-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e0348c1f686a939222a2cbe7f3861e356b60d9b6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
