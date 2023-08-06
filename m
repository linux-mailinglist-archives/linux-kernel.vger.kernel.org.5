Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91F771382
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 05:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjHFDyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 23:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFDyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ABB1FD9;
        Sat,  5 Aug 2023 20:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A05760F2F;
        Sun,  6 Aug 2023 03:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE33C433C8;
        Sun,  6 Aug 2023 03:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691294079;
        bh=umI5fqtycSsTyWc4yh3zJRP5W+kUF6xzbhYpY3Oijyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXSTLvhC3xOfdHU0H4xjMpHpG5RSvVVeaSxbjYR6za+ReqcNzSce+N86ZtilTJ8xw
         300Tw9CoiKBkykqG9BJ4T5UUoKEPbOjh3Dyh7AwgG2QJEIzVDZdZ8GiH4Oxhow5Nss
         EZt1IKsCvfctlD9l6RjbuvYl7Dmex3pzhFpzE8TJqG8ikJGjGPPQ03I/j7nLnWWCcc
         jsgK0qeiHfCeGeR7a0uOouA4OHYpoovB4kbNSEReP7osnW7jSp54COsz54IfJNAe3s
         d84G1L5Zym+1MN2V92/HgRN6r8MKjeUndFWM3wyDDyXFvZZtwRf7dsZZaTZEQjXrvV
         c1ZpXle4RRE6w==
Date:   Sun, 6 Aug 2023 11:54:28 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: nxp: mxs: split interrupts per cells
Message-ID: <20230806035428.GB151430@dragon>
References: <20230730111539.98210-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230730111539.98210-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 01:15:39PM +0200, Krzysztof Kozlowski wrote:
> Each interrupt should be in its own cell.  This is much more readable.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
