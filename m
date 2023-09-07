Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6330F797A3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbjIGRev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235776AbjIGRet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:34:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560DD1717
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:34:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDCCFC433AD;
        Thu,  7 Sep 2023 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694107959;
        bh=/7fYH3Y0LZhswgcm57+IQIf6ouCwqmKcs0oP3ZAss10=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HiEfZt7L1UaD35I4QVIbhGgaKmX2+KnsiGPmgCxlwfYd1hkhWXa7RI7LAMIRwSD9H
         DBAzMYuPOEtcEWxuz8WRErYeKrL1xbswrmHQ0U5m9vEDI2dKv6Y9eILXWp1gd54GjZ
         c4NvSXlo+yT3i/lvawVFr1AbtBRLtKkzwmnDcXOs7xVAe8z7d9e+4kwn7BLSvEezpm
         P5cSWVED8eS50nS8TJlqPjr2pLLCaVi0rN865Yc9VnmroP9UkRdtDgCm9qunQypPSC
         TeyIUeftVKAPsotKff+2KrPZQ28gSnUYu4o5FCvVxsnKessm/cZoY78H1zZ8sKOc0F
         3WxWOTQ+D0Hdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B8E8FE22AFB;
        Thu,  7 Sep 2023 17:32:39 +0000 (UTC)
Subject: Re: [PULL 0/2] xtensa updates for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230905200559.2824671-1-jcmvbkbc@gmail.com>
References: <20230905200559.2824671-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230905200559.2824671-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230905
X-PR-Tracked-Commit-Id: 03ce34cf8f50e4c62f9a4b62caffdba1165ca977
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dd1386dd3c4f4bc55456c88180f9f39697bb95c0
Message-Id: <169410795974.539.16789039728160268229.pr-tracker-bot@kernel.org>
Date:   Thu, 07 Sep 2023 17:32:39 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue,  5 Sep 2023 13:05:59 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230905

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dd1386dd3c4f4bc55456c88180f9f39697bb95c0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
