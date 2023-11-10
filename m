Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314577E8364
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346173AbjKJUFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345950AbjKJUFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:05:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17874C6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:05:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF9B9C433C7;
        Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699646739;
        bh=/jl6i8srD7waf9oj8kIBuYntX4MMxg67ik6LqMlQt4o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uv6ogq/ep7kvaTAkjmLYG31miH+TwSz11LAq7kzHhtgXjQDqy3W4EFq1xve6foHvM
         GYP4V1s9w+/8BT2zNNauBXvElC2EsmCCF/ZQ2OPUtG3nWBCSHtNoNBR5LO4I5qDizV
         l2JW61l3xyg8lram8RahyIc5+T4IbXJVTpbfQrXsxP1ZCqg/8KK5t7Mt3Ju3kxbPax
         W6N9Mn0ntLj19u5QAwTxx0N68eqL7T6Nbc+3oX6HUngv1DH11b9WfxUHbhUHIOjbkq
         d7IzagE/l+IE8Ck8sJ7F9KLIdVE6W3Dc1fJVvp+FL2ihrZEo6hxiQvKHa9waDZjH6i
         0hacM5KgHOPWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CAB9C43158;
        Fri, 10 Nov 2023 20:05:39 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.7-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231110122638.21897-1-ulf.hansson@linaro.org>
References: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231110122638.21897-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2
X-PR-Tracked-Commit-Id: 015c9cbcf0ad709079117d27c2094a46e0eadcdb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b456259e1544daa337fa00cda8bd3bea04c8d914
Message-Id: <169964673963.27739.1534219333572049881.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Nov 2023 20:05:39 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Nov 2023 13:26:38 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.7-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b456259e1544daa337fa00cda8bd3bea04c8d914

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
