Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C897ABA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjIVU2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjIVU2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:28:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9DA19E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:28:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C772CC433C8;
        Fri, 22 Sep 2023 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695414483;
        bh=4E1DoFpsX4Vhf9ILzR7P7NP9E5YwvJIqnKKyxEeJBNs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Moq35vnU8jLwcZdnGFi+ZeyCemh45a01Q2PtlaVzBOwpt+4nx9DiJl5xrlGgyeEwo
         xveB6EJ1l6IDEybykCV+DpLSQyIjrV4S5ruO5NsWznVYRmFKA9selxglhSfZ8Q8Ajg
         vNwHO14+TrZFVH4xi239jzPBCH9ZS01QnGok3lIHa17i7bDNf7X8hnX4Z5clOhjpwM
         mYvKyvf325bVBpFwzVvW2DOj53H/A6Ip3SZf/wng085+gKC/UkQViCxgJlxc1oINvI
         OZ6+EDQAKtqbqXNXL4O48l23ADuCLOsPP01dGt0dxGzcCJff4B7zEzeH5UE8rhiqsX
         KwQ/ROCAy+efw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AD3CBC561EE;
        Fri, 22 Sep 2023 20:28:03 +0000 (UTC)
Subject: Re: [GIT PULL] ACPI fixes for v6.6-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
References: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-acpi.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iYLvO6VbzKo0-1sbpuVGF=Y-y2ajoRMMz+wAO0RTUNLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc3
X-PR-Tracked-Commit-Id: a1001c37f83b30a75c17796b453769773b71f9b2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b184c040dc393296301ee2fa522f44ad61237d68
Message-Id: <169541448370.12920.15632829553792685525.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Sep 2023 20:28:03 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Sep 2023 20:23:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git acpi-6.6-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b184c040dc393296301ee2fa522f44ad61237d68

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
