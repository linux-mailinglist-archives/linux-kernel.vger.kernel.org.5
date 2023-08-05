Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994F3771260
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjHEVbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEVbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270A8134
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE05560F40
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 21:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02702C433C7;
        Sat,  5 Aug 2023 21:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691271108;
        bh=LwVSf5E2rTZspyIsnpTRtHx3oVtF00aIGMFChodPePE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AQczrQjn2I523a77DS0Rm592b+0/GAWOqJ3o1zY7yiCxNNkeWrhqgbbjKVmHyEwX6
         NDgWf5qIl0XOxJEINbQzWvqlhjDGXWrzKiQnnuPnzRSLhqYdKzvTw/9y48utVIpGSk
         clVozXdN4Zf5bGpeElNo41a+u994yagPUl+rGQhWIaoVnsyG8K/991lCp3O9ZtL+Hx
         TlMPUcEsfURBEESppk5DunWzZuMiiEYooKWoCn+iHWplkcStDN6hfS7e7nzhTRQAwl
         g3gifiSzoiRjFl6BuCe635Xjq/UMuN9gVE1AX19oXZjNlwXsPAC+qzNnHH+0k6B4ny
         b/31HYG/aaVlw==
Message-ID: <14fa33e2-d993-8d9e-7e81-12f72eddc380@kernel.org>
Date:   Sat, 5 Aug 2023 23:31:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: wlf,wm8960: Describe the power
 supplies
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>, broonie@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Fabio Estevam <festevam@denx.de>
References: <20230803215506.142922-1-festevam@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230803215506.142922-1-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 23:55, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> WM8960 has the following power supplies:
> 
> - AVDD
> - DBVDD
> - DCVDD
> - SPKVDD1
> - SPKVDD1
> 
> Add them to bindings to improve the hardware description.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.

Best regards,
Krzysztof

