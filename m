Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9619F79D9F8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 22:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjILUUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 16:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjILUU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 16:20:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1322EE4B;
        Tue, 12 Sep 2023 13:20:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCF6C433C9;
        Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694550025;
        bh=hHFOxkwWPUtRzqpYo757WoZUZn4Twmz5EfGjFfx3rb8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S10YmzMZz4XIQRC3fXmBgknQ8g7X57k/VJQPqviJOj0AgPZAzlCTwEoysB/nJYQ0w
         d9PL6WUaqmQrMnLRkEvpxEpNqTFdjyQhNCU0NRpIUipMdYnBD5shVdxXBI33GAJmzI
         9/TxL9HwbbN0TitzSn21gZNAKoi0xbVakDz6PBZ8jVGaMtXAapIWgxoJTCDHmaafIF
         9P2xa6hf7S8qk6W2AilFxrpWLck8k0tmOGQqzQ/xUHHXXdmqH8BoY9FTDWN8oqGdxe
         igoD0VA3DFyDxFmd5F/78zUVmwmQBbqXKRhOj3uLzWPIjtSifPl9ffMP/zQfnU/ScA
         CCBXDJm9l/39A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF15C04DD9;
        Tue, 12 Sep 2023 20:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Fix a erroneous check after snprintf()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169455002545.29579.9098192345328945185.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Sep 2023 20:20:25 +0000
References: <393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <393bdebc87b22563c08ace094defa7160eb7a6c0.1694190795.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, void@manifault.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        bpf@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  8 Sep 2023 18:33:35 +0200 you wrote:
> snprintf() does not return negative error code on error, it returns the
> number of characters which *would* be generated for the given input.
> 
> Fix the error handling check.
> 
> Fixes: 57539b1c0ac2 ("bpf: Enable annotating trusted nested pointers")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - bpf: Fix a erroneous check after snprintf()
    https://git.kernel.org/bpf/bpf/c/a8f12572860a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


