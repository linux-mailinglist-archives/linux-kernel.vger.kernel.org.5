Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C827EF470
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjKQO3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbjKQO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:29:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E549BB9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 06:29:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F2B4C433CA;
        Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700231342;
        bh=I1XhoPZtPxXF01V98MdcLMnFAzO+5biFg2g20krFUFA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YaJoBV6NeCP1BpvkKget2wnvzIZtwCPI65xMLdVGpSL75sSyeOHyHHmEOgjG40EIt
         cYuwa6bXQ+3DQs5ypjFqucnNMe6tYNbgaY/tRTHEuLSKVGDbCSq5p0j7/BvFjzdsQH
         sOrlo0kcJj1ZUtDtxPkuO4lhiUnPPC/FSko2u1XlMsduJF5k/KLCYEA9NcCW8zUsSR
         kvHlnC2s7Am4Q7D/DlRYAtpehrFmQUi3f0H6MvTqv37qnvgz16Bnmc9BQIuJ5AO9dC
         bdrDDHvuyE0Js9b9O0yZDVhogS77n5R9ebuTdff+k82Zv/lVHxAJXLYFhXdQW8+d3a
         IM0a8lU8hRvyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DFBEE000A4;
        Fri, 17 Nov 2023 14:29:02 +0000 (UTC)
Subject: Re: [GIT PULL] audit/audit-pr-20231116
From:   pr-tracker-bot@kernel.org
In-Reply-To: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
References: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <b12021b40ddc40827782a4f55f7111e2.paul@paul-moore.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231116
X-PR-Tracked-Commit-Id: 969d90ec212bae4b45bf9d21d7daa30aa6cf055e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf786e2a78d4d3cfc87469c3b31ade257df14fa0
Message-Id: <170023134218.28622.4308618844091006554.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Nov 2023 14:29:02 +0000
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        audit@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Nov 2023 13:36:15 -0500:

> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git tags/audit-pr-20231116

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf786e2a78d4d3cfc87469c3b31ade257df14fa0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
