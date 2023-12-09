Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD7380B15F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 02:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbjLIBUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 20:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjLIBUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 20:20:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C6F1724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 17:20:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55879C433C7;
        Sat,  9 Dec 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702084824;
        bh=5Ry9s3W8st1mB3Kc4YiBlMHwC2NLz2LYF5YbyEIvIcc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=m+pwdwK1x3bY89vfkmI3hWBpdhZtgE/YP+1hxLRlaxjxMIY3oephVfs7COfbNoOHu
         t5c1wBIVuByEjtkRPGaRNihDd/oRk7+6Hjj3ON8exJMWny12wu7P59rvJ0s/Whetnb
         JiqGHT1e9plxvA0dpTpcp2WxbmVo29Qfu3EfPcYnP/bmvSwtffCnqOwXOqTEdJvbdR
         u8LjE9t/a3z/BMq5LGxjt6OMsue9wjr2rgmd/4cqs2ZCWLapSVgwhstAktnkW2jZGG
         C6xfhJL8UnnGgRU28ZDI1z1yCA4gvRigZEaBitvLwjKThFDvpeRhRmuHmy0aS82nTw
         Ab7lNV4Y8ogKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39C23C04E32;
        Sat,  9 Dec 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] libbpf: add pr_warn() for EINVAL cases in
 linker_sanity_check_elf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <170208482423.18108.3043597727814423980.git-patchwork-notify@kernel.org>
Date:   Sat, 09 Dec 2023 01:20:24 +0000
References: <20231208215100.435876-1-slyich@gmail.com>
In-Reply-To: <20231208215100.435876-1-slyich@gmail.com>
To:     Sergei Trofimovich <slyich@gmail.com>
Cc:     bpf@vger.kernel.org, eddyz87@gmail.com,
        linux-kernel@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  8 Dec 2023 21:51:00 +0000 you wrote:
> Before the change on `i686-linux` `systemd` build failed as:
> 
>     $ bpftool gen object src/core/bpf/socket_bind/socket-bind.bpf.o src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o
>     Error: failed to link 'src/core/bpf/socket_bind/socket-bind.bpf.unstripped.o': Invalid argument (22)
> 
> After the change it fails as:
> 
> [...]

Here is the summary with links:
  - [v2] libbpf: add pr_warn() for EINVAL cases in linker_sanity_check_elf
    https://git.kernel.org/bpf/bpf-next/c/32fa05839862

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


