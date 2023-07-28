Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FE7766A2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjG1KX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbjG1KW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D33A93;
        Fri, 28 Jul 2023 03:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 915FD620A6;
        Fri, 28 Jul 2023 10:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE88C433C8;
        Fri, 28 Jul 2023 10:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690539775;
        bh=+vEJnzBoP95jYYK6wGhSJU041hNBp2P06AHOmeiwTNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVM5OXJXY/86BAFVJ4pQ5MP/VVU0iYrFjfDFQ+FXWrZq6ZlsCStFTjMRQjV90LU8s
         ha6aj6+hWF/Xg5zApaE9RV/6RtjTES1HuUy2d1huhjt5rTtUVF4z18/IukElI/sGIz
         ImiWz0EBqdwABNoUw/x/eAMf/fNGXy1LnMCK0uVjvQkoBYH2mORpKyjxDwMEqHFrps
         hGfZ4xZymitLFy4j6MZGPp4RVoYbC1Hx7na/EOKhYHdb2WILb1ZYUhhWQVD8+LzPdi
         7n1yutgPx1OTHzh6BCenYKlDijE9vHtKWj4cj0TuzO1ITkHn38cAhLQShVuSdwF8Gk
         LZXsXBhgWoggQ==
Date:   Fri, 28 Jul 2023 11:22:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC
 drivers
Message-ID: <20230728102249.GI8175@google.com>
References: <20230714050313.8424-1-krzysztof.kozlowski@linaro.org>
 <169053368548.11881.1252357994598966736.b4-ty@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169053368548.11881.1252357994598966736.b4-ty@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023, Krzysztof Kozlowski wrote:

> 
> On Fri, 14 Jul 2023 07:03:13 +0200, Krzysztof Kozlowski wrote:
> > Since few years no one is really paid to support drivers for: Maxim
> > MUICs/PMICs for Exynos based boards and Samsung PMICs.  Correct the
> > status to keep them as maintained.
> > 
> > 
> 
> Hi Lee,
> 
> I sent it around two weeks ago. It wasn't picked up, so maybe everyone expects
> me to take it via Samsung SoC... so I took it.
> 
> I hope it is okay, if not, let me know and I will drop it.

It was on my list.  Going through my backlog today.

No matter.  Keep it applied.

> Applied, thanks!
> 
> [1/1] MAINTAINERS: mfd: Un-support Maxim and Samsung PMIC drivers
>       https://git.kernel.org/krzk/linux/c/eecff3319287179032600eeec5fa357a53ae0fe1
> 
> Best regards,
> -- 
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

-- 
Lee Jones [李琼斯]
