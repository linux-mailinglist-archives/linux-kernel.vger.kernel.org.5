Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D74E7A2A52
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbjIOWQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237487AbjIOWQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D32C1FE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 15:16:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07B05C433CA;
        Fri, 15 Sep 2023 22:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816177;
        bh=96yOo0eNEdiwWbqdiB033KWnWm0HOg2txkK7PIoSDJc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=haW71mXTeAnT2MCBF3dqZFw2xIWe+FkulMrgURDduQRKit/0B1LTF1IlNB5e2XPNy
         2HLiHaaZgFXidhAF5zT528hK+uTxjNjR4mXzy++fwPHqCfpiEe54+HRRch23bUopFQ
         xAZwxX4hCknTRq+3M9g1kxaCxsrZNA8veztQnwljDSSMm26eXXTnAj/fKcitGoPgXD
         3gTVSMxntS4R5aLRdZ0eqr8I0VT9RN6nPzIwIsKqvJoQpcjAth3IpLMI+qH1PfDZjn
         fD444keiBeRQrvwJvp4GLMPPr79qGUN2asGTFadiWjUERWgAZ2OiaQwPzwtu6BjHcx
         bjBXQxSJZSwQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA213E26880;
        Fri, 15 Sep 2023 22:16:16 +0000 (UTC)
Subject: Re: [GIT PULL] firewire fixes for 6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230915100128.GA140388@workstation.local>
References: <20230915100128.GA140388@workstation.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230915100128.GA140388@workstation.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.6-rc2
X-PR-Tracked-Commit-Id: 3c70de9b580998e5d644f4e80a9944c30aa1197b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e494be7c557829344fd5a89d038864efd888c43
Message-Id: <169481617695.11838.14353129913923179709.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 22:16:16 +0000
To:     Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 19:01:28 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git tags/firewire-fixes-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e494be7c557829344fd5a89d038864efd888c43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
