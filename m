Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D182E7DC0F5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjJ3UFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjJ3UFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:05:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072DFCC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:05:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BCCC433C7;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698696340;
        bh=wLp8OHmDsYZqQvYrmDZDmxOH+XMPSfAm1E7ffIiFgSI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eiY3fT+3hTAsImFt11RZHrpC0Fpvm+J5HgNiWTtxVUA5vd+F5IKSMJhPFKsbU3/XO
         XrxxnR5IucPj5ndzKxo4kPf8aVb7GQ8Yw4Fsp1Eots5pKR89/I/0NBk3IIcm6Uj4+L
         BtqX6X0aYFDrNxKq5aT42EqEo8238fVfrU4o/Vh01Oya8Y/5Zi8XSvL39/hvMgLx+O
         IwzZSnBKyVNhuPuNWJr/hGJ+UJRDrgtT+dLOaVT5evffESzrhIgXCj90mX+7NAxgsE
         pqnGvOWJ6niHUnF5695NgTvw219pqCbGtdLj38xOP5xyafJnP5iIzUD1JEA6j8ZBdQ
         5+cLup0Zq9veQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58534EAB088;
        Mon, 30 Oct 2023 20:05:40 +0000 (UTC)
Subject: Re: [GIT PULL for v6.7] vfs misc updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20231027-vfs-misc-7ebef2b5a462@brauner>
References: <20231027-vfs-misc-7ebef2b5a462@brauner>
X-PR-Tracked-List-Id: <linux-fsdevel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20231027-vfs-misc-7ebef2b5a462@brauner>
X-PR-Tracked-Remote: https://lore.kernel.org/r/20230926162228.68666-1-mjguzik@gmail.com Cleanups
X-PR-Tracked-Commit-Id: 61d4fb0b349ec1b33119913c3b0bd109de30142c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b3f874cc1d074bdcffc224d683925fd11808fe7
Message-Id: <169869634035.3440.6255914098831091774.pr-tracker-bot@kernel.org>
Date:   Mon, 30 Oct 2023 20:05:40 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Oct 2023 16:30:46 +0200:

> https://lore.kernel.org/r/20230926162228.68666-1-mjguzik@gmail.com Cleanups

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b3f874cc1d074bdcffc224d683925fd11808fe7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
