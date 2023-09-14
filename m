Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6617A0BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbjINRvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbjINRva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:51:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80864CA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:51:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20E44C433C9;
        Thu, 14 Sep 2023 17:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694713886;
        bh=Y+TiaH7nEnTtK97dGbzl74ozQlGiijQHhK1f2rwQW7E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bGO8wioW8L0iq4AGp8ea3npwiqdVu0vAZ1c70dkebiY95CNaC6yKj8/rYnTq04NRc
         bj8Jlmrr8L4obkKum/X3+VS+A5RlE3vJVLdBciW5zg3pDZQNpmUR0e6yVARekCZvdY
         Rzv5/DKRB8VfMsiRHiVF907h5V4L3BZzEHXqwE7njvmTJ/Q/DS+DJ28ApuO5c9vgTV
         B2KvxSmkmu1M3fPHcA5SnpI9Rc2yRDsLeRkct55lLkUBb3P95jOI3W6X4MicRXszDC
         EUMIKR3UmKd9Lgwv0rrReN4DLoMliXi6QzUvVPDVL8e9fO2LfDLOS78CGiPiZiV0hv
         bq44hNk4GbOww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06825E22AF4;
        Thu, 14 Sep 2023 17:51:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for 6.6-rc2
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169471388602.12217.8215674538813373212.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Sep 2023 17:51:26 +0000
References: <20230914131626.49468-1-pabeni@redhat.com>
In-Reply-To: <20230914131626.49468-1-pabeni@redhat.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 14 Sep 2023 15:16:26 +0200 you wrote:
> Hi Linus!
> 
> Quite unusually, this does not contains any fix coming from subtrees
> (nf, ebpf, wifi, etc).
> 
> The following changes since commit 73be7fb14e83d24383f840a22f24d3ed222ca319:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for 6.6-rc2
    https://git.kernel.org/netdev/net/c/9fdfb15a3dbf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


