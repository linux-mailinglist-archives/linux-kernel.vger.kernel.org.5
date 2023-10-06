Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55A407BC284
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbjJFWv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjJFWvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:51:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC35B6;
        Fri,  6 Oct 2023 15:51:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4445AC433C8;
        Fri,  6 Oct 2023 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632682;
        bh=j652Gqnm5RMXSEocjqqYIeJBYBsa0Gx7jopD3zxKQDc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d50HWmPCW5wnb4kwLQ701Scmonh0bY0oEZTTh1HhIxqLXDe6eXVqsaIktX05Z6/Xy
         hYd1nvcVzrDNJ4saWefdX0FzhiqsUnKBEkhreXzQ5kna6IYu0bXCbzDQ6lrmRbvDuX
         kHm0XwCatug1wHA6gwiYDwVjlEa5aT3vQ9dbFIzF+F1Sx3XBTZmFRglfCl7BynriFO
         /uMcD4ykqr/SfGn1eaGjh7CdSk036wtRem6kfO48KoOORoEJey6sPApcYpg6pQqo0W
         +/OU9QOSrsDLqaBEWZqhq8edYmJAlrtNRFkVxtjFiPNROZ0qocpNjXurKLvYABykaJ
         hEIHCALuXO53Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 324F6C41671;
        Fri,  6 Oct 2023 22:51:22 +0000 (UTC)
Subject: Re: [GIT PULL] Power management fix for v6.6-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
References: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0hwHxOO3qbrLrxkXbJgy2Wrz1BVLXZqKdwFZKzkPd9mEw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc5
X-PR-Tracked-Commit-Id: b21f18ef964b2c71aa0b451df6d17b7bcad8280d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 82714078aee4ccbd6ee7579d5a21f8a72155d0fb
Message-Id: <169663268220.26682.7770011256259635795.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Oct 2023 22:51:22 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Oct 2023 19:17:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.6-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/82714078aee4ccbd6ee7579d5a21f8a72155d0fb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
