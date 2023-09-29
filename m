Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0057B37F5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjI2Q30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjI2Q3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B0A1A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:29:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F1B5C433C9;
        Fri, 29 Sep 2023 16:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696004960;
        bh=9ilI3+Qk2zrVcsjZuTWibQer+8NLndYultJ9OZ3GMSw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qzNVwxXMZ/5M3gmOk2902v64a1O+T/adiV4GVZsFoOuJxkZI2jzdOmprJS5NLhPIg
         Ip/jaXBzuVc9DqgSjjdyk/CGOJM78XdypR0vXN7sJoAmgAebKSqDYjGbYV0+U3KqBO
         WBR7TKzySF1ZnZ6DCn2EoTxPxrW0m8f7jIFXDMRMdCxqAWL5V5Z4W1d0Fy8G52ow/O
         dNFPTlB9OXO1gaQIB0nVaA0EaeksuvET7uSJ2+gUh4z+AMoHDOrYT41lMBTakpf1ad
         RJAklTl3RQqws6UE1KJWI4gEPKmlDIcjKrK3FBsofSyalLs6jUFgO4Z0EzY05GgDgv
         iOTcFvOlTCRQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BE69C395C8;
        Fri, 29 Sep 2023 16:29:20 +0000 (UTC)
Subject: Re: [PULL 00/16] Xtensa fixes for v6.6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230928184924.164748-1-jcmvbkbc@gmail.com>
References: <20230928184924.164748-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230928184924.164748-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230928
X-PR-Tracked-Commit-Id: f54d02c8f2cc4b46ba2a3bd8252a6750453b6f2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b02afe1df518369dd322f48b49e50efc49250575
Message-Id: <169600496024.31534.8063028904087235113.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 16:29:20 +0000
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

The pull request you sent on Thu, 28 Sep 2023 11:49:24 -0700:

> https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20230928

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b02afe1df518369dd322f48b49e50efc49250575

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
