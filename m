Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EDF7DFDBD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 02:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377807AbjKCB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377812AbjKCB01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 21:26:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6387199
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 18:26:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C85BC433C8;
        Fri,  3 Nov 2023 01:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698974784;
        bh=XxffFIxAm/UKsZRJVwJJxcCpXT//kTE4XXT+Px7Pq8c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CnDTBQSSXTMygN0cPHVwL+dV8kb7IJT9i0iFFMuGJSmpTYc64xPgvSHGq8sPBjeJ8
         SexSlCkvA3WjWRHkvkbm2dMs+XnBAuyqgdhCHmE2YwGSLEfuXZTcQpD5vo8ote12xd
         l3j5+NXStGyetmqtunjmLC8fSm78DZjDsHldZUM3tVy/HPeOHAWD9F3GrQHCpD6FFl
         +8kGNLLB84PCjpENnjxJXlO6ImnuEKd2c2xarMTQctw5KyZpBEu8DqatveBuAc/7N6
         hR7aMBoief5dtMNscrkhh8IOLo19rpTBIEYYqmi7S369ggns2JndpTA4AYgLWdRrWY
         WiQPGiGSRLjRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6968BC43168;
        Fri,  3 Nov 2023 01:26:24 +0000 (UTC)
Subject: Re: [GIT PULL] NVDIMM for 6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6542ec7ae6233_4dfae294bb@iweiny-mobl.notmuch>
References: <6542ec7ae6233_4dfae294bb@iweiny-mobl.notmuch>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <6542ec7ae6233_4dfae294bb@iweiny-mobl.notmuch>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.7
X-PR-Tracked-Commit-Id: 9ea459e477dc09370cdd8ee13b61aefe8cd1f20a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90a300dc0553c5c4a3324ca6de5877c834d27af7
Message-Id: <169897478442.31710.4152001454645612862.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Nov 2023 01:26:24 +0000
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Nov 2023 17:25:30 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git tags/libnvdimm-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90a300dc0553c5c4a3324ca6de5877c834d27af7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
