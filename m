Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA16784C53
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 23:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHVVyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 17:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjHVVya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 17:54:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23857CE9;
        Tue, 22 Aug 2023 14:54:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A642764E5B;
        Tue, 22 Aug 2023 21:54:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0824FC433C7;
        Tue, 22 Aug 2023 21:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692741268;
        bh=sJqXutSgC//zgI4hXJUwnEiJlh+8W37ld4qLii5cSMw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=WIliOhbh2h+fhqxrqwnzJAmi0QRqcjRfNNT9Znaq5NvpGRkV8Wdroiy3igeXLMMHi
         utWmFqIQXAzJv0c9fWrjLE+CoRo324brge7vxTWS0K76hpLewSS8Izn3sBwPj4TQyb
         ktpYVjffeoM4hyJ1Fz9sXREVH+94vtyKyg69bbFQXoJAP4LO0/urGpM58Kgn5whANk
         dQzpY9avwZHbLhIyRCp46kRnMvmE3wKZaPnPJvcuzFLRZJjlLf3qlJ5YvVb8Z6S7c2
         bPTFqCcwrppI9wiLJdShE4c602INopJqqaD84FMbWnBiPvtpnAGzOnxyig7dB3yZEs
         yVHpxEqQpcZxQ==
Message-ID: <97907bf752178a29995ea608846f7b2b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230705065313.67043-3-frank.li@vivo.com>
References: <20230705065313.67043-1-frank.li@vivo.com> <20230705065313.67043-3-frank.li@vivo.com>
Subject: Re: [PATCH 03/13] clk: axm5516: Convert to devm_platform_ioremap_resource()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Yangtao Li <frank.li@vivo.com>
Date:   Tue, 22 Aug 2023 14:54:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2023-07-04 23:53:03)
> Use devm_platform_ioremap_resource() to simplify code.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---

Applied to clk-next
