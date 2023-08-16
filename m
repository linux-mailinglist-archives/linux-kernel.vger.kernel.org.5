Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E325C77DE00
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbjHPJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236747AbjHPJ5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B498C1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:57:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B41246172D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F1CC433C8;
        Wed, 16 Aug 2023 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692179864;
        bh=VzGbxxOxqX3FveB7Cwc5bnCZAs+hVt5An36y0m+khVg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=OKE73bwMORTp4RWdKHXleqrbgb6jndZ6mp2/82deGDXe5hEfTkzOBu+en5R5/EcUA
         hFDPguoEsJYOO3iG57bagB4vti1eGFkaAdpWdN5Hap5rdGNTD+F7BYtZ5fX8oSbVks
         UM+JE6tKBVjj4je7k1B+3eC8Y0Tz93yU8q4yjhB8mZzkFeKX/rOwoQqSYYrxLHkz1K
         nFdg27NFbvq2Wn6cy0MFS3/4GhncQ3AWmMx3jZq5zLbpiRwZqC7daM/BrWJSqJpi1c
         d3LR/C4na68UwU1qgeot6tEOhiitDSRyYvEIgTIARKKaMEemwfJA0l/fkjrhZSOvQj
         jimP0h6touPTg==
From:   Lee Jones <lee@kernel.org>
To:     cw00.choi@samsung.com, krzysztof.kozlowski@linaro.org,
        lee@kernel.org, Yue Haibing <yuehaibing@huawei.com>
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <20230728132709.27052-1-yuehaibing@huawei.com>
References: <20230728132709.27052-1-yuehaibing@huawei.com>
Subject: Re: (subset) [PATCH -next] mfd: max77686: Remove unused extern
 declarations
Message-Id: <169217986287.819879.16995591576429587767.b4-ty@kernel.org>
Date:   Wed, 16 Aug 2023 10:57:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 21:27:09 +0800, Yue Haibing wrote:
> max77686_irq_init() and max77686_irq_exit() are not used since
> commit 6f1c1e71d933 ("mfd: max77686: Convert to use regmap_irq").
> And max77686_irq_resume() never be implemented since introduced in
> commit dae8a969d512 ("mfd: Add Maxim 77686 driver").
> 
> 

Applied, thanks!

[1/1] mfd: max77686: Remove unused extern declarations
      commit: 23f033eb371762d7f8d78172ab0bddd4d3bec626

--
Lee Jones [李琼斯]

