Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566747A2A51
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 00:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjIOWQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjIOWQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 18:16:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCC69B;
        Fri, 15 Sep 2023 15:16:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FE4EC433C7;
        Fri, 15 Sep 2023 22:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694816173;
        bh=usNx1AmDqlYUyktDDyCy6lRyOMLsDsZCu/ri9VBv4C4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kA/nrGqvhybOmL3SnLMRfbwwuzskbjF4RuXVJiiFnumfT33Y3rp8O8J0S5sJlW7Fi
         EsA+h7dUg2kY+3Yko7PxRJz/eHwCfcEZBT0AT5yp+/aDNDAMWczgnGYUkmKuOeDvyr
         iqDNdzWgQexid4VubCk+GaJdOO2rwH51Enu+hc7b/FvDgyldRFWaN7BO6mxOmmPOuZ
         PXczDtIDbmZSVkOM1RBubis1w7116bHt64OPND8YHC3+N5XXN1BY/lcHC36WG8UeGz
         AbJKst+WirBSPi0fUsGAfP1gqWOXHNnh6nsHfpMxgVKWyLvw4K0QPD3mlxewDVmUKw
         eLZRW9dL10uWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45D20E26881;
        Fri, 15 Sep 2023 22:16:13 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.6-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hyW71qjqqMK2dkcVuxq5=U3gybUTKbLQyq-tsWiHR+dw@mail.gmail.com>
References: <CAJZ5v0hyW71qjqqMK2dkcVuxq5=U3gybUTKbLQyq-tsWiHR+dw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hyW71qjqqMK2dkcVuxq5=U3gybUTKbLQyq-tsWiHR+dw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc2
X-PR-Tracked-Commit-Id: 148b6f4cc3920e563094540fe1a12d00d3bbccae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4eb2bd24756e0c8e254de8931ba7ee4346e75bbc
Message-Id: <169481617328.11838.7907575726419614964.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Sep 2023 22:16:13 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 15 Sep 2023 20:32:50 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4eb2bd24756e0c8e254de8931ba7ee4346e75bbc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
