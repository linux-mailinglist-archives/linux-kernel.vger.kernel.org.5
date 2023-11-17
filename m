Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46697EF30E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345808AbjKQMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQMyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:54:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD8FD4E
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:54:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7672C433C7;
        Fri, 17 Nov 2023 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700225689;
        bh=jgQc5Itelpk92zM45YpqFlo1y4VJI+dnHxsnMdw3FZY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg7fSaYXjkW0T93Lpe/n79IhrWlBC15Gxd2bhh9VEEQTsdCNzpOFxXBHZ9Mid9MJW
         uaZTpS/4fSrgMvOFG23qHmqv9SJ/UfOHoIu4EaC4U8esmvFCFcsH0fzhhjVPXehKcG
         PpW5zmsMlu9aSPBUhrg+7bhG7dt2wEjy1zCa7Hlt8Rh2G4rPy+m1Oy8+qgoXKrEb8j
         xr+0tpSZ4D7FYlBUygvGx0OKU8ccQKLVhTg7Cse9Yn7G9aaLpq8zhRBNHWMv9Xa1gk
         hKtgr78XHjGXL2+BQDh2uKxmRtxlIwf7WttNVWLMy03Mu/e2nmSIrcbafGiDjz/clC
         VWZTNDXKG4aSw==
Date:   Fri, 17 Nov 2023 12:54:41 +0000
From:   Lee Jones <lee@kernel.org>
To:     =?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>
Cc:     Samuel Holland <samuel@sholland.org>, Pavel Machek <pavel@ucw.cz>,
        linux-leds@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>, Guo Ren <guoren@kernel.org>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Heiko Stuebner <heiko@sntech.de>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [RESEND PATCH v7 2/5] leds: sun50i-a100: New driver for the A100
 LED controller
Message-ID: <20231117125441.GC153049@google.com>
References: <20221231235541.13568-1-samuel@sholland.org>
 <20221231235541.13568-3-samuel@sholland.org>
 <c3ae7d79ab81621c66e939d804ca41e97eab79fb.camel@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3ae7d79ab81621c66e939d804ca41e97eab79fb.camel@apitzsch.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023, André Apitzsch wrote:

> Hi Samuel,
> 
> there are two more things to change, which came up recently. See below.

Please remember to snip your replies.

> Regards,
> André

[snipped 600+ lines]

-- 
Lee Jones [李琼斯]
