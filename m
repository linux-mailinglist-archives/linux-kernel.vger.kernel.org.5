Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E566D78316F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHUTu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHUTu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFBE191
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 12:50:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C25A617C5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 19:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2594C433C9;
        Mon, 21 Aug 2023 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692647424;
        bh=l21jyS5O0oNWGTJLfguOmgrxUI+/nVs0sYO7EfUDV8k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FrLg8r0A1sSKxrFG1uJaSjiyv3TCStCN5XVCeJOLDhhcsZu8olIR/gLD9Awz/fJNI
         dy8BAdy6TD4lXvHunbaXcAj3re3mxxFhebO8N4ogaSvWb9mulC2l4RIq79Nse+snUq
         HflOta+mP8YQMn6ceCevrQ/ALAW7h0THLQv0KTwq2krjiTTINdG9gQgRQ0kAiUd684
         ho+D7GcWtKWCK7+vq2fHY06QrBrZ8ave+b6tDFjkJ5LBpFqrU0YAsUvOMpTekT4JHO
         TgTqc04RyuaOUvBiFnqIKmMPZtL3BZpcfd5qjZ0Js3qnMQpSZxSRKsG0gLeDMhMEZU
         ZQUUSpYh9FYcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB519E4EAFB;
        Mon, 21 Aug 2023 19:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: doc: fix description of
 max_small_discards
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <169264742382.19522.12501255260452886690.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 19:50:23 +0000
References: <20230730142552.3918623-1-chao@kernel.org>
In-Reply-To: <20230730142552.3918623-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 30 Jul 2023 22:25:51 +0800 you wrote:
> The description of max_small_discards is out-of-update in below two
> aspects, fix it.
> - it is disabled by default
> - small discards will be issued during checkpoint
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: doc: fix description of max_small_discards
    https://git.kernel.org/jaegeuk/f2fs/c/726865e69aa3
  - [f2fs-dev,2/2] Revert "f2fs: do not issue small discard commands during checkpoint"
    https://git.kernel.org/jaegeuk/f2fs/c/005abf9e5e0d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


