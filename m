Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 502E77DC6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjJaHCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343530AbjJaHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:02:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331B8C2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 00:02:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09DDCC433C7;
        Tue, 31 Oct 2023 07:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698735752;
        bh=Qv70C+G0MHGS+TkKdYelm8+m198Y5NdfL9cgr4mEo70=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ApTE+HvI+MMApOBn23xVLeLFF7pC8xoQPKwb7AL+1+Cb2N48UvMtS84s8dbK2K9j8
         dej70Bo3Upt8HKS2Dvxh42YkHvf0DJ60rXM04ZC0Ga3+cL3yi6xC5qH7Wm54tPHGrq
         /eB0RS7wJ6DDJ8g8nJNvwnoiX2rqUSj2dMVYbj004JhuRgwEUeO2lNOKMMLa8EU57M
         IfIdlYodm8Cu1dMfneOWZmZqPAslzDyLUOKTYkGA21BkwIJfEZpbohLNbaEK6TbU1A
         CHZlJTTnBhHevE/1sR1qVP/j3gPj166PzlQXfmMBq4Om/O6AMxoz/9+RLchqOnNNz7
         zOwCz+UINxf+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E2C5AC4316B;
        Tue, 31 Oct 2023 07:02:31 +0000 (UTC)
Subject: Re: [GIT PULL] cgroup changes for v6.7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZUBVRmaimsnGY09k@slm.duckdns.org>
References: <ZUBVRmaimsnGY09k@slm.duckdns.org>
X-PR-Tracked-List-Id: <cgroups.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZUBVRmaimsnGY09k@slm.duckdns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7
X-PR-Tracked-Commit-Id: a41796b5537dd90eed0e8a6341dec97f4507f5ed
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a6a09e97199d6600d31383055f9d43fbbcbe86f
Message-Id: <169873575192.30696.8945234866104018704.pr-tracker-bot@kernel.org>
Date:   Tue, 31 Oct 2023 07:02:31 +0000
To:     Tejun Heo <tj@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 30 Oct 2023 15:15:50 -1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/ tags/cgroup-for-6.7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a6a09e97199d6600d31383055f9d43fbbcbe86f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
