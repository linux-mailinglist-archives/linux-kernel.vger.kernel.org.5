Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436FF7C8BA9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJMQkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjJMQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0B8BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 981CCC43391;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697215196;
        bh=8fSs8AJtEmy9n5PjW2LDrfGx+3CafPXXlym29DLZvVY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cri0Z5dvVPAjlOGMQzka79X5vxTh6Aov+tINOzgN6uKgY5RNFv3VZsoWTBFC5MovT
         HJf2EOInYfdsnUfxWeppe50G7crSZutIV5HuV3V3XxR/+B3IXxqY+mJEuXsLZiuU4h
         nbanxKemSgbjgT2N7IZb5xNkT3tVbiYI+mYvIHCJz6NEkmV7xzG9XMdZ2/G5O4rD2+
         Cn2LGjUsiDbaZTEC+7Y8qTeAUjw7GT9+v81mI41YdsiiPDW8rJt0PoV6O3Sv88wCFc
         jAXEiENhR4cMc3A20ybQdHWwW3NMrZ+nRUSptqkyevJES1RkSiXOAlV5CSQbL51PNB
         pYkPLvBJiVnTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C485C73FEA;
        Fri, 13 Oct 2023 16:39:56 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
References: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0gcP2o_mDOyWP_C3u+6nHqT8gXFhUxGHSC7OgywBXsNMQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc6
X-PR-Tracked-Commit-Id: 9bc2fb9a7e41542a193658deff3df572fa24cb68
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad7f1baed071f4536d7cfc32834a36d61c512c70
Message-Id: <169721519649.5219.443378342249328036.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Oct 2023 16:39:56 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Oct 2023 17:39:29 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad7f1baed071f4536d7cfc32834a36d61c512c70

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
