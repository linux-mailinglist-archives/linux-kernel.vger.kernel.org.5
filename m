Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB2F7B5C59
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 23:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbjJBVHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 17:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjJBVHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 17:07:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D6CC8E
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 14:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32C5AC433C8;
        Mon,  2 Oct 2023 21:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696280848;
        bh=kjPrjoUe/9VuBTxdCJiHRgzOyyuCd4jD4rV4hRN+tsw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SjVXRtivZGX567fiL4ehhhsnK+c2HZNUjddqpt9xjC8uwjHhLv/kjsr1ED/OSbBMj
         J30yeGhAOdZ/eWiSW5Tb9DwvaOB/BmGiy96tc1aZMmsqw4JuNKs3jzhNgSCjCVgg95
         /bYovtpUjdg0yViZZ5UbNmeIDrLxqj/nSAmhIzNBZCRZw9YcywytIHo4sbPJbfPL2m
         Q7YARBMcYjCg4ziHY/30XqXvoech5Xx05kSd5X/u6ZTJVnkRTk+m6TGHssPgFvbKzC
         8oqGZqAeimj1zSx3ecHY8weUsLMGWAi9jWl+av1jS/AIeWkuG8l8QSU/vme26MBxUf
         a0stmNactEDxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D2A8E632CE;
        Mon,  2 Oct 2023 21:07:27 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM Fixes for 6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ae3d980a-21e1-4d66-a7a3-7d5f6dc32b9c@intel.com>
References: <ae3d980a-21e1-4d66-a7a3-7d5f6dc32b9c@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ae3d980a-21e1-4d66-a7a3-7d5f6dc32b9c@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fixes-6.6-rc5
X-PR-Tracked-Commit-Id: 33908660e814203e996f6e775d033c5c32fcf9a7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a9c2be4f3730961fdda03d226d783e444babe6f2
Message-Id: <169628084711.24746.8482866309886255471.pr-tracker-bot@kernel.org>
Date:   Mon, 02 Oct 2023 21:07:27 +0000
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     torvalds@linux-foundation.org,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 2 Oct 2023 10:25:42 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-fixes-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a9c2be4f3730961fdda03d226d783e444babe6f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
