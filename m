Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7575AB97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjGTKA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGTKAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2433B4;
        Thu, 20 Jul 2023 03:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67104619F2;
        Thu, 20 Jul 2023 10:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98A0AC433C9;
        Thu, 20 Jul 2023 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689847221;
        bh=kI7QNuEAZe5hsZGSYU4LFc9o4hX+RTJ60091wATYuFA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Tk96alwFbFBBiABRLOVJcRUqKDIGrN3/mtZdO33gPxf1vwP+KWN9eJ2kptc4SqKoU
         ZqHi8o81ckNwKjupf+InMTXwKAjzGa6gIIMjT2/7DkGkvNYa3LIQ/qGHpR2CrZwcWN
         kqE9om5xE02iXhBdH406l84gyPusSd2kgQhOak0yKL0IOJXMgGf+ayL66WJImT1ibN
         0vtC+3wbQrYAjp3aQ/Y7obWxG5eOFD9pER5letRkXSEBcLfcseLx+y1QwVuBDMQrgw
         UZycPO19BW3kGLqf/opcnEXMaLlVceXwFdIn3PA+sIznjGvJ1lGfZv0Xuar0e4PbtJ
         I5v5tGzFMHeiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7581AE21EF5;
        Thu, 20 Jul 2023 10:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: Fix JSON pointer references
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168984722147.11486.18313899802299137410.git-patchwork-notify@kernel.org>
Date:   Thu, 20 Jul 2023 10:00:21 +0000
References: <20230718203202.1761304-1-robh@kernel.org>
In-Reply-To: <20230718203202.1761304-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jul 2023 14:32:03 -0600 you wrote:
> A JSON pointer reference to the entire document must not have a trailing
> "/" and should be just a "#". The existing jsonschema package allows
> these, but changes in 4.18 make allowed "$ref" URIs stricter and throw
> errors on these references.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] dt-bindings: net: dsa: Fix JSON pointer references
    https://git.kernel.org/netdev/net-next/c/cf3e913bf41d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


